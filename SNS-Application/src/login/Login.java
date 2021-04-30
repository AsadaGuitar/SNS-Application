package login;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.LinkedList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sql.DownloadSQL;
import sql.UploadSQL;
import user.UserData;


@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	HttpSession session;
	static String search_name = "select * from account where name = ?;";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setAttribute("AFTER_LOGIN", true);

		try {
			loginAccount(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		returnPage(request, response);
	}

	private void loginAccount(HttpServletRequest request, HttpServletResponse response)
			throws SQLException{

		session = request.getSession();
		String user_name = request.getParameter("account-name");
		String user_pass = request.getParameter("account-password");

		DownloadSQL download_sql = new DownloadSQL(search_name, new LinkedList<String>(Arrays.asList(user_name)));

		if(download_sql.setResultSet()) {
			if(download_sql.Download("password").equals(user_pass)) {
				request.setAttribute("LoginResult", "true");
			    save_UserData(request, user_name);
			    display_first_thread(request, response);
			    System.out.println("userpass can to login");
			}
			else {request.setAttribute("LoginResult", "false password");}
		}
		else {
			System.out.println("name_isExists: " + null);
			request.setAttribute("LoginResult", "false name");
			return;
		}
	}

	private void display_first_thread(HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		session = request.getSession();

		UserData user = (UserData)session.getAttribute("user_data");
		String type = user.getMusicType();
		String kind = "trend";

		session.setAttribute("type", type);
		session.setAttribute("kind", kind);

		request.setAttribute("isDisplayHome", true);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setAttribute("AFTER_ENTRY", true);

		final String FIRST = "check";
		final String SECCOND = "ENTRY";
		String Access;

		Access = request.getParameter("entry-btn");

		//write_a_name -> first -> write_a_profile -> seccond -> set_user_data -> isEnter = true;
		switch(Access) {
		  case FIRST:
			  try {
				search_AccountName(request, response);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			  break;
		  case SECCOND:
			  try {
				upload_EntryData(request, response);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			  break;
			  default:
				  System.out.println("Login.java 101: error");
				  break;
		}

		returnPage(request, response);
	}

	private void search_AccountName(HttpServletRequest request, HttpServletResponse response)
			throws SQLException {

		String name = request.getParameter("first_EntryName");
		DownloadSQL download_sql = new DownloadSQL(search_name, new LinkedList<String>(Arrays.asList(name)));
		if(download_sql.setResultSet()) {
			request.setAttribute("Entry_isNotExist", false);
			return;
		}

		request.setAttribute("Entry_isNotExist", true);
		request.setAttribute("EntryName", name);
	}


	private void upload_EntryData(HttpServletRequest request, HttpServletResponse response) throws SQLException {

		String SQL = "insert into account(name, password, gender, age, music_type, instrument, favorite_musician) values(?, ?, ?, ?, ?, ?, ?);";
		LinkedList<String> para_list = new LinkedList<String>
		(Arrays.asList("seccond_EntryName", "entry-password", "entry-gender", "entry_age", "music-type", "entry-instrument", "entry-favorite-musician"));
		LinkedList<String> sql_list = new LinkedList<String>();
		for(int i=0; i<para_list.size(); i++) {
			sql_list.add(request.getParameter(para_list.get(i)));
		}
		UploadSQL uploader = new UploadSQL(SQL, sql_list);
		uploader.UploadData();
		save_UserData(request, request.getParameter("seccond_EntryName"));
	}

	private void save_UserData(HttpServletRequest request, String name) throws SQLException {
		session = request.getSession();
		DownloadSQL download_sql = new DownloadSQL(search_name, new LinkedList<String>(Arrays.asList(name)));
		download_sql.setResultSet();
		UserData user = new UserData();

		user.setName(download_sql.Download("name"));
	    user.setPassword(download_sql.Download("password"));
		user.setEmail(download_sql.Download("email"));
		user.setGender(download_sql.Download("gender"));
	    user.setAge(download_sql.Download("age"));
	    user.setMusicType(download_sql.Download("music_type"));
	    user.setInstrument(download_sql.Download("instrument"));
	    user.setFavoriteMusician(download_sql.Download("favorite_musician"));

	    session.setAttribute("user_data", user);
		session.setAttribute("isEnter", true);
	}

	private void returnPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
		response.setContentType("text/html;charset = UTF-8");
		rd.forward(request, response);
	}

}





