package sql;

import java.sql.SQLException;
import java.util.LinkedList;

public class UploadSQL extends CommitSQL{

	public UploadSQL(String sql, LinkedList<String> configureList) throws SQLException {
		setSQL(sql);
		commitConnection();
		configureSQL(configureList);
	}
	public void UploadData() throws SQLException {
		ps.executeUpdate();
		conn.commit();
	}
}
