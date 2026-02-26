import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;

public class TraCuuDiemThi extends JFrame {

    // 1. GIAO DIỆN (UI Components)
    private JTextField txtSBD;
    private JButton btnTraCuu;
    private JLabel lblKetQua;

    // 2. CẤU HÌNH KẾT NỐI (Connection Strings)
    // Lưu ý quan trọng: loginTimeout=3 giúp app chỉ đợi 3s nếu Node sập, tránh bị
    // treo máy.
    // Thay "localhost\\SQLEXPRESS" bằng tên Server SQL của bạn. Cổng mặc định là
    // 1433.
    private final String urlNodeBac = "jdbc:sqlserver://MSI:1433;databaseName=DB_MienBac;integratedSecurity=true;encrypt=true;trustServerCertificate=true;loginTimeout=3;";
    private final String urlNodeNam = "jdbc:sqlserver://MSI:1433;databaseName=DB_MienNam;integratedSecurity=true;encrypt=true;trustServerCertificate=true;loginTimeout=3;";

    public TraCuuDiemThi() {
        // Thiết lập khung giao diện cơ bản
        setTitle("Tra Cứu Điểm Thi Quốc Gia");
        setSize(400, 250);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new FlowLayout(FlowLayout.CENTER, 10, 20));

        // Khởi tạo các công cụ
        JLabel lblHuongDan = new JLabel("Nhập Số Báo Danh (1-1000):");
        txtSBD = new JTextField(15);
        btnTraCuu = new JButton("Tra cứu điểm");
        lblKetQua = new JLabel("Kết quả sẽ hiển thị ở đây.");
        lblKetQua.setPreferredSize(new Dimension(350, 50));
        lblKetQua.setHorizontalAlignment(SwingConstants.CENTER);

        // Thêm công cụ vào Form
        add(lblHuongDan);
        add(txtSBD);
        add(btnTraCuu);
        add(lblKetQua);

        // Bắt sự kiện khi bấm nút Tra Cứu
        btnTraCuu.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                xuLyTraCuu();
            }
        });
    }

    private void xuLyTraCuu() {
        lblKetQua.setText("Đang xử lý...");
        lblKetQua.setForeground(Color.BLACK);
        String input = txtSBD.getText().trim();
        int sbd;

        // Kiểm tra đầu vào hợp lệ
        try {
            sbd = Integer.parseInt(input);
        } catch (NumberFormatException ex) {
            hienThiThongBao("Vui lòng nhập SBD là một số nguyên!", Color.ORANGE);
            return;
        }

        // YÊU CẦU 2: QUERY ROUTER - Quyết định chọn Node nào
        String connectionUrl = "";
        if (sbd >= 1 && sbd <= 500) {
            connectionUrl = urlNodeBac;
        } else if (sbd >= 501 && sbd <= 1000) {
            connectionUrl = urlNodeNam;
        } else {
            hienThiThongBao("SBD không thuộc phạm vi quốc gia (1-1000).", Color.ORANGE);
            return;
        }

        // YÊU CẦU 3: XỬ LÝ LỖI (TRY...CATCH)
        try (Connection conn = DriverManager.getConnection(connectionUrl)) {
            // Nếu Node sập, lệnh getConnection sẽ văng lỗi SQLException sau 3 giây
            // (loginTimeout)

            String query = "SELECT HoTen, Diem FROM ThiSinh WHERE SBD = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, sbd);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String hoTen = rs.getString("HoTen");
                        double diem = rs.getDouble("Diem");
                        hienThiThongBao("Thí sinh: " + hoTen + " - Điểm: " + diem, new Color(0, 150, 0)); // Màu xanh lá
                    } else {
                        hienThiThongBao("Không tìm thấy dữ liệu thí sinh với SBD này.", Color.RED);
                    }
                }
            }
        } catch (SQLException ex) {
            // BẮT LỖI DATABASE: Đạt yêu cầu hệ thống không Crash và báo bảo trì
            hienThiThongBao("Khu vực này đang bảo trì.", Color.RED);
            System.out.println("Chi tiết lỗi kĩ thuật: " + ex.getMessage()); // Mở dòng
            // này nếu muốn debug xem lỗi gì
        } catch (Exception ex) {
            hienThiThongBao("Lỗi hệ thống: " + ex.getMessage(), Color.RED);
        }
    }

    private void hienThiThongBao(String thongBao, Color mauSac) {
        lblKetQua.setText("<html>" + thongBao + "</html>");
        lblKetQua.setForeground(mauSac);
    }

    public static void main(String[] args) {
        // Chạy ứng dụng giao diện
        SwingUtilities.invokeLater(() -> {
            new TraCuuDiemThi().setVisible(true);
        });
    }
}