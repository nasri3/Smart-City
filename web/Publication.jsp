<%@page import="com.beans.Publication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width">

        <link rel="stylesheet" href="css/fontawesome-all.min.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <script src="js/jquery.min.js" type="text/javascript"></script>
        <script src="js/jquery-latest.min.js" type="text/javascript"></script>
        <script src="js/popper.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/myapp-functions.js" type="text/javascript"></script>
        
        <title>Stop Corruption</title>

        <link rel="stylesheet" type="text/css" href="css/style.css">

    </head>
    <body class="offset-md-2 col-md-8 pt-4" id="corps">

    </body>
    <script>
        if (!!window.performance && window.performance.navigation.type === 2)
        {
            window.location.reload();
        }
        $.get("ctrl?operation=getPublication&idPub=" + <%=request.getParameter("idPub")%>, function () {
            var d1 = document.createElement('div');
            $(d1).load("navigation.jsp #publications", function () {
                setCommentaireTextAreaFct(d1);
                $("#corps").append($(d1).children());
            });
        });
    </script>
</html>
