<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/fontawesome-all.min.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <script src="js/jquery.min.js" type="text/javascript"></script>
        <script src="js/jquery-latest.min.js" type="text/javascript"></script>
        <script src="js/popper.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/myapp-functions.js" type="text/javascript"></script>

        <link rel="stylesheet" href="css/style.css">
        <title>Notifications</title>
    </head>
    <body>
        
        <nav class="navbar navbar-expand-md navbar-dark fixed-top" style="background-color: #4d636f;">
            <a class="navbar-brand text-white"><img src="files/SC.png" alt="SC" height="40"></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navb" aria-expanded="false">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div id="navb" style="" class="navbar-collapse collapse">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item mx-2"><a class="nav-link" href="/"><i class="fa fa-home fa-2x"></i> Accueil</a>
                    </li>
                    <li class="nav-item mx-2"><a class="nav-link" href="profil"><i class="fa fa-user fa-2x"></i> Profil</a>
                    </li>
                    <li class="nav-item mx-2 selected">
                        <a class="nav-link" href="Notifications">
                            <span class="fa fa-bell fa-2x"></span>
                            <span id="nbNotif" class="badge badge-danger">0</span> Notifications</a>
                    </li>
                    <c:if test='${compte.getType() == "Sous administrateur"}'>
                        <li class="nav-item mx-2"><a class="nav-link" href="Etablissement"> <i class="fa fa-building fa-2x"></i> ${compte.getEtablissement().getNom()}</a>
                        </li>
                    </c:if>
                    <c:if test='${compte.getType() == "Administrateur"}'>
                        <li class="nav-item mx-2"><a class="nav-link" href="Administration"> <i class="fa fa-briefcase fa-2x"></i> Administration</a>
                        </li>
                    </c:if>
                    <li class="nav-item mx-2"><a class="nav-link" href="Statistiques"> <i class="fa fa-2x">&#xf201;</i> Statistiques</a>
                    </li>
                </ul>
                <li class="navbar-nav nav-item"><a href="ctrl?operation=deconnecter" class="nav-link mx-2"><i class="fa fa-sign-out-alt fa-2x"></i> Déconnexion</a></li>
            </div>
        </nav>

        <div class="offset-md-2 col-md-8" id="corps">
            <div id="notifications">
                <c:forEach items="${compte.getNotificationList()}" var="notification">
                    <c:set var="ce" value="${notification.getExpediteur()}"/>
                    <div class="media-body commentaire" <c:if test='${!notification.getVu()}'> style="color: skyblue;" </c:if>> 
                        <i class="fas fa-user"></i><big><g>${ce.getPrenom()} ${ce.getNom()} (${ce.getType()})</g></big><br>
                        <i class="fas fa-calendar-alt"></i>${notification.getDatedecreation()}<br>
                        <p class="mb-0" style="white-space: pre-line;">${notification.getTexte()}</p>
                        <br>
                    </div>
                </c:forEach>
            </div>
        </div>
        <script>$.get("ctrl?operation=setNotificationsVus");</script>
    </body>
</html>