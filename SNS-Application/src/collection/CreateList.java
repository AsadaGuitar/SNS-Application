package collection;

import java.sql.SQLException;
import java.util.LinkedList;

import sql.DownloadSQL;

public class CreateList extends DownloadSQL{
	private static String ThreadSQL = "select * from chatdata where type = ? and kind = ?;";
	private static String FriendsSQL = "select * from friends where user_name = ?;";
	private static String MessageSQL = "select * from message where to_user = ?;";

	public static String getThreadSQL() {
		return ThreadSQL;
	}
	public static String getFriendsSQL() {
		return FriendsSQL;
	}
	public static String getMessageSQL() {
		return MessageSQL;
	}

	public CreateList(String sql, LinkedList<String> configureList) throws SQLException{
		super(sql, configureList);
	}
	public LinkedList<String> setList(LinkedList<String> list, String column)
			throws SQLException {
		loadRs();
		while(rs.next()) {
			list.add(0, Download(column));
		}
		return list;
	}
}
