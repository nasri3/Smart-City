<%@page import="com.controller.CTRL_Servlet"%>
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
        <script src="js/jquery.canvasjs.min.js"></script>
        <script src="js/canvasjs.min.js"></script>

        <link rel="stylesheet" href="css/style.css">
        <title>Statistiques</title>
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
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="Notifications">
                            <span class="fa fa-bell fa-2x"></span>
                            <span id="nbNotif" class="badge badge-danger">${nbNotif}</span> Notifications</a>
                    </li>
                    <c:if test='${compte.getType() == "Sous administrateur"}'>
                        <li class="nav-item mx-2"><a class="nav-link" href="Etablissement"> <i class="fa fa-building fa-2x"></i> ${compte.getEtablissement().getNom()}</a>
                        </li>
                    </c:if>
                    <c:if test='${compte.getType() == "Administrateur"}'>
                        <li class="nav-item mx-2"><a class="nav-link" href="Administration"> <i class="fa fa-briefcase fa-2x"></i> Administration</a>
                        </li>
                    </c:if>
                    <li class="nav-item mx-2 selected"><a class="nav-link" href="Statistiques"> <i class="fa fa-2x">&#xf201;</i> Statistiques</a>
                    </li>
                </ul>
                <li class="navbar-nav nav-item"><a href="ctrl?operation=deconnecter" class="nav-link mx-2"><i class="fa fa-sign-out-alt fa-2x"></i> Déconnexion</a></li>

            </div>
        </nav>

        <!-- debut menu gauche (milieu) de la page ***************************** -->  
        <div class="row">  
            <div id="menug" class="text-center col-md-3 m-1 pb-2">
                <div style="background-color: #b0bdc5; color:blue;" class="card card-header my-1 py-3">
                    <img src="files/${compte.getPhotoDeProfil()}" alt="Avatar" class="rounded-circle mx-auto" width="55" height="55">
                    <br><big>${compte.getPrenom()} ${compte.getNom()}</big>
                </div>
            </div>
            <div class="offset-md-3 col-md-6" id="corps">


                <div id="chartContainer1" style="height: 370px; width: 100%;"></div>
                <div id="chartContainer2" style="height: 370px; width: 100%;"></div>
            </div>
        </div>
        <script type="text/javascript">

            window.onload = function () {
                $.get("ctrl?operation=getStatics", function () {
                    var chart1 = new CanvasJS.Chart("chartContainer1", {
                        animationEnabled: true,
                        exportEnabled: true,
                        title: {
                            text: "Nombre des cas réportés par gouvernorat"
                        },
                        data: [{
                                type: "column",
                                indexLabelFontColor: "#5A5757",
                                indexLabelPlacement: "outside",
                                dataPoints: <%out.print(session.getAttribute("dataPoints1"));%>
                            }]
                    });
                    chart1.render();
                    var chart2 = new CanvasJS.Chart("chartContainer2", {
                        theme: "light2",
                        exportEnabled: true,
                        animationEnabled: true,
                        title: {
                            text: "Pourcentage de résolution des cas de corruption"
                        },
                        data: [{
                                type: "pie",
                                toolTipContent: "<b>{label}</b>: {y}%",
                                indexLabelFontSize: 16,
                                indexLabel: "{label} - {y}%",
                                dataPoints: <%out.print(session.getAttribute("dataPoints2"));%>
                            }]
                    });
                    chart2.render();
                });
            };
        </script>


    </body>
</html>
