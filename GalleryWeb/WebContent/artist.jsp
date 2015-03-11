<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>Imgur</title>
    
	<link rel="stylesheet" type="text/css" href="style.css">
	
	<style>a:link {color: #000000}</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js" type="text/javascript"></script>

  </head>
  <body  style="background-image:url(bg_pic.jpg)">
  
  <div class = "heading">
  
  <h1 id = "title">imgur</h1>
  
<%

	String ArtistID = request.getParameter("artistid");

	

	String AddEditID = request.getParameter("AddArtist");
	String SubmitID = request.getParameter("SubmitArtist");
	
	


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
<% 				
	try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
				
				%>
					<center><h3 class = "page_title"> <b>Artists</b> </h3><hr></center>
				<%
				
				stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
				String sql="SELECT * FROM artist";
				rs=stmt.executeQuery(sql); // Result set get the result of the SQL query
				while (rs.next()) {
					
					if(ArtistID == null){
						ArtistID = rs.getString("artist_id");
					}
					
					if(ArtistID.equals(rs.getString("artist_id"))){
					
					%>
					
					<p class = "artistnamesel">
					
						<a class = "artistnamelink" style="text-decoration:none;color:white" href="artist.jsp?artistid=<%=rs.getString("artist_id")%>" ><b> <%= rs.getString("name")%></b></a>
						 &nbsp;<br>
					
				
					</p>
					
					<%
					}
					else{
						%>
						
					<p class = "artistname">
					
						<a class = "artistnamelink" style="text-decoration:none;color:white" href="artist.jsp?artistid=<%=rs.getString("artist_id")%>" ><b> <%= rs.getString("name")%></b></a>
						 &nbsp;<br>
				
					</p>
						
						<%					
						
					}
					out.print("<hr style=\"color:#1F1F1F\">");

				}
				
				%>
				<form method="post">
    				<input name="AddArtist" type="hidden" value="1">
    				<input class = "addedit" type="submit" value="Add Artist"/>
				</form>
			
				
				<%
				rs.close();
				stmt.close();
				
		con.close();
	}
	catch(Exception e)
	{
			out.println("error1: " + e.toString());
	} 	
	
 %>
</div>

<div class = "secondary">
<% if(AddEditID == null) {				
	try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
				
				
				if(ArtistID != null){
					
					if(ArtistID.equals("0")){
						
						%>
						
						<Center><p class = "msg">Select a Artist to view details</p></Center>
						
						<%
												
					}
					else{
				
				stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
				String sql_img="SELECT * FROM artist WHERE artist_id = " + ArtistID;
				rs=stmt.executeQuery(sql_img); // Result set get the result of the SQL query

				int count = 0;

				while (rs.next()) {

					
					count++;
					%>
					
					<center>
					
					<h3 class = "page_title"> <%= rs.getString("name") %> </h3>
					
					<div class = "artistdetails">
					<center>
				<p class = "detail"><span class = "detailH">Description:</span> <%= rs.getString("description") %></p>
		
		<p class = "detail"><span class = "detailH">YOB:</span>  <%= rs.getString("birth_year") %></p>
		<p class = "detail"><span class = "detailH">Country:</span> <%= rs.getString("country") %></p>
					</center>
					
					
							<br>
		<button id = "edit" onclick="unhide()">Edit Details</button>	
		<br>
		<div id = "editform" style="display:none;">
		
					<form method="post">
    					<input name="SubmitArtist" type="hidden" value="2">
						<input name="AddArtist" type="hidden" value="2">
						
						<i>Name:</i> <input name="artname" type="text" value="<%= rs.getString("name")%>">
						<i>Desc:</i> <input name="artdesc" type="text" value="<%=rs.getString("description")%>">
    					<i>Country:</i> <input name="artcountry" type="text" value="<%=rs.getString("country")%>">
    					<input type="submit" value="Save Details"/>
					</form>
		
				
		</div>	
					
					
									</div>	
										</center>	
					
					<%
				}
				

				rs.close();
				stmt.close();
				
				}
				}
				
		con.close();
	}
	catch(Exception e)
	{
			out.println("error2: " + e.toString());
	} 	
	
}
else if(AddEditID != null && SubmitID == null){
	
	try {
		int func=Integer.valueOf(AddEditID);
				
		switch(func) {
			case 1:
				
				%>
					<center><h3 class = "page_title"> <b>Add Artist</b> </h3>
					
					<form  class = "customform" method="post">
    					<input name="SubmitArtist" type="hidden" value="1">
						<input name="AddArtist" type="hidden" value="2">
						
						Name: <input class = "normaltf" name="addartname" type="text"><br><br>
						Desc: <input class = "extendedtf" name="addartdesc" type="text"><br><br>
						YOB: <input class = "normaltf" name="addartyob" type="text"><br><br>
						Country: <input class = "normaltf" name="addartcountry" type="text"><br><br>
						
    					<input type="submit" value="Add"/>
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
					pstmt = con.prepareStatement("insert into artist values (default,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
					// Use ? to represent the variables
					pstmt.clearParameters();
					// Parameters start with 1
					pstmt.setString(1, request.getParameter("addartname"));
					pstmt.setString(2, request.getParameter("addartyob"));
					pstmt.setString(3, request.getParameter("addartcountry"));
					pstmt.setString(4, request.getParameter("addartdesc"));
					pstmt.executeUpdate();
					rs=pstmt.getGeneratedKeys();
					while (rs.next()) {
						%>
						<center><h3 class = "page_title"> <b>Artist added successfully!</b> </h3>
						
						<form method="post">
	    					<input type="submit" value="Refresh"/>
						</form>
						
						</center>
						<%
						
					}
					pstmt.close();
					rs.close();

				break;
				
				case 2:
					
					String artname = request.getParameter("artname");
					String artdesc = request.getParameter("artdesc");
					String artcountry = request.getParameter("artcountry");
					
					stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
					String sql_art="UPDATE artist SET name=\"" + artname +"\", description=\"" + artdesc + "\", country=\"" + artcountry + "\" WHERE artist_id =" + ArtistID ;
					int result=stmt.executeUpdate(sql_art); // Result set get the result of the SQL query
					if (result != 0) {

							%>
							<Center><p class = "msg">Artist details updated.. Select an artist to view details</p>
							
							<form method="post">
								<input type="submit" value="Refresh"/>
							</form>
							
							</Center>
							
							<%
						
					}
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
  
  	<script>

function unhide(){
	
	   document.getElementById('editform').style.display = "block";
	   document.getElementById('edit').style.display = "none";

}

</script>
    
  </body>
  
</html>
