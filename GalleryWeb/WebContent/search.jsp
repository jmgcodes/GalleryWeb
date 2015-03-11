<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>Imgur</title>
    
	<link rel="stylesheet" type="text/css" href="style.css">
		<link rel="stylesheet" type="text/css" href="search.css">
	
	<style>a:link {color: #000000}</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js" type="text/javascript"></script>

  </head>
  <body  style="background-image:url(bg_pic.jpg)">
  
  <div class = "heading">
  
  <h1 id = "title">imgur</h1>
  
<%

	String SearchID = request.getParameter("form");
	String SubmitID = request.getParameter("submitform");


	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	}
	catch(Exception e)
	{
		out.println("can't load mysql driver");
		out.println(e.toString());
	}
%>


<form action = "index.jsp" method="post">
    		<input name="funcID" type="hidden" value="1">
    		<input class = "tabs" type="submit" value="Galleries"/>
</form>

<form action="artist.jsp" method="post">
			<input name="funcID" type="hidden" value="2">
    		<input  class = "tabs" type="submit" value="Artists"/>
</form>

<form action="search.jsp" method="post">
			<input name="funcID" type="hidden" value="3">
    		<input  class = "tabs" type="submit" value="Search"/>
</form>


<div id = "userdetails">

	<p class = "def"> <b>Jwala Mohith Girisha</b> </p>
	<p class = "defsmall"> ( jgirisha@uci.edu ) </p>
	
</div>

<img id = "userdp" src = "pic.jpg"/>

</div>

<div class = "tabContainer">

<div class = "primary">

<center><h3 class = "page_title"> <b>Search</b> </h3><hr></center>

<p class = "searchmsg"> Images by </p>
<a class = "searchcat" style="text-decoration:none;color:white" href="search.jsp?form=1"> Type >></a><br>
<a class = "searchcat" style="text-decoration:none;color:white" href="search.jsp?form=2"> Year >></a><br>
<a class = "searchcat" style="text-decoration:none;color:white" href="search.jsp?form=3"> Artist >></a><br>
<a class = "searchcat" style="text-decoration:none;color:white" href="search.jsp?form=4"> Location >></a><br>

<hr>

<p class = "searchmsg"> Artists by </p>
<a class = "searchcat" style="text-decoration:none;color:white" href="search.jsp?form=5"> Country >></a><br>
<a class = "searchcat" style="text-decoration:none;color:white" href="search.jsp?form=6"> Birth year >></a><br>

<hr>
</div>

<div class = "secondary">
<% if(SearchID == null) {				
	try {

		%>
						
			<Center><p class = "msg">Select a search type</p></Center>
						
		<%
												
	}
	catch(Exception e)
	{
			out.println("error2: " + e.toString());
	} 	
	
}
else if(SearchID != null && SubmitID == null){
	
	try {
		
		int func=Integer.valueOf(SearchID);
				
		switch(func) {
			case 1:
				
				%>
					<center><h3 class = "page_title"> <b>Search Image by Type</b> </h3>
					
					<form  class = "customform" method="post">
    					<input name="form" type="hidden" value="1">
						<input name="submitform" type="hidden" value="1">
						
						Type: <input class = "normaltf" name="searchtype" type="text"><br><br>
						
    					<input type="submit" value="Search"/>
					</form>
					
					</center>
				<%
				
			
				break;
				
			case 2:
				
				%>
					<center><h3 class = "page_title"> <b>Search Image by Year</b> </h3>
					
					<form  class = "customform" method="post">
    					<input name="form" type="hidden" value="2">
						<input name="submitform" type="hidden" value="2">
						
						From Year: <input class = "normaltf" name="searchfromyear" type="text"><br><br>
						To Year: <input class = "normaltf" name="searchtoyear" type="text"><br><br>
						
    					<input type="submit" value="Search"/>
					</form>
					
					</center>
				<%
				
			
				break;

			case 3:
				
				%>
					<center><h3 class = "page_title"> <b>Search Image by Artist</b> </h3>
					
					<form  class = "customform" method="post">
    					<input name="form" type="hidden" value="3">
						<input name="submitform" type="hidden" value="3">
						
						Artist Name: <input class = "normaltf" name="searchartist" type="text"><br>
						
    					<input type="submit" value="Search"/>
					</form>
					
					</center>
				<%
				
			
				break;

			case 4:
				
				%>
					<center><h3 class = "page_title"> <b>Search Image by Location</b> </h3>
					
					<form  class = "customform" method="post">
    					<input name="form" type="hidden" value="4">
						<input name="submitform" type="hidden" value="4">
						
						Location: <input class = "normaltf" name="searchlocation" type="text"><br>
						
    					<input type="submit" value="Search"/>
					</form>
					
					</center>
				<%
				
			
				break;

			case 5:
				
				%>
					<center><h3 class = "page_title"> <b>Search Artist by Country</b> </h3>
					
					<form  class = "customform" method="post">
    					<input name="form" type="hidden" value="5">
						<input name="submitform" type="hidden" value="5">
						
						Country: <input class = "normaltf" name="searchcountry" type="text"><br>
						
    					<input type="submit" value="Search"/>
					</form>
					
					</center>
				<%
				
			
				break;
				
			case 6:
				
				%>
					<center><h3 class = "page_title"> <b>Search Artist by Year of birth</b> </h3>
					
					<form  class = "customform" method="post">
    					<input name="form" type="hidden" value="6">
						<input name="submitform" type="hidden" value="6">
						
						Year: <input class = "normaltf" name="searchyob" type="text"><br>
						
    					<input type="submit" value="Search"/>
					</form>
					
					</center>
				<%
				
			
				break;


		}
	}
	catch(Exception e)
	{
			out.println("error3: " + e.toString());
	} 	

	
}
else if(SubmitID != null){
	
	try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		int func=Integer.valueOf(SubmitID);
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
				
		switch(func) {
				
				case 1:
					%>
					<center><h3 class = "page_title"> <b>Results for Image type "<%=request.getParameter("searchtype")%>"</b> </h3></center>
					<%
					
					stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
					String sql1="SELECT * FROM image NATURAL JOIN detail WHERE type=\"" + request.getParameter("searchtype") + "\"";
					rs=stmt.executeQuery(sql1); // Result set get the result of the SQL query
					
					int count1 = 0;
					
					while (rs.next()) {
						
						count1++;
						%>
						<p class = "results"><img src="<%=rs.getString("link") %>"/> &nbsp;&nbsp;<a target ="_blank" href = <%=rs.getString("link") %> style="text-decoration:none"><b><%=rs.getString("title") %></b> &nbsp; <i>"<%=rs.getString("description") %>"</i></a></p>
						<%
						
					}
					
					if(count1 == 0){
						%>
						<br><br>
						<Center><p class = "msg">No images found</p></Center>
						<%

					}
					rs.close();

				break;
				
				
				case 2:
					%>
					<center><h3 class = "page_title"> <b>Results for Image from "<%=request.getParameter("searchfromyear")%>" to "<%=request.getParameter("searchtoyear")%>"</b> </h3></center>
					<%
					
					stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
					String sql2="SELECT * FROM image NATURAL JOIN detail WHERE year>\"" + request.getParameter("searchfromyear") + "\" AND year<\"" + request.getParameter("searchtoyear") + "\"";
					rs=stmt.executeQuery(sql2); // Result set get the result of the SQL query
					
					int count2 = 0;
					
					while (rs.next()) {
						
						count2 ++;
						%>
						<p class = "results"><img src="<%=rs.getString("link") %>"/> &nbsp;&nbsp;<a target ="_blank"  href = <%=rs.getString("link") %> style="text-decoration:none"><b><%=rs.getString("title") %></b> &nbsp; <i>"<%=rs.getString("description") %>"</i></a></p>
						<%
						
					}
					
					if(count2 == 0){
						%>
						<br><br>
						<Center><p class = "msg">No images found</p></Center>
						<%

					}
					rs.close();

				break;

				case 3:
					%>
					<center><h3 class = "page_title"> <b>Results for Image from "<%=request.getParameter("searchartist")%>"</b> </h3></center>
					<%
					
					stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
					String sql3="SELECT * FROM image, detail, artist where image.image_id = detail.image_id and image.detail_id=detail.detail_id and image.artist_id=artist.artist_id and artist.name=\"" + request.getParameter("searchartist") + "\"";
					rs=stmt.executeQuery(sql3); // Result set get the result of the SQL query
					
					int count3 = 0;
					
					while (rs.next()) {
						
						count3 ++;
						%>
						<p class = "results"><img src="<%=rs.getString("image.link") %>"/> &nbsp;&nbsp;<a target ="_blank"  href = <%=rs.getString("image.link") %> style="text-decoration:none"><b><%=rs.getString("image.title") %></b> &nbsp; <i>"<%=rs.getString("detail.description") %>"</i></a></p>
						<%
						
					}
					
					if(count3 == 0){
						%>
						<br><br>
						<Center><p class = "msg">No images found</p></Center>
						<%

					}
					rs.close();

				break;

				case 4:
					%>
					<center><h3 class = "page_title"> <b>Results for Image Location "<%=request.getParameter("searchlocation")%>"</b> </h3></center>
					<%
					
					stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
					String sql4="SELECT * FROM image NATURAL JOIN detail WHERE location=\"" + request.getParameter("searchlocation") + "\"";
					rs=stmt.executeQuery(sql4); // Result set get the result of the SQL query
					
					int count4 = 0;
					
					while (rs.next()) {
						
						count4++;
						%>
						<p class = "results"><img src="<%=rs.getString("link") %>"/> &nbsp;&nbsp;<a target ="_blank" href = <%=rs.getString("link") %> style="text-decoration:none"><b><%=rs.getString("title") %></b> &nbsp; <i>"<%=rs.getString("description") %>"</i></a></p>
						<%
						
					}
					
					if(count4 == 0){
						%>
						<br><br>
						<Center><p class = "msg">No images found</p></Center>
						<%

					}
					rs.close();

				break;

				case 5:
					%>
					<center><h3 class = "page_title"> <b>Results for Artists from "<%=request.getParameter("searchcountry")%>"</b> </h3></center>
					<%
					
					stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
					String sql5="SELECT * FROM artist WHERE country=\"" + request.getParameter("searchcountry") + "\"";
					rs=stmt.executeQuery(sql5); // Result set get the result of the SQL query
					
					int count5 = 0;
					
					while (rs.next()) {
						
						count5++;
						%>
						<p class = "results"> &nbsp;&nbsp;<b><%=rs.getString("name") %></b> &nbsp; &nbsp; <i>"<%=rs.getString("description") %>"</i></p>
						<%
						
					}
					
					if(count5 == 0){
						%>
						<br><br>
						<Center><p class = "msg">No Artists found</p></Center>
						<%

					}
					rs.close();

				break;

				case 6:
					%>
					<center><h3 class = "page_title"> <b>Results for Artists born in "<%=request.getParameter("searchyob")%>"</b> </h3></center>
					<%
					
					stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
					String sql6="SELECT * FROM artist WHERE birth_year=\"" + request.getParameter("searchyob") + "\"";
					rs=stmt.executeQuery(sql6); // Result set get the result of the SQL query
					
					int count6 = 0;
					
					while (rs.next()) {
						
						count6++;
						%>
						<p class = "results"> &nbsp;&nbsp;<b><%=rs.getString("name") %></b> &nbsp; &nbsp; <i>"<%=rs.getString("description") %>"</i></p>
						<%
						
					}
					
					if(count6 == 0){
						%>
						<br><br>
						<Center><p class = "msg">No Artists found</p></Center>
						<%

					}
					rs.close();

				break;

				
		}
	}
	catch(Exception e)
	{
			out.println("error3: " + e.toString());
	} 	

	
}

%>

</div>

</div>
     
  </body>
  
</html>
