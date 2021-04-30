package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
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

@WebServlet("/FriendsController")
public class FriendsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String controller = request.getParameter("FriendsController");

		switch(controller) {
		    case "open":
			try {
				open_FriendsProfiles(request, response);
			} catch (SQLException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}
		    	break;
		    case "close":
		    	close_FriendsProfile(request, response);
		    	break;
		}
		returnPage(request, response);
	}

	private void open_FriendsProfiles(HttpServletRequest request, HttpServletResponse response) throws SQLException{

		request.setAttribute("isDisplayFriendsProfile", true);
		String FriendsName = request.getParameter("friends_name");
		System.out.println("open_FriendsProfile name : " + FriendsName);

	    LinkedList<String> configure_list = new LinkedList<String>(Arrays.asList(FriendsName));
		String SQL = "select * from account where name = ?;";
		DownloadSQL downloader = new DownloadSQL(SQL, configure_list);
		if(downloader.setResultSet()) {
			System.out.println("open_FriendsProfile: setResultSet is true");
			request.setAttribute("friends_name", downloader.Download("name"));
			request.setAttribute("friends_gender", downloader.Download("gender"));
			request.setAttribute("friends_age", downloader.Download("age"));
			request.setAttribute("friends_music_type", downloader.Download("music_type"));
			request.setAttribute("friends_instrument", downloader.Download("instrument"));
			request.setAttribute("friends_favorite_musician", downloader.Download("favorite_musician"));
		}
	}

	private void close_FriendsProfile(HttpServletRequest request, HttpServletResponse response) {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			send_message(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		returnPage(request, response);
	}

	private void send_message(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		session = request.getSession();
		UserData user = (UserData)session.getAttribute("user_data");
		String message_title = request.getParameter("message-title");
		String message_comments = request.getParameter("message-comments");
		String send_to_name = request.getParameter("send_message_name");
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String date = sdf.format(calendar.getTime());

		String SQL = "insert into message(from_user, title, comments, to_user, date) value(?, ?, ?, ?, ?);";
		LinkedList<String> configure_list = new LinkedList<String>(Arrays.asList(user.getName(), message_title, message_comments, send_to_name, date));
		UploadSQL uploader = new UploadSQL(SQL, configure_list);
		uploader.UploadData();
	}

	private void returnPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setAttribute("isDisplayFriends", true);
		RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
		response.setContentType("text/html; charset = UTF-8");
		rd.forward(request, response);
	}

}
