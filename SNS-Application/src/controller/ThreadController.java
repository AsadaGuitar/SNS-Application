package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.Optional;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sql.UploadSQL;
import user.UserData;


@WebServlet("/Thread")
public class ThreadController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	HttpSession session;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Optional<String> Access = Optional.ofNullable(request.getParameter("ThreadControllerGet"));

		switch(Access.orElse("null")) {
		    case "select":
		    	selectThread(request, response);
		    	break;
		    case "OpenThread":
		    	click_thread(request, response);
			    break;
		    case "Friends":
			    try {
				    follow_friends(request, response);
			    } catch (SQLException e1) {
				    e1.printStackTrace();
			    }
			    break;
		    case "exit":
		    	display_thread(request);
		    default:

			    break;
		}

		returnPage(request, response);
	}
	private void selectThread(HttpServletRequest request, HttpServletResponse response) {
		Optional<String> type = Optional.ofNullable(request.getParameter("select-type"));
		Optional<String> option = Optional.ofNullable(request.getParameter("select-option"));

		session = request.getSession();
		type.ifPresent(t -> session.setAttribute("type", t));
		option.ifPresent(o -> session.setAttribute("kind", o));

		request.setAttribute("isDisplayHome", true);
	}
	private void click_thread(HttpServletRequest request, HttpServletResponse response) {
		String click_ary = request.getParameter("click_ary");
		request.setAttribute("click_ary", click_ary);
		request.setAttribute("isDisplayHome", true);
		request.setAttribute("isDisplayThread", true);
	}
	private void display_thread(HttpServletRequest request) {
		request.setAttribute("isDisplayHome", true);
	}

	private void follow_friends(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		session = request.getSession();
		String SQL = "insert into friends(user_name, friends_name) value(?, ?);";
		UserData user = (UserData)session.getAttribute("user_data");
		String friends_name = request.getParameter("friends_request_name");
		System.out.println(user.getName());
		System.out.println(friends_name);
		LinkedList<String> configureList = new LinkedList<String>(Arrays.asList(user.getName(), friends_name));

	    UploadSQL uploader = new UploadSQL(SQL, configureList);
		uploader.UploadData();
		request.setAttribute("isDisplayHome", true);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			AddThread(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		returnPage(request, response);
	}

	private void AddThread(HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		session = request.getSession();
		String SQL = "insert into chatdata(title, comment, date, type, kind, name) value(?, ?, ?, ?, ?, ?);";
		UserData user = (UserData)session.getAttribute("user_data");
		String title = request.getParameter("threadTitle");
		String comments = request.getParameter("threadComments");
		String type = request.getParameter("addType");
		String option = request.getParameter("addOption");
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String date = sdf.format(calendar.getTime());
		System.out.println(user.getName());
		System.out.println(title);
		System.out.println(comments);
		System.out.println(type);
		System.out.println(option);
		System.out.println(date);
		LinkedList<String> configureList = new LinkedList<String>
		    (Arrays.asList(title, comments, date, type, option, user.getName()));

		UploadSQL uploader = new UploadSQL(SQL, configureList);
		uploader.UploadData();

		request.setAttribute("isDisplayHome", true);
	}

	private void returnPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
		response.setContentType("text/html;charset = UTF-8");
		rd.forward(request, response);
	}
}







