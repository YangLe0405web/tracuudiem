using TraCuuDiemThi.Config;
using TraCuuDiemThi.Models;

namespace TraCuuDiemThi.Router
{
    public class QueryRouter
    {
        private readonly DatabaseConfig _cfg;
        public QueryRouter(DatabaseConfig cfg) => _cfg = cfg;

        public (string conn, string tenNode, string tenDB, string server) Route(string sbd)
        {
            if (!int.TryParse(sbd, out int n)) return ("", "", "", "");
            if (n >= _cfg.SBD_BacMin && n <= _cfg.SBD_BacMax)
                return (_cfg.ConnectionMienBac, "Mien Bac", _cfg.DbBac, _cfg.ServerBac);
            if (n >= _cfg.SBD_NamMin && n <= _cfg.SBD_NamMax)
                return (_cfg.ConnectionMienNam, "Mien Nam", _cfg.DbNam, _cfg.ServerNam);
            return ("", "", "", "");
        }

        public string GetVungDuLieu(string sbd)
        {
            if (!int.TryParse(sbd, out int n)) return "?";
            if (n >= _cfg.SBD_BacMin && n <= _cfg.SBD_BacMax) return "Mien Bac";
            if (n >= _cfg.SBD_NamMin && n <= _cfg.SBD_NamMax) return "Mien Nam";
            return "Ngoài phạm vi";
        }

        public bool IsTraCheo(string sbd)
        {
            if (_cfg.VungNguoiDung == VungNguoiDung.ChuaChon) return false;
            string vdl = GetVungDuLieu(sbd);
            bool ndBac = _cfg.VungNguoiDung == VungNguoiDung.MienBac;
            bool dlBac = vdl.Contains("Bac");
            return ndBac != dlBac;
        }

        public (bool ok, string err) Validate(string sbd)
        {
            if (string.IsNullOrWhiteSpace(sbd)) return (false, "Vui lòng nhập Số Báo Danh.");
            if (!int.TryParse(sbd.Trim(), out int n)) return (false, $"'{sbd}' không phải số.");
            if (n < _cfg.SBD_BacMin || n > _cfg.SBD_NamMax)
                return (false, $"SBD {n} ngoài phạm vi ({_cfg.SBD_BacMin}-{_cfg.SBD_NamMax}).");
            return (true, "");
        }
    }
}