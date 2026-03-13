using TraCuuDiemThi.Config;
using TraCuuDiemThi.Models;
using TraCuuDiemThi.Services;

namespace TraCuuDiemThi.Forms
{
    public class MainForm : Form
    {
        private readonly DatabaseConfig _cfg = new();
        private DiemThiService _svc = null!;

        // Left
        private Label lblNodeBac = null!, lblNodeNam = null!;
        private Button btnKiemTra = null!;
        private RadioButton rdoBac = null!, rdoNam = null!;
        private TextBox txtSBD = null!;
        private Button btnTraCuu = null!;
        private Label lblStatus = null!;
        private Panel pnlThiSinh = null!;
        private Label lblTen = null!, lblSBD2 = null!, lblNS = null!,
                            lblTinh = null!, lblTruong = null!, lblNode2 = null!;
        private DataGridView dgv = null!;

        // Right
        private Label lblNodeVal = null!, lblDBVal = null!, lblServerVal = null!;
        private Label lblSQLDot = null!, lblSQLText = null!;
        private Label lblTgKNVal = null!, lblTgQVal = null!, lblTongVal = null!;
        private Label lblVungNDVal = null!, lblVungDLVal = null!;
        private Label lblCheoDot = null!, lblCheoText = null!;
        private Label lblMsgVal = null!, lblTimestamp = null!;

        public MainForm()
        {
            _svc = new DiemThiService(_cfg);
            Build();
            _ = KiemTraNodeAsync();
        }

        private void Build()
        {
            Text = "Tra Cứu Điểm Thi Quốc Gia - Phân Tán 2 Miền ";
            Size = new Size(1100, 720);
            MinimumSize = new Size(960, 600);
            StartPosition = FormStartPosition.CenterScreen;
            BackColor = Color.FromArgb(243, 244, 246);
            Font = new Font("Segoe UI", 9.5f);

            var root = new TableLayoutPanel
            {
                Dock = DockStyle.Fill,
                ColumnCount = 2,
                RowCount = 1,
                Padding = new Padding(12)
            };
            root.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 62));
            root.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 38));
            root.RowStyles.Add(new RowStyle(SizeType.Percent, 100));
            Controls.Add(root);
            root.Controls.Add(BuildLeft(), 0, 0);
            root.Controls.Add(BuildRight(), 1, 0);
        }

        // ═══════════════════════════════════════════════════════
        //  CỘT TRÁI
        // ═══════════════════════════════════════════════════════
        private Panel BuildLeft()
        {
            var outer = new Panel { Dock = DockStyle.Fill, Padding = new Padding(0, 0, 10, 0) };

            var tbl = new TableLayoutPanel
            {
                Dock = DockStyle.Fill,
                ColumnCount = 1,
                RowCount = 8
            };
            tbl.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 100));
            tbl.RowStyles.Add(new RowStyle(SizeType.Absolute, 44));  // 0 title
            tbl.RowStyles.Add(new RowStyle(SizeType.Absolute, 24));  // 1 subtitle
            tbl.RowStyles.Add(new RowStyle(SizeType.Absolute, 38));  // 2 node bar
            tbl.RowStyles.Add(new RowStyle(SizeType.Absolute, 76));  // 3 vùng
            tbl.RowStyles.Add(new RowStyle(SizeType.Absolute, 72));  // 4 SBD
            tbl.RowStyles.Add(new RowStyle(SizeType.Absolute, 28));  // 5 status
            tbl.RowStyles.Add(new RowStyle(SizeType.Absolute, 126)); // 6 thí sinh
            tbl.RowStyles.Add(new RowStyle(SizeType.Percent, 100));  // 7 dgv
            outer.Controls.Add(tbl);

            // 0 – Title
            tbl.Controls.Add(new Label
            {
                Text = "HỆ THỐNG TRA CỨU ĐIỂM THI QUỐC GIA",
                Font = new Font("Segoe UI", 13f, FontStyle.Bold),
                ForeColor = Color.FromArgb(30, 58, 138),
                Dock = DockStyle.Fill,
                TextAlign = ContentAlignment.MiddleLeft
            }, 0, 0);

            // 1 – Subtitle
            tbl.Controls.Add(new Label
            {
                Text = "Co so du lieu phan tan 2 mien  –  Phat hien tra cheo vung tu dong",
                Font = new Font("Segoe UI", 8.5f, FontStyle.Italic),
                ForeColor = Color.FromArgb(100, 116, 139),
                Dock = DockStyle.Fill,
                TextAlign = ContentAlignment.MiddleLeft
            }, 0, 1);

            // 2 – Node bar
            var nodeBar = new Panel { Dock = DockStyle.Fill, BackColor = Color.White };
            var nTbl = new TableLayoutPanel { Dock = DockStyle.Fill, ColumnCount = 3, RowCount = 1 };
            nTbl.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 40));
            nTbl.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 40));
            nTbl.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 20));
            nTbl.RowStyles.Add(new RowStyle(SizeType.Percent, 100));
            lblNodeBac = NodeLbl("● Mien Bac: ...", Color.Gray);
            lblNodeNam = NodeLbl("● Mien Nam: ...", Color.Gray);
            btnKiemTra = new Button
            {
                Text = "Kiem tra",
                Dock = DockStyle.Fill,
                Margin = new Padding(4, 4, 4, 4),
                Font = new Font("Segoe UI", 8.5f),
                FlatStyle = FlatStyle.Flat,
                BackColor = Color.FromArgb(100, 116, 139),
                ForeColor = Color.White,
                Cursor = Cursors.Hand
            };
            btnKiemTra.FlatAppearance.BorderSize = 0;
            btnKiemTra.Click += async (s, e) => await KiemTraNodeAsync();
            nTbl.Controls.Add(lblNodeBac, 0, 0);
            nTbl.Controls.Add(lblNodeNam, 1, 0);
            nTbl.Controls.Add(btnKiemTra, 2, 0);
            nodeBar.Controls.Add(nTbl);
            tbl.Controls.Add(nodeBar, 0, 2);

            // 3 – Chọn vùng
            var grpVung = new GroupBox
            {
                Text = "1.  Chọn vùng của bạn ",
                Font = new Font("Segoe UI", 9.5f, FontStyle.Bold),
                Dock = DockStyle.Fill,
                Margin = new Padding(0, 4, 0, 0),
                Padding = new Padding(10, 2, 10, 2)
            };
            rdoBac = new RadioButton { Text = "Miền Bắc ", Font = new Font("Segoe UI", 9.5f), Left = 10, Top = 20, Width = 320 };
            rdoNam = new RadioButton { Text = "Miền Nam ", Font = new Font("Segoe UI", 9.5f), Left = 10, Top = 44, Width = 320 };
            rdoBac.CheckedChanged += (s, e) => { if (rdoBac.Checked) _cfg.VungNguoiDung = VungNguoiDung.MienBac; };
            rdoNam.CheckedChanged += (s, e) => { if (rdoNam.Checked) _cfg.VungNguoiDung = VungNguoiDung.MienNam; };
            grpVung.Controls.AddRange(new Control[] { rdoBac, rdoNam });
            tbl.Controls.Add(grpVung, 0, 3);

            // 4 – SBD
            var grpSBD = new GroupBox
            {
                Text = "2.  Nhập số báo danh",
                Font = new Font("Segoe UI", 9.5f, FontStyle.Bold),
                Dock = DockStyle.Fill,
                Margin = new Padding(0, 4, 0, 0),
                Padding = new Padding(10, 2, 10, 2)
            };
            grpSBD.Controls.Add(new Label { Text = "Số Báo Danh:", Left = 10, Top = 26, Width = 100, TextAlign = ContentAlignment.MiddleLeft });
            txtSBD = new TextBox { Left = 114, Top = 24, Width = 200, Font = new Font("Segoe UI", 11f) };
            txtSBD.KeyDown += (s, e) => { if (e.KeyCode == Keys.Enter) { e.SuppressKeyPress = true; _ = TraCuuAsync(); } };
            btnTraCuu = new Button
            {
                Text = "TRA CỨU  →",
                Left = 324,
                Top = 22,
                Width = 130,
                Height = 30,
                Font = new Font("Segoe UI", 10f, FontStyle.Bold),
                FlatStyle = FlatStyle.Flat,
                BackColor = Color.FromArgb(30, 58, 138),
                ForeColor = Color.White,
                Cursor = Cursors.Hand
            };
            btnTraCuu.FlatAppearance.BorderSize = 0;
            btnTraCuu.Click += async (s, e) => await TraCuuAsync();
            grpSBD.Controls.AddRange(new Control[] { txtSBD, btnTraCuu });
            tbl.Controls.Add(grpSBD, 0, 4);

            // 5 – Status
            lblStatus = new Label
            {
                Text = "Sẵn sàng tra cứu...",
                Font = new Font("Segoe UI", 9f, FontStyle.Italic),
                ForeColor = Color.FromArgb(100, 116, 139),
                Dock = DockStyle.Fill,
                TextAlign = ContentAlignment.MiddleLeft,
                Padding = new Padding(4, 0, 0, 0)
            };
            tbl.Controls.Add(lblStatus, 0, 5);

            // 6 – Thí sinh card
            pnlThiSinh = new Panel { Dock = DockStyle.Fill, Visible = false, BackColor = Color.White, Padding = new Padding(10, 6, 10, 6) };
            pnlThiSinh.Paint += (s, e) => {
                using var pen = new Pen(Color.FromArgb(191, 219, 254), 2);
                e.Graphics.DrawRectangle(pen, 0, 0, pnlThiSinh.Width - 1, pnlThiSinh.Height - 1);
            };
            var tsTbl = new TableLayoutPanel { Dock = DockStyle.Fill, ColumnCount = 4, RowCount = 3 };
            tsTbl.ColumnStyles.Add(new ColumnStyle(SizeType.Absolute, 94));
            tsTbl.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 50));
            tsTbl.ColumnStyles.Add(new ColumnStyle(SizeType.Absolute, 94));
            tsTbl.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 50));
            for (int i = 0; i < 3; i++) tsTbl.RowStyles.Add(new RowStyle(SizeType.Percent, 33));
            lblTen = AddTSRow(tsTbl, "Họ Và Tên:", 0, 0, true);
            lblSBD2 = AddTSRow(tsTbl, "Số Báo Danh:", 1, 0);
            lblNS = AddTSRow(tsTbl, "Ngày Sinh:", 2, 0);
            lblTinh = AddTSRow(tsTbl, "Tỉnh/TP:", 0, 2);
            lblTruong = AddTSRow(tsTbl, "Trường THPT:", 1, 2);
            lblNode2 = AddTSRow(tsTbl, "Miền:", 2, 2);
            pnlThiSinh.Controls.Add(tsTbl);
            tbl.Controls.Add(pnlThiSinh, 0, 6);

            // 7 – DataGridView
            dgv = new DataGridView
            {
                Dock = DockStyle.Fill,
                AllowUserToAddRows = false,
                ReadOnly = true,
                AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill,
                BackgroundColor = Color.White,
                BorderStyle = BorderStyle.None,
                RowHeadersVisible = false,
                SelectionMode = DataGridViewSelectionMode.FullRowSelect,
                Font = new Font("Segoe UI", 9.5f),
                GridColor = Color.FromArgb(226, 232, 240),
                AlternatingRowsDefaultCellStyle = new DataGridViewCellStyle { BackColor = Color.FromArgb(248, 250, 252) }
            };
            dgv.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Môn Thi", FillWeight = 45 });
            dgv.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Điểm", FillWeight = 25 });
            dgv.Columns.Add(new DataGridViewTextBoxColumn { HeaderText = "Xếp Loại", FillWeight = 30 });
            dgv.ColumnHeadersDefaultCellStyle.BackColor = Color.FromArgb(30, 58, 138);
            dgv.ColumnHeadersDefaultCellStyle.ForeColor = Color.White;
            dgv.ColumnHeadersDefaultCellStyle.Font = new Font("Segoe UI", 9.5f, FontStyle.Bold);
            dgv.EnableHeadersVisualStyles = false;
            tbl.Controls.Add(dgv, 0, 7);

            return outer;
        }

        private Label AddTSRow(TableLayoutPanel tbl, string key, int row, int col, bool bold = false)
        {
            tbl.Controls.Add(new Label
            {
                Text = key,
                Dock = DockStyle.Fill,
                Font = new Font("Segoe UI", 8.5f, FontStyle.Bold),
                ForeColor = Color.FromArgb(100, 116, 139),
                TextAlign = ContentAlignment.MiddleLeft
            }, col, row);
            var v = new Label
            {
                Text = "---",
                Dock = DockStyle.Fill,
                Font = new Font("Segoe UI", bold ? 10.5f : 9.5f, bold ? FontStyle.Bold : FontStyle.Regular),
                ForeColor = bold ? Color.FromArgb(30, 58, 138) : Color.FromArgb(30, 41, 59),
                TextAlign = ContentAlignment.MiddleLeft
            };
            tbl.Controls.Add(v, col + 1, row);
            return v;
        }

        // ═══════════════════════════════════════════════════════
        //  CỘT PHẢI
        // ═══════════════════════════════════════════════════════
        private Panel BuildRight()
        {
            var outer = new Panel
            {
                Dock = DockStyle.Fill,
                BackColor = Color.FromArgb(15, 23, 42),
                Padding = new Padding(16, 12, 16, 12)
            };

            var scroll = new Panel { Dock = DockStyle.Fill, AutoScroll = true, BackColor = Color.Transparent };
            outer.Controls.Add(scroll);

            var tbl = new TableLayoutPanel
            {
                Dock = DockStyle.Top,
                AutoSize = true,
                ColumnCount = 1
            };
            tbl.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 100));
            scroll.Controls.Add(tbl);

            int r = 0;
            void Row(int h) { tbl.RowCount++; tbl.RowStyles.Add(new RowStyle(SizeType.Absolute, h)); }

            // Title
            Row(36); tbl.Controls.Add(new Label
            {
                Text = "THÔNG TIN HỆ THỐNG",
                Font = new Font("Segoe UI", 11f, FontStyle.Bold),
                ForeColor = Color.FromArgb(148, 163, 184),
                Dock = DockStyle.Fill,
                TextAlign = ContentAlignment.MiddleLeft
            }, 0, r++);

            Divider(tbl, ref r);

            lblNodeVal = RightRow(tbl, ref r, "Node tra cứu", Color.FromArgb(99, 179, 237));
            lblDBVal = RightRow(tbl, ref r, "Database", Color.FromArgb(99, 179, 237));
            lblServerVal = RightRow(tbl, ref r, "Server DB", Color.FromArgb(99, 179, 237));

            Divider(tbl, ref r);

            // SQL status
            Row(20); tbl.Controls.Add(RLbl("Tinh trạng kết nối SQL"), 0, r++);
            Row(28);
            var sqlPnl = new Panel { Dock = DockStyle.Fill, BackColor = Color.Transparent };
            lblSQLDot = new Label { Left = 0, Top = 5, Width = 18, Height = 18, Text = "●", Font = new Font("Segoe UI", 13f), ForeColor = Color.Gray };
            lblSQLText = new Label { Left = 22, Top = 4, Width = 260, Height = 20, Font = new Font("Segoe UI", 9.5f, FontStyle.Bold), ForeColor = Color.Gray, Text = "Chua ket noi" };
            sqlPnl.Controls.AddRange(new Control[] { lblSQLDot, lblSQLText });
            tbl.Controls.Add(sqlPnl, 0, r++);

            Divider(tbl, ref r);

            lblTgKNVal = RightRow(tbl, ref r, "TG kết nối", Color.FromArgb(110, 231, 183));
            lblTgQVal = RightRow(tbl, ref r, "TG truy vấn", Color.FromArgb(110, 231, 183));
            lblTongVal = RightRow(tbl, ref r, "Tổng TG", Color.FromArgb(251, 191, 36));

            Divider(tbl, ref r);

            lblVungNDVal = RightRow(tbl, ref r, "Vùng người dùng", Color.FromArgb(196, 181, 253));
            lblVungDLVal = RightRow(tbl, ref r, "Vùng dữ liệu", Color.FromArgb(196, 181, 253));

            // Tra chéo
            Row(20); tbl.Controls.Add(RLbl("Tra chéo vùng"), 0, r++);
            Row(28);
            var cheoPnl = new Panel { Dock = DockStyle.Fill, BackColor = Color.Transparent };
            lblCheoDot = new Label { Left = 0, Top = 5, Width = 18, Height = 18, Text = "●", Font = new Font("Segoe UI", 13f), ForeColor = Color.Gray };
            lblCheoText = new Label { Left = 22, Top = 4, Width = 260, Height = 20, Font = new Font("Segoe UI", 9.5f, FontStyle.Bold), ForeColor = Color.Gray, Text = "---" };
            cheoPnl.Controls.AddRange(new Control[] { lblCheoDot, lblCheoText });
            tbl.Controls.Add(cheoPnl, 0, r++);

            Divider(tbl, ref r);

            // Thông báo
            Row(20); tbl.Controls.Add(RLbl("Thông báo"), 0, r++);
            Row(90);
            lblMsgVal = new Label
            {
                Dock = DockStyle.Fill,
                Font = new Font("Segoe UI", 9.5f),
                ForeColor = Color.FromArgb(148, 163, 184),
                BackColor = Color.FromArgb(30, 41, 59),
                Text = "Nhấn [TRA CUU] để bắt đầu...",
                Padding = new Padding(10, 8, 10, 8),
                TextAlign = ContentAlignment.TopLeft
            };
            tbl.Controls.Add(lblMsgVal, 0, r++);

            Row(26);
            lblTimestamp = new Label
            {
                Dock = DockStyle.Fill,
                Text = "",
                Font = new Font("Segoe UI", 8f, FontStyle.Italic),
                ForeColor = Color.FromArgb(51, 65, 85),
                TextAlign = ContentAlignment.MiddleLeft
            };
            tbl.Controls.Add(lblTimestamp, 0, r++);

            return outer;
        }

        private Label RightRow(TableLayoutPanel tbl, ref int r, string title, Color c)
        {
            tbl.RowCount++; tbl.RowStyles.Add(new RowStyle(SizeType.Absolute, 18));
            tbl.Controls.Add(RLbl(title), 0, r++);
            tbl.RowCount++; tbl.RowStyles.Add(new RowStyle(SizeType.Absolute, 28));
            var v = new Label
            {
                Dock = DockStyle.Fill,
                Text = "---",
                Font = new Font("Segoe UI", 10.5f, FontStyle.Bold),
                ForeColor = c,
                TextAlign = ContentAlignment.MiddleLeft
            };
            tbl.Controls.Add(v, 0, r++);
            return v;
        }

        private static void Divider(TableLayoutPanel tbl, ref int r)
        {
            tbl.RowCount++; tbl.RowStyles.Add(new RowStyle(SizeType.Absolute, 14));
            tbl.Controls.Add(new Panel { Dock = DockStyle.Fill, BackColor = Color.FromArgb(30, 41, 59) }, 0, r++);
        }

        private static Label RLbl(string t) => new Label
        {
            Text = t,
            Dock = DockStyle.Fill,
            Font = new Font("Segoe UI", 8f),
            ForeColor = Color.FromArgb(100, 116, 139),
            TextAlign = ContentAlignment.MiddleLeft
        };

        private static Label NodeLbl(string t, Color c) => new Label
        {
            Text = t,
            Dock = DockStyle.Fill,
            TextAlign = ContentAlignment.MiddleLeft,
            Font = new Font("Segoe UI", 9f, FontStyle.Bold),
            ForeColor = c,
            Padding = new Padding(6, 0, 0, 0)
        };

        // ═══════════════════════════════════════════════════════
        //  LOGIC
        // ═══════════════════════════════════════════════════════
        private async Task KiemTraNodeAsync()
        {
            btnKiemTra.Enabled = false;
            lblNodeBac.Text = "● Mien Bac: kiểm tra..."; lblNodeBac.ForeColor = Color.Gray;
            lblNodeNam.Text = "● Mien Nam: kiểm tra..."; lblNodeNam.ForeColor = Color.Gray;
            var (bac, msBac, nam, msNam) = await _svc.CheckNodesAsync();
            lblNodeBac.Text = $"● Mien Bắc: {(bac ? "ONLINE" : "OFFLINE")} ({msBac}ms)";
            lblNodeBac.ForeColor = bac ? Color.FromArgb(21, 128, 61) : Color.Crimson;
            lblNodeNam.Text = $"● Mien Nam: {(nam ? "ONLINE" : "OFFLINE")} ({msNam}ms)";
            lblNodeNam.ForeColor = nam ? Color.FromArgb(21, 128, 61) : Color.Crimson;
            btnKiemTra.Enabled = true;
        }

        private async Task TraCuuAsync()
        {
            if (_cfg.VungNguoiDung == VungNguoiDung.ChuaChon)
            { MessageBox.Show("Vui lòng chọn vung của bạn.", "Thiếu thông tin", MessageBoxButtons.OK, MessageBoxIcon.Warning); return; }
            string sbd = txtSBD.Text.Trim();
            if (string.IsNullOrEmpty(sbd))
            { MessageBox.Show("Vui lòng nhập số báo danh.", "Thiếu thông tin", MessageBoxButtons.OK, MessageBoxIcon.Warning); return; }

            btnTraCuu.Enabled = false; btnTraCuu.Text = "Đang tra...";
            lblStatus.Text = "Đang kết nối và truy vấn..."; lblStatus.ForeColor = Color.Orange;
            pnlThiSinh.Visible = false; dgv.Rows.Clear();
            ResetRight();

            var kq = await _svc.TraCuuAsync(sbd);
            btnTraCuu.Enabled = true; btnTraCuu.Text = "TRA CỨU  →";
            UpdateRight(kq);

            if (kq.ThanhCong && kq.ThiSinh != null)
            {
                lblStatus.Text = $"✓ Tìm thấy: {kq.ThiSinh.HoTen}  |  SBD {kq.ThiSinh.SoBaoDanh}";
                lblStatus.ForeColor = Color.FromArgb(21, 128, 61);
                ShowThiSinh(kq.ThiSinh); ShowDiem(kq.ThiSinh);
            }
            else if (kq.TrangThaiNode == NodeStatus.Offline)
            { lblStatus.Text = "✕ KHU VỰC ĐANG BẢO TRÌ"; lblStatus.ForeColor = Color.Crimson; }
            else
            { lblStatus.Text = kq.ThongBao; lblStatus.ForeColor = Color.OrangeRed; }
        }

        private void UpdateRight(KetQuaTraCuu kq)
        {
            lblNodeVal.Text = string.IsNullOrEmpty(kq.TenNode) ? "---" : kq.TenNode;
            lblDBVal.Text = string.IsNullOrEmpty(kq.TenDB) ? "---" : kq.TenDB;
            lblServerVal.Text = string.IsNullOrEmpty(kq.ServerDB) ? "---" : kq.ServerDB;

            if (kq.KetNoiThanhCong)
            { lblSQLDot.ForeColor = Color.FromArgb(52, 211, 153); lblSQLText.Text = "KẾT NỐI THÀNH CÔNG"; lblSQLText.ForeColor = Color.FromArgb(52, 211, 153); }
            else if (!string.IsNullOrEmpty(kq.TenNode))
            { lblSQLDot.ForeColor = Color.Crimson; lblSQLText.Text = "KẾT NỐI THÁT BẠI"; lblSQLText.ForeColor = Color.Crimson; }

            lblTgKNVal.Text = kq.ThoiGianKetNoiMs > 0 ? $"{kq.ThoiGianKetNoiMs} ms" : "---";
            lblTgQVal.Text = kq.ThoiGianQueryMs > 0 ? $"{kq.ThoiGianQueryMs} ms" : "---";
            lblTongVal.Text = $"{kq.TongThoiGianMs} ms";

            lblVungNDVal.Text = string.IsNullOrEmpty(kq.VungNguoiDung) ? "---" : kq.VungNguoiDung;
            lblVungDLVal.Text = string.IsNullOrEmpty(kq.VungDuLieu) ? "---" : kq.VungDuLieu;

            if (kq.TraCheo)
            { lblCheoDot.ForeColor = Color.Orange; lblCheoText.Text = "CÓ – TRA CHÉO VÙNG"; lblCheoText.ForeColor = Color.Orange; }
            else if (!string.IsNullOrEmpty(kq.VungDuLieu) && kq.VungDuLieu != "N/A")
            { lblCheoDot.ForeColor = Color.FromArgb(52, 211, 153); lblCheoText.Text = "KHÔNG – CÙNG VÙNG"; lblCheoText.ForeColor = Color.FromArgb(52, 211, 153); }

            if (kq.ThanhCong)
            {
                lblMsgVal.Text = $"✓ Tìm kiếm thành công\n   Node: {kq.TenNode}\n" +
                               (kq.TraCheo ? "⚠ Tra chéo vùng – đã tự động chuyển node" : "✓ Tra cùng vùng");
                lblMsgVal.ForeColor = Color.FromArgb(52, 211, 153);
            }
            else if (kq.TrangThaiNode == NodeStatus.Offline)
            { lblMsgVal.Text = $"✕ KHU VỰC ĐANG BẢO TRÌ\n   Node {kq.TenNode} không phản hồi"; lblMsgVal.ForeColor = Color.Crimson; }
            else
            { lblMsgVal.Text = kq.ThongBao; lblMsgVal.ForeColor = Color.Orange; }

            lblTimestamp.Text = $"Cập nhật: {kq.ThoiDiemTraCuu:HH:mm:ss  dd/MM/yyyy}";
        }

        private void ResetRight()
        {
            lblNodeVal.Text = "---"; lblDBVal.Text = "---"; lblServerVal.Text = "---";
            lblSQLDot.ForeColor = Color.Gray; lblSQLText.Text = "Chua ket noi"; lblSQLText.ForeColor = Color.Gray;
            lblTgKNVal.Text = "---"; lblTgQVal.Text = "---"; lblTongVal.Text = "---";
            lblVungNDVal.Text = "---"; lblVungDLVal.Text = "---";
            lblCheoDot.ForeColor = Color.Gray; lblCheoText.Text = "---"; lblCheoText.ForeColor = Color.Gray;
            lblMsgVal.Text = "Đang tra cứu..."; lblMsgVal.ForeColor = Color.FromArgb(148, 163, 184);
            lblTimestamp.Text = "";
        }

        private void ShowThiSinh(ThiSinh ts)
        {
            pnlThiSinh.Visible = true;
            lblTen.Text = ts.HoTen; lblSBD2.Text = ts.SoBaoDanh; lblNS.Text = ts.NgaySinhStr;
            lblTinh.Text = ts.TinhTP; lblTruong.Text = ts.TruongTHPT; lblNode2.Text = ts.Node;
        }

        private void ShowDiem(ThiSinh ts)
        {
            dgv.Rows.Clear();
            foreach (var d in ts.DanhSachDiem)
            {
                int i = dgv.Rows.Add(d.TenMon, d.Diem.ToString("F2"), d.XepLoai);
                dgv.Rows[i].DefaultCellStyle.ForeColor = d.Diem >= 8m ? Color.FromArgb(21, 128, 61) : d.Diem < 5m ? Color.Crimson : Color.FromArgb(30, 41, 59);
            }
            if (ts.DanhSachDiem.Count > 0)
            {
                int i = dgv.Rows.Add("─── TRUNG BÌNH ───", ts.DiemTB.ToString("F2"), "");
                dgv.Rows[i].DefaultCellStyle.Font = new Font("Segoe UI", 9.5f, FontStyle.Bold);
                dgv.Rows[i].DefaultCellStyle.ForeColor = Color.FromArgb(30, 58, 138);
                dgv.Rows[i].DefaultCellStyle.BackColor = Color.FromArgb(239, 246, 255);
            }
        }
    }
}