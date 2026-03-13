namespace TraCuuDiemThi.Models
{
    public class ThiSinh
    {
        public string SoBaoDanh { get; set; } = "";
        public string HoTen { get; set; } = "";
        public DateTime? NgaySinh { get; set; }
        public bool GioiTinh { get; set; }
        public string TinhTP { get; set; } = "";
        public string TruongTHPT { get; set; } = "";
        public string Node { get; set; } = "";
        public List<DiemThi> DanhSachDiem { get; set; } = new();
        public string GioiTinhStr => GioiTinh ? "Nam" : "Nu";
        public string NgaySinhStr => NgaySinh?.ToString("dd/MM/yyyy") ?? "---";
        public decimal DiemTB => DanhSachDiem.Count > 0 ? DanhSachDiem.Average(d => d.Diem) : 0;
    }

    public class DiemThi
    {
        public string MaMon { get; set; } = "";
        public string TenMon { get; set; } = "";
        public decimal Diem { get; set; }
        public string XepLoai => Diem switch
        {
            >= 9.0m => "Xuất Sắc",
            >= 8.0m => "Giỏi",
            >= 6.5m => "Khá",
            >= 5.0m => "Trung Bình",
            _ => "Yếu"
        };
    }

    public enum NodeStatus { Online, Offline, NotFound }
    public enum VungNguoiDung { MienBac, MienNam, ChuaChon }

    public class KetQuaTraCuu
    {
        public bool ThanhCong { get; set; }
        public string ThongBao { get; set; } = "";
        public ThiSinh? ThiSinh { get; set; }
        public NodeStatus TrangThaiNode { get; set; }

        // Thông tin phân tán — hiện bảng phải
        public string TenNode { get; set; } = "";   // "Mien Bac" / "Mien Nam"
        public string TenDB { get; set; } = "";   // "DiemThi_MienBac"
        public string ServerDB { get; set; } = "";   // "localhost"
        public long ThoiGianKetNoiMs { get; set; }       // ms kết nối
        public long ThoiGianQueryMs { get; set; }       // ms query
        public long TongThoiGianMs { get; set; }       // tổng
        public bool KetNoiThanhCong { get; set; }
        public string LoiKetNoi { get; set; } = "";
        public string VungNguoiDung { get; set; } = "";
        public string VungDuLieu { get; set; } = "";
        public bool TraCheo { get; set; }
        public DateTime ThoiDiemTraCuu { get; set; } = DateTime.Now;
    }
}