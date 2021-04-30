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

import sql.UploadSQL;
import user.UserData;

/**
 * Servlet implementation class MessageController
 */
@WebServlet("/MessageController")
public class MessageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    HttpSession session;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String controller = request.getParameter("MessageGet");
		switch(controller) {
		    case "exit":
		    	exit_message(request, response);
		    	break;
		    case "open":
		    	click_message(request, response);
		    	break;
		}

		returnPage(request, response);
	}

	private void click_message(HttpServletRequest request, HttpServletResponse response) {
		String click_ary = request.getParameter("message_ary");
		request.setAttribute("message_ary", click_ary);
		request.setAttribute("isDisplayMessage", true);
		request.setAttribute("isDisplayOpenedMessage", true);
	}

	private void exit_message(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("isDisplayMessage", true);
		request.setAttribute("isDisplayOpenedMessage", false);
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
		UserData user = (UserData)session.getAttribute("userData");
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
		request.setAttribute("isDisplayMessage", true);
	}


	private void returnPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
		response.setContentType("text/html; charset = UTF-8");
		rd.forward(request, response);
	}

}
