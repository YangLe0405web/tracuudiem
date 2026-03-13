using Microsoft.Data.SqlClient;
using System.Diagnostics;

namespace TraCuuDiemThi.Database
{
    public static class ConnectionManager
    {
        /// <summary>Kiểm tra node + đo thời gian kết nối</summary>
        public static async Task<(bool ok, long ms, string err)> PingAsync(string connStr)
        {
            var sw = Stopwatch.StartNew();
            try
            {
                using var c = new SqlConnection(connStr);
                await c.OpenAsync();
                sw.Stop();
                return (true, sw.ElapsedMilliseconds, "");
            }
            catch (Exception ex)
            {
                sw.Stop();
                return (false, sw.ElapsedMilliseconds, ex.Message);
            }
        }

        /// <summary>Mở kết nối thật để query</summary>
        public static async Task<(bool ok, SqlConnection? conn, long ms, string err)>
            OpenAsync(string connStr)
        {
            var sw = Stopwatch.StartNew();
            try
            {
                var c = new SqlConnection(connStr);
                await c.OpenAsync();
                sw.Stop();
                return (true, c, sw.ElapsedMilliseconds, "");
            }
            catch (SqlException ex)
            {
                sw.Stop();
                return (false, null, sw.ElapsedMilliseconds, $"SQL[{ex.Number}]: {ex.Message}");
            }
            catch (Exception ex)
            {
                sw.Stop();
                return (false, null, sw.ElapsedMilliseconds, ex.Message);
            }
        }
    }
}