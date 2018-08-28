<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver");%>

<%@ page language="java" contentType="text/html; utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; utf-8">
<title>Puppies with Yuppies JSP!</title>
</head>

<body>

	<%!public class User {

		String URL = "jdbc:mysql://localhost:3306/puppieswithyuppies";
		String USERNAME = "root";
		String PASSWORD = "aeioU90210";
		
		Boolean isAdmin = false;
		Boolean isStudent = false;

		Connection connection = null;
		PreparedStatement selectUsers = null;
		ResultSet resultSet = null;

		public Boolean IsAdmin() {
			return this.isAdmin;
		}
		
		public Boolean IsStudent() {
			return this.isStudent;
		}
		
		public User(String usernameInputToJava, String passwordInputToJava) {
 			try {
			
				connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

				selectUsers = connection
						.prepareStatement("SELECT Username,Password FROM logincredentials ORDER BY Username LIMIT 1 OFFSET 0");
				
				resultSet = selectUsers.executeQuery();
				resultSet.next();
				

				if (usernameInputToJava.equals(resultSet.getString("Username"))
						&& passwordInputToJava.equals(resultSet.getString("Password"))) {
					isAdmin = true;
					return;
	 			}

				selectUsers = connection
						.prepareStatement("SELECT Username,Password FROM logincredentials ORDER BY Username LIMIT 1 OFFSET 1");
				resultSet = selectUsers.executeQuery();
				resultSet.next();
				
				if (usernameInputToJava.equals(resultSet.getString("Username"))
						&& passwordInputToJava.equals(resultSet.getString("Password"))) {
					isStudent = true;
				} else {
					System.out.println("The User Name or Password are incorrect.");
				}
			

			} catch (SQLException e) {
				e.printStackTrace();
			}
		
		}
	}
%>

<%

String usernameInputToJava = new String();
String passwordInputToJava = new String();

if (request.getParameter("usernameInput") != null) {
usernameInputToJava = request.getParameter("usernameInput");
}

if (request.getParameter("passwordInput") != null) {
	passwordInputToJava = request.getParameter("passwordInput");
}

User user = new User(usernameInputToJava, passwordInputToJava);


if (user.IsAdmin()) {
	System.out.println("User Admin");
	String redirectURL = "admin/admin.jsp";
	response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
	response.setHeader("Location", redirectURL);
	response.sendRedirect(redirectURL);
	out.println("user is " + request.getParameter("usernameInput"));
}
else if (user.IsStudent()){
	String redirectURL = "student/student.jsp";
	response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
	response.setHeader("Location", redirectURL);
	response.sendRedirect(redirectURL);
	out.println("user is " + request.getParameter("usernameInput"));
}



%>

</body>
</html>