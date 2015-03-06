<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%> 
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
	<link rel="stylesheet" type="text/css" href="imageDesc.css">

</head>
<body>
	<div id = "content">
	<%
	
	String ID = request.getParameter("id");
	String Detail_ID = request.getParameter("detid");

	if(ID != null){
		
	
	if(Detail_ID.contains("/"))
		Detail_ID = Detail_ID.substring(0, Detail_ID.length()-1);

	
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	}
	catch(Exception e)
	{
		out.println("can't load mysql driver");
		out.println(e.toString());
	}

	String url="jdbc:mysql://127.0.0.1:3306/gallery";
	String id="gallery";
	String pwd="eecs221";
	Connection con= DriverManager.getConnection(url,id,pwd); 

	String title = "";
	String desc = "";
	
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
	String sql="select * from image, detail, artist where image.image_id = detail.image_id and image.detail_id=detail.detail_id and image.artist_id=artist.artist_id and image.image_id=" + ID;
	rs=stmt.executeQuery(sql); // Result set get the result of the SQL query
	while (rs.next()) {
		
		title = rs.getString("title");
		desc = rs.getString("description");
		
		
		%>
		<img id = "image" src= <%=rs.getString("link") %>>
		<div id = "detaildiv">
		
		<h2 id = "titleid"><%= title %></h2>
		<h3 id = "descid"><%= desc %></h3><br>
		
		<p class = "detail"><span class = "detailH">Location:</span>  <%= rs.getString("location") %>, <%= rs.getString("year") %></p>
		<p class = "detail"><span class = "detailH">Artist:</span> <a href = "artist.jsp?artistid=<%=rs.getString("artist_id")%>"><%= rs.getString("name") %></a> (<%=rs.getString("artist.description") %>)</p>
		<p class = "detail"><span class = "detailH">Size:</span> <%= rs.getString("height") %> x <%= rs.getString("width") %></p>
		<br>
		<button id = "edit" onclick="unhide()">Edit Details</button>	
		<br>
		<div id = "editform" style="display:none;">
		
					<form method="post">
    					<input name="SubmitID" type="hidden" value="2">
						<input name="Save" type="hidden" value="1">
						<input name="AddEditID" type="hidden" value="1">
						<input name="funcID" type="hidden" value="1">
						<input name="imageID" type="hidden" value="<%=ID %>">
						<input name="detailID" type="hidden" value="<%= Detail_ID%>">
						
						<i>Title:</i> <input name="imgtitle" type="text" value="<%= title %>">
						<i>Desc:</i> <input name="imgdesc" type="text" value="<%= desc %>">
    					<input type="submit" value="Save Details"/>
					</form>
		
				
		</div>	
		
		
		</div>
		
		<div id = "deletediv">
					<form method="post">
    					<input name="SubmitID" type="hidden" value="3">
						<input name="Save" type="hidden" value="1">
						<input name="AddEditID" type="hidden" value="1">
						<input name="funcID" type="hidden" value="1">
						<input name="imageID" type="hidden" value="<%=ID %>">
						<input name="detailID" type="hidden" value="<%= Detail_ID%>">
						
    					<input id = "deletebtn" type="submit" value="Delete Image"/>
					</form>
		</div>
		
		<%
	}
	}
	else{
		
		
		%>
		
		<br>
				<h3>Add Image</h3>
		
					<form method="post">
    					<input name="SubmitID" type="hidden" value="4">
						<input name="Save" type="hidden" value="1">
						<input name="AddEditID" type="hidden" value="1">
						<input name="funcID" type="hidden" value="1">
						
						<i>Title:</i> <input class ="normaltf" name="addimgtitle" type="text" value=""><br>
						<i>Link:</i> <input class ="normaltf" name="addimglink" type="text" value=""><br>
    					<i>Desc:</i> <input class ="extendedtf" name="addimgdesc" type="text" value=""><br>
    					<i>Place:</i> <input class ="normaltf" name="addimglocation" type="text" value=""><br>
    					<i>Year:</i> <input class ="smalltf" name="addimgyear" type="text" value="">
    					<i>Artist ID:</i> <input class ="smalltf" name="addimgartist" type="text" value=""><br>
    					<i>Type:</i> <input class ="smalltf" name="addimgtype" type="text" value="">
    					<i>Height:</i> <input class ="smalltf" name="addimgheight" type="text" value="">
    					<i>Width:</i> <input class ="smalltf" name="addimgwidth" type="text" value=""><br>
    					<br>
    					<input type="submit" value="Add"/>
					</form>
		
		
		
		<%
		
		
	}
	
	%>
	</div>
	
	<script>

function unhide(){
	
	   document.getElementById('editform').style.display = "block";
	   document.getElementById('edit').style.display = "none";

}

</script>
	
</body>


</html>