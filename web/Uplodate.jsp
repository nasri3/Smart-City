<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width">
        
        <link rel="stylesheet" href="css/fontawesome.min.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <script src="js/jquery.min.js" type="text/javascript"></script>
        <script src="js/jquery-latest.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/ajax.js" type="text/javascript"></script>
        <title>Insert title here</title>
    </head>
    <body>
        <h2>Uplodate Page</h2>
        <br><br><br>
        <form action="UP_Servlet"  method="post" enctype="multipart/form-data">
            <table>

                <tr>
                    <td>FILE</td>
                    <td><input type="file" name='file' ></td>
                </tr>            </table>

            <input type="submit" value="connection" >
        </form>
        <input type="file" class="" 
               title="Choisir un fichier à importer" name="composer_photo[]" 
               accept="video/*,  video/x-m4v, video/webm, video/x-ms-wmv, video/x-msvideo, 
               video/3gpp, video/flv, video/x-flv, video/mp4, video/quicktime, video/mpeg, 
               video/ogv, .ts, .mkv, image/*" multiple aria-label="Photo/Vidéo" id="js_h">
    </body>
</html>