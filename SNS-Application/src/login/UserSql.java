package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserSql {

	private static String url = "jdbc:mysql://localhost/*********?serverTimezone=JST";
	private static String root = "***********";
    private static String pass = "**********";

	public static String SQL;

	public String userName;
	public String userPass;
	public String userEmail;

	private static Connection conn;
	private static PreparedStatement ps;
	private static ResultSet rs;

	public void setConnection() throws SQLException {

		conn = DriverManager.getConnection(url, root, pass);
		ps = conn.prepareStatement(SQL);

	}

	public int BelieverCount() throws SQLException {
		int believer;
		conn.setAutoCommit(false);
		rs = ps.executeQuery();
		/*rs.last();
		believer = rs.getRow();*/
		believer = 0;
		while(rs.next()) {
			believer++;
		}
		System.out.println("UserSql 信者数: " + believer);
		return believer;
	}

	public void userEntry() throws SQLException {

		conn.setAutoCommit(false);
		ps.setString(1, userName);
		ps.setString(2, userPass);
		ps.setString(3, userEmail);
		ps.executeUpdate();
		conn.commit();
	}

	public String userLogin() throws SQLException {

		conn.setAutoCommit(false);
		ps.setString(1, userName);
		rs = ps.executeQuery();
		System.out.println(rs);
		String result;

		if(rs.next()) {
			String passwordData = rs.getString("password");
			System.out.println(passwordData);
			System.out.println(userPass);
			if(userPass.equals(passwordData)) {
				System.out.println("ok");
				result = "true";
			}
			else {
				result = "false password";
			}
		}
		else {
			System.out.println("none");
			result = "false name";
		}

		return result;
	}
}
