using TraCuuDiemThi.Models;

namespace TraCuuDiemThi.Config
{
    public class DatabaseConfig
    {
        public string ServerBac { get; set; } = "localhost";
        public string ServerNam { get; set; } = "localhost";
        public string DbBac { get; set; } = "DiemThi_MienBac";
        public string DbNam { get; set; } = "DiemThi_MienNam";

        public string ConnectionMienBac =>
            $"Server={ServerBac};Database={DbBac};Trusted_Connection=True;" +
            "Connect Timeout=5;TrustServerCertificate=True;";

        public string ConnectionMienNam =>
            $"Server={ServerNam};Database={DbNam};Trusted_Connection=True;" +
            "Connect Timeout=5;TrustServerCertificate=True;";

        public int SBD_BacMin { get; set; } = 1000001;
        public int SBD_BacMax { get; set; } = 1000500;
        public int SBD_NamMin { get; set; } = 1000501;
        public int SBD_NamMax { get; set; } = 1001000;

        public VungNguoiDung VungNguoiDung { get; set; } = VungNguoiDung.ChuaChon;
    }
}