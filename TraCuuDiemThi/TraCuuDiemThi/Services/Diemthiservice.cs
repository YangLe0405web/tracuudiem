using System.Diagnostics;
using Microsoft.Data.SqlClient;
using TraCuuDiemThi.Config;
using TraCuuDiemThi.Database;
using TraCuuDiemThi.Models;
using TraCuuDiemThi.Router;

namespace TraCuuDiemThi.Services
{
    public class DiemThiService
    {
        private readonly DatabaseConfig _cfg;
        private readonly QueryRouter _router;

        public DiemThiService(DatabaseConfig cfg)
        {
            _cfg = cfg;
            _router = new QueryRouter(cfg);
        }

        public async Task<KetQuaTraCuu> TraCuuAsync(string sbd)
        {
            sbd = sbd.Trim();
            var kq = new KetQuaTraCuu { ThoiDiemTraCuu = DateTime.Now };
            var swTong = Stopwatch.StartNew();

            // 1. Validate
            var (ok, err) = _router.Validate(sbd);
            if (!ok)
            {
                kq.ThanhCong = false; kq.ThongBao = err;
                kq.TrangThaiNode = NodeStatus.NotFound;
                kq.VungNguoiDung = VungToStr(_cfg.VungNguoiDung);
                kq.VungDuLieu = "N/A";
                swTong.Stop(); kq.TongThoiGianMs = swTong.ElapsedMilliseconds;
                return kq;
            }

            // 2. Route
            var (connStr, tenNode, tenDB, server) = _router.Route(sbd);
            kq.TenNode = tenNode;
            kq.TenDB = tenDB;
            kq.ServerDB = server;
            kq.VungDuLieu = _router.GetVungDuLieu(sbd);
            kq.VungNguoiDung = VungToStr(_cfg.VungNguoiDung);
            kq.TraCheo = _router.IsTraCheo(sbd);

            if (string.IsNullOrEmpty(connStr))
            {
                kq.ThanhCong = false; kq.ThongBao = "SBD ngoai pham vi.";
                kq.TrangThaiNode = NodeStatus.NotFound;
                swTong.Stop(); kq.TongThoiGianMs = swTong.ElapsedMilliseconds;
                return kq;
            }

            // 3. Kết nối
            var (connOk, conn, msConn, connErr) = await ConnectionManager.OpenAsync(connStr);
            kq.ThoiGianKetNoiMs = msConn;
            kq.KetNoiThanhCong = connOk;
            kq.LoiKetNoi = connErr;

            if (!connOk || conn == null)
            {
                kq.ThanhCong = false;
                kq.TrangThaiNode = NodeStatus.Offline;
                kq.ThongBao = $"Node {tenNode} khong phan hoi.\n{connErr}";
                swTong.Stop(); kq.TongThoiGianMs = swTong.ElapsedMilliseconds;
                return kq;
            }

            // 4. Query
            var swQuery = Stopwatch.StartNew();
            try
            {
                using (conn)
                {
                    var ts = await QueryThiSinhAsync(conn, sbd);
                    if (ts == null)
                    {
                        kq.ThanhCong = false;
                        kq.TrangThaiNode = NodeStatus.NotFound;
                        kq.ThongBao = $"Khong tim thay thi sinh SBD = {sbd}.";
                    }
                    else
                    {
                        ts.DanhSachDiem = await QueryDiemAsync(conn, sbd);
                        kq.ThanhCong = true;
                        kq.TrangThaiNode = NodeStatus.Online;
                        kq.ThiSinh = ts;
                        kq.ThongBao = "Tim kiem thanh cong.";
                    }
                }
            }
            catch (Exception ex)
            {
                kq.ThanhCong = false;
                kq.ThongBao = $"Loi truy van: {ex.Message}";
                kq.TrangThaiNode = NodeStatus.NotFound;
            }
            swQuery.Stop();
            kq.ThoiGianQueryMs = swQuery.ElapsedMilliseconds;
            swTong.Stop();
            kq.TongThoiGianMs = swTong.ElapsedMilliseconds;
            return kq;
        }

        private static async Task<ThiSinh?> QueryThiSinhAsync(SqlConnection conn, string sbd)
        {
            const string sql = @"SELECT SoBaoDanh,HoTen,NgaySinh,GioiTinh,TinhTP,TruongTHPT,Node
                                 FROM ThiSinh WHERE SoBaoDanh=@SBD";
            using var cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@SBD", sbd.PadLeft(7, '0'));
            cmd.CommandTimeout = 10;
            using var r = await cmd.ExecuteReaderAsync();
            if (!await r.ReadAsync()) return null;
            return new ThiSinh
            {
                SoBaoDanh = r["SoBaoDanh"].ToString()!,
                HoTen = r["HoTen"].ToString()!,
                NgaySinh = r["NgaySinh"] as DateTime?,
                GioiTinh = Convert.ToBoolean(r["GioiTinh"]),
                TinhTP = r["TinhTP"].ToString()!,
                TruongTHPT = r["TruongTHPT"].ToString()!,
                Node = r["Node"].ToString()!
            };
        }

        private static async Task<List<DiemThi>> QueryDiemAsync(SqlConnection conn, string sbd)
        {
            var list = new List<DiemThi>();
            const string sql = @"SELECT dt.MaMon,mt.TenMon,dt.Diem
                                 FROM DiemThi dt JOIN MonThi mt ON dt.MaMon=mt.MaMon
                                 WHERE dt.SoBaoDanh=@SBD ORDER BY mt.TenMon";
            using var cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@SBD", sbd.PadLeft(7, '0'));
            cmd.CommandTimeout = 10;
            using var r = await cmd.ExecuteReaderAsync();
            while (await r.ReadAsync())
                list.Add(new DiemThi
                {
                    MaMon = r["MaMon"].ToString()!,
                    TenMon = r["TenMon"].ToString()!,
                    Diem = Convert.ToDecimal(r["Diem"])
                });
            return list;
        }

        public async Task<(bool bac, long msBac, bool nam, long msNam)> CheckNodesAsync()
        {
            var t1 = ConnectionManager.PingAsync(_cfg.ConnectionMienBac);
            var t2 = ConnectionManager.PingAsync(_cfg.ConnectionMienNam);
            await Task.WhenAll(t1, t2);
            var r1 = await t1; var r2 = await t2;
            return (r1.ok, r1.ms, r2.ok, r2.ms);
        }

        public static string VungToStr(VungNguoiDung v) => v switch
        {
            VungNguoiDung.MienBac => "Mien Bac",
            VungNguoiDung.MienNam => "Mien Nam",
            _ => "Chua chon"
        };
    }
}