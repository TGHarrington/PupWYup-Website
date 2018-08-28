<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@ page language="java" contentType="text/html;utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; utf-8">
<title>Administrators</title>
</head>

<body>

<h1> Welcome Administrator</h1>

<%!
public class Schedule {
	
	String URL = "jdbc:mysql://localhost:3306/puppieswithyuppies";
	String USERNAME = "root";
	String PASSWORD = "aeioU90210";
	
	Connection connection = null;
	PreparedStatement selectSchedules = null;
	ResultSet resultSet = null;
	
public Schedule () {
		
		try {
			connection = DriverManager.getConnection(URL,USERNAME,PASSWORD); 

		selectSchedules = connection.prepareStatement(
					"SELECT Date,Time, SessionBookingStatus, UserName FROM schedule");
		} catch (SQLException e) {
			e.printStackTrace();
		}
}

public ResultSet getSchedule(){
	
	try {
		resultSet = selectSchedules.executeQuery();
	} catch (SQLException e) {
		e.printStackTrace();
		}
	return resultSet;
}
}
%>		
<% 
Schedule schedule = new Schedule();
ResultSet schedules = schedule.getSchedule();
%>
<TABLE border = "1">
   <TR>
      <TD>Date</TD>
      <TD>Time</TD>
      <TD>Session Booking Status</TD>
      <TD>UserName</TD>
   </TR>
   <% while (schedules.next()) { %>
   <TR>
      <TD><%= schedules.getString("Date") %></TD>
      <TD><%= schedules.getString("Time") %></TD>
      <TD><%= schedules.getString("SessionBookingStatus") %></TD>
      <TD><%= schedules.getString("UserName") %></TD>
   </TR>
	<% } %>
</TABLE>


</body>
</html>