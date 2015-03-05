<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>Gallery Application</title>
    
	<link rel="stylesheet" type="text/css" href="style.css">
	
	<style>a:link {color: #000000}</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js" type="text/javascript"></script>

	<script>
	
	$(function () {
		$("#gallery > img").click(function () {
		$("img.selected").removeClass("selected");
		$(this).toggleClass("selected");
		$('#imageDesc').load('imageDesc.jsp?id=' + $(this).attr("id") + '&detid=' + $(this).attr("title") + '&info=0');
        
		});
		});
	
	</script>
		
  </head>
  <body  style="background-image:url(bg_pic.jpg)">
  
  <div class = "heading">
  
  <h1 id = "title">imgur</h1>
  
  
<% 
	String funcID = request.getParameter("funcID");
	String AddEditID = request.getParameter("AddEditID");
	String SubmitID = request.getParameter("SubmitID");

	String Save = request.getParameter("Save");
	
	String GalleryID = request.getParameter("galleryid");
	String Session_Gallery_Name = "";
	String Session_Gallery_Desc = "";
	
	String gallery_name = request.getParameter("galleryname");
	String gallery_description = request.getParameter("gallerydesc");
	
	String img_title = request.getParameter("imgtitle");
	String img_desc = request.getParameter("imgdesc");
	String imageID = request.getParameter("imageID");
	String detailID = request.getParameter("detailID");

	
%>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	}
	catch(Exception e)
	{
		out.println("can't load mysql driver");
		out.println(e.toString());
	}
%>


<form method="post">
    		<input name="funcID" type="hidden" value="1">
    		<input class = "tabs" type="submit" value="Galleries"/>
</form>

<form method="post">
			<input name="funcID" type="hidden" value="2">
    		<input  class = "tabs" type="submit" value="Artists"/>
</form>

<div id = "userdetails">

	<p class = "def"> <b>Jwala Mohith Girisha</b> </p>
	<p class = "defsmall"> ( jgirisha@uci.edu ) </p>
	
</div>

<img id = "userdp" src = "pic.jpg"/>

</div>

<div class = "tabContainer">

<!-- 
<b>2. Add a new Gallery:</b>
<form method="post">
    		<input name="funcID" type="hidden" value="3">
		Gallery name: <input name="gallery_name" type="text">
		Description: <input name="gallery_description" type="text">
    		<input type="submit" value="Add"/>
</form>
-->
<div class = "primary">
<% if(funcID!=null) {				
	try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		int func=Integer.valueOf(funcID);
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
				
		switch(func) {
			case 1:
				
				%>
					<center><h3 class = "page_title"> <b>Galleries</b> </h3></center>
				<%
				
				stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
				String sql="SELECT * FROM gallery";
				rs=stmt.executeQuery(sql); // Result set get the result of the SQL query
				while (rs.next()) {
					
					if(GalleryID == null)
						GalleryID = "0";
					
					if(GalleryID.equals(rs.getString("gallery_id"))){
					
						Session_Gallery_Name = rs.getString("name");
						Session_Gallery_Desc = rs.getString("description");

					%>
					
					<p class = "gallerynamesel">
					
						<img class = "galleryimg" src = "gallery_dp.png"/>
						<a class = "gallerynamelink" style="text-decoration:none;color:white" href="index.jsp?galleryid=<%=rs.getString("gallery_id")%>&funcID=<%="1"%>" ><b> <%= rs.getString("name")%></b></a>
						 &nbsp;<br>
						<span class = "gallerydes"> "<%= rs.getString("description")%>" </span>
					
				
					</p>
					
					<%
					}
					else{
						%>
						
					<p class = "galleryname">
					
						<img class = "galleryimg" src = "gallery_dp.png"/>
						<a class = "gallerynamelink" style="text-decoration:none;color:white" href="index.jsp?galleryid=<%=rs.getString("gallery_id")%>&funcID=<%="1"%>" ><b> <%= rs.getString("name")%></b></a>
						 &nbsp;<br>
						<span class = "gallerydes"> "<%= rs.getString("description")%>" </span>
					
					</p>
						
						
						<%					
						
					}
				}
				
				%>
				
				<form method="post">
    				<input name="AddEditID" type="hidden" value="1">
    		 		<input name="funcID" type="hidden" value="1">
    				<input class = "addedit" type="submit" value="Add Gallery"/>
				</form>
			
				
				<%
				rs.close();
				stmt.close();
				break;
				
			case 2:
				stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
				String sql_art="SELECT * FROM artist";
				rs=stmt.executeQuery(sql_art); // Result set get the result of the SQL query
				out.println("<table border=\"1\">");
				out.println("<caption> Artists List </caption>");
				out.println("<tr>");
				out.println("<th>ID</th>");
				out.println("<th>Name</th>");
				out.println("<th>Birth year</th>");
				out.println("<th>Country</th>");
				out.println("<th>Description</th>");
				out.println("</tr>");
				while (rs.next()) {
					out.println("<tr>");
					out.println("<td>"+rs.getString("artist_id")+"</td>");
					out.println("<td>"+rs.getString("name")+"</td>");
					out.println("<td>"+rs.getString("birth_year")+"</td>");
					out.println("<td>"+rs.getString("country")+"</td>");
					out.println("<td>"+rs.getString("description")+"</td>");
					out.println("</tr>");
				}
				rs.close();
				stmt.close();
				out.println("</table>");
				break;
			/* case 2:
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("insert into gallery values (default,?,?)",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, gallery_name);
				pstmt.setString(2, gallery_description);
				pstmt.executeUpdate();
				rs=pstmt.getGeneratedKeys();
				while (rs.next()) {
					out.println("Successfully added. Gallery_ID: "+rs.getInt(1));
				}
				rs.close();
				pstmt.close();
				break;*/
		}
		con.close();
	}
	catch(Exception e)
	{
			out.println("error1: " + e.toString());
	} 	
	
} %>
</div>

<div class = "secondary">
<% if(funcID!=null && AddEditID == null) {				
	try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		int func=Integer.valueOf(funcID);
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
				
		switch(func) {
			case 1:
				
				if(GalleryID != null){
					
					if(GalleryID.equals("0")){
						
						%>
						
						<Center><p class = "msg">Select a gallery to view images</p></Center>
						
						<%
						
						break;
						
					}
									
				%>
				
				
				
				
				<center>
				
					<br>
					<form class = "customform" method="post">
    					<input name="SubmitID" type="hidden" value="1">
						<input name="Save" type="hidden" value="1">
						<input name="AddEditID" type="hidden" value="1">
						<input name="funcID" type="hidden" value="1">
						<i>Name:</i> <input name="galleryname" type="text" value="<%= Session_Gallery_Name %>">
						<i>Desc:</i> <input name="gallerydesc" type="text" value="<%= Session_Gallery_Desc %>">
    					<input type="submit" value="Save"/>
					</form>
					<hr>
				
				<h3 class = "page_title"> <b>Images</b> </h3>
									<div id="gallery">
				
				
				
				<%
				
				stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
				String sql_img="SELECT * FROM image WHERE gallery_id = " + GalleryID;
				rs=stmt.executeQuery(sql_img); // Result set get the result of the SQL query

				int count = 0;

				while (rs.next()) {

					
					count++;
					%>
					
					    <img id = <%=rs.getString("image_id") %> src=<%=rs.getString("link") %> title=<%=rs.getString("detail_id") %>/> 
					<%
				}
				
				if(count ==0 ){
					
					%>
					
					<p class = "msg">No images.. Empty gallery!</p>
					
					<%
										
				}

				rs.close();
				stmt.close();
				
				%>
					
				</div>		</center>	
				
				<% if(count>0){ %>
				<br>
				<Center><div id = "imageDesc"><br><br>Select an image</div></Center>
				<%
				}
				}
				else{
					%>
					
					<center><p class = "msg">No images.. Empty gallery!</p></center>
					
					<%
				}
				break;
				
			case 2:
				stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
				String sql_art="SELECT * FROM artist";
				rs=stmt.executeQuery(sql_art); // Result set get the result of the SQL query
				out.println("<table border=\"1\">");
				out.println("<caption> Artists List </caption>");
				out.println("<tr>");
				out.println("<th>ID</th>");
				out.println("<th>Name</th>");
				out.println("<th>Birth year</th>");
				out.println("<th>Country</th>");
				out.println("<th>Description</th>");
				out.println("</tr>");
				while (rs.next()) {
					out.println("<tr>");
					out.println("<td>"+rs.getString("artist_id")+"</td>");
					out.println("<td>"+rs.getString("name")+"</td>");
					out.println("<td>"+rs.getString("birth_year")+"</td>");
					out.println("<td>"+rs.getString("country")+"</td>");
					out.println("<td>"+rs.getString("description")+"</td>");
					out.println("</tr>");
				}
				rs.close();
				stmt.close();
				out.println("</table>");
				break;
			/* case 2:
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("insert into gallery values (default,?,?)",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, gallery_name);
				pstmt.setString(2, gallery_description);
				pstmt.executeUpdate();
				rs=pstmt.getGeneratedKeys();
				while (rs.next()) {
					out.println("Successfully added. Gallery_ID: "+rs.getInt(1));
				}
				rs.close();
				pstmt.close();
				break;*/
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
					<center><h3 class = "page_title"> <b>Add Gallery</b> </h3>
					
					<form  class = "customform" method="post">
    					<input name="SubmitID" type="hidden" value="1">
						<input name="AddEditID" type="hidden" value="1">
						<input name="funcID" type="hidden" value="1">
						Gallery Name: <input class = "normaltf" name="galleryname" type="text"><br><br>
						Gallery Desc: <input class = "extendedtf" name="gallerydesc" type="text"><br><br>
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
					
					if(Save == null){
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("insert into gallery values (default,?,?)",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, gallery_name);
				pstmt.setString(2, gallery_description);
				pstmt.executeUpdate();
				rs=pstmt.getGeneratedKeys();
				while (rs.next()) {
					%>
					<center><h3 class = "page_title"> <b>Gallery added successfully!</b> </h3>
					
					<form method="post">
						<input name="funcID" type="hidden" value="1">
    					<input type="submit" value="Refresh"/>
					</form>
					
					</center>
					<%
					
				}
				pstmt.close();
				rs.close();

					}
					else{
						stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
						String sql_art="UPDATE gallery SET name=\"" + gallery_name + "\", description=\"" + gallery_description +"\" WHERE gallery_id=" + GalleryID ;
						int result=stmt.executeUpdate(sql_art); // Result set get the result of the SQL query
						if (result != 0) {
							%>
							<center><h3 class = "page_title"> <b>Gallery updated successfully!</b> </h3>
							
							<form method="post">
								<input name="funcID" type="hidden" value="1">
		    					<input type="submit" value="Refresh"/>
							</form>
							
							</center>
							<%
						}
	
					}
				break;
				
				case 2:
					stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
					String sql_art="UPDATE image SET title=\"" + img_title +"\" WHERE image_id=" + imageID ;
					int result=stmt.executeUpdate(sql_art); // Result set get the result of the SQL query
					if (result != 0) {

						stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
						sql_art="UPDATE detail SET description=\"" + img_desc +"\" WHERE image_id=" + imageID + " AND detail_id=" + detailID ;
						result=stmt.executeUpdate(sql_art); // Result set get the result of the SQL query

						if (result != 0) {
						}
						
					}

				
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
