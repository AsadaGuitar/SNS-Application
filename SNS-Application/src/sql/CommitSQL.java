package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.LinkedList;

public abstract class CommitSQL {

	private static String url = "jdbc:mysql://localhost/*******?serverTimezone=JST";
	private static String root = "********";
    private static String pass = "********";
	protected static Connection conn;
	protected static PreparedStatement ps;
	public static String SQL;

	public void commitConnection() {
		try {
			conn = DriverManager.getConnection(url, root, pass);
			ps = conn.prepareStatement(SQL);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
	}
	public void setSQL(String str) {
		SQL = str;
	}

    public void configureSQL(LinkedList<String> sql_list) throws SQLException {
    	conn.setAutoCommit(false);
    	for(int i=0; i<sql_list.size(); i++) {
			ps.setString(i+1, sql_list.get(i));
		}
	}
}


interface Upload{
	void UploadData();
}
