package sql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

public class DownloadSQL extends CommitSQL{
	final Boolean EXIST = true;
	final Boolean IN_EXIST = false;
	Boolean isExists;
	protected ResultSet rs;

	public DownloadSQL(String sql, LinkedList<String> configureList) throws SQLException{
		setSQL(sql);
		commitConnection();
		configureSQL(configureList);
		this.loadRs();
	}
	public void loadRs() throws SQLException {
		rs = ps.executeQuery();
	}
	public boolean setResultSet() throws SQLException {
		return rs.next();
	}
	public String Download(String column) throws SQLException {
		return rs.getString(column);
	}
}