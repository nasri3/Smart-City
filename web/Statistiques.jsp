<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
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
                <div class="card bg-light">
                    <button data-toggle="collapse" data-target="#categories" class="m-2 btn btn-info collapsed">Catégorie : ${compte.getCategorie_interet()}</button>
                    <div id="categories" class="collapse">
                        <c:forEach items="${Catégories}" var="catégorie">
                            <c:choose>
                                <c:when test='${compte.getCategorie_interet().equals(catégorie)}'>
                                    <a class="col">${catégorie}</a>
                                </c:when>
                                <c:otherwise><a class="col" href="ctrl?operation=modifierCatégorie&catégorie=${catégorie}">${catégorie}</a></c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <button data-toggle="collapse" data-target="#gouvernorats" class="m-2 btn btn-info collapsed">Gouvernorat : ${compte.getGouvernorat_interet()}</button>
                    <div id="gouvernorats" class="collapse">
                        <c:forEach items="${Gouvernorats}" var="gouvernorat">
                            <c:choose>
                                <c:when test='${compte.getGouvernorat_interet().equals(gouvernorat)}'>
                                    <a class="col">${gouvernorat}</a>
                                </c:when>
                                <c:otherwise><a class="col" href="ctrl?operation=modifierGouvernorat&Gouvernorat=${gouvernorat}">${gouvernorat}</a></c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="offset-md-3 col-md-6" id="corps">

                <%
                    Gson gsonObj1 = new Gson();
                    Map<Object, Object> map1 = null;
                    List<Map<Object, Object>> list1 = new ArrayList<Map<Object, Object>>();

                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 10);
                    map1.put("y", 31);
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 20);
                    map1.put("y", 65);
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 30);
                    map1.put("y", 40);
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 40);
                    map1.put("y", 84);
                    map1.put("indexLabel", "Highest");
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 50);
                    map1.put("y", 68);
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 60);
                    map1.put("y", 64);
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 70);
                    map1.put("y", 38);
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 80);
                    map1.put("y", 71);
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 90);
                    map1.put("y", 54);
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 100);
                    map1.put("y", 60);
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 110);
                    map1.put("y", 21);
                    map1.put("indexLabel", "Lowest");
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 120);
                    map1.put("y", 49);
                    list1.add(map1);
                    map1 = new HashMap<Object, Object>();
                    map1.put("x", 130);
                    map1.put("y", 41);
                    list1.add(map1);

                    String dataPoints1 = gsonObj1.toJson(list1);

                    Gson gsonObj = new Gson();
                    Map<Object, Object> map2 = null;
                    List<Map<Object, Object>> list2 = new ArrayList<Map<Object, Object>>();

                    map2 = new HashMap<Object, Object>();
                    map2.put("label", "Work");
                    map2.put("y", 44);
                    list2.add(map2);
                    map2 = new HashMap<Object, Object>();
                    map2.put("label", "Gym");
                    map2.put("y", 9);
                    list2.add(map2);
                    map2 = new HashMap<Object, Object>();
                    map2.put("label", "Leisure");
                    map2.put("y", 8);
                    list2.add(map2);
                    map2 = new HashMap<Object, Object>();
                    map2.put("label", "Routines");
                    map2.put("y", 8);
                    list2.add(map2);
                    map2 = new HashMap<Object, Object>();
                    map2.put("label", "Nap");
                    map2.put("y", 2);
                    list2.add(map2);
                    map2 = new HashMap<Object, Object>();
                    map2.put("label", "Sleep");
                    map2.put("y", 29);
                    list2.add(map2);

                    String dataPoints2 = gsonObj.toJson(list2);
                %>
                <script type="text/javascript">
                    window.onload = function () {

                        var chart1 = new CanvasJS.Chart("chartContainer1", {
                            animationEnabled: true,
                            exportEnabled: true,
                            title: {
                                text: "Simple Column Chart with Index Labels"
                            },
                            data: [{
                                    type: "column", //change type to bar, line, area, pie, etc
                                    //indexLabel: "{y}", //Shows y value on all Data Points
                                    indexLabelFontColor: "#5A5757",
                                    indexLabelPlacement: "outside",
                                    dataPoints: <%out.print(dataPoints1);%>
                                }]
                        });
                        chart1.render();
                        
                        var chart2 = new CanvasJS.Chart("chartContainer2", {
                            theme: "light2", // "light1", "dark1", "dark2"
                            exportEnabled: true,
                            animationEnabled: true,
                            title: {
                                text: "Typical Day"
                            },
                            data: [{
                                    type: "pie",
                                    toolTipContent: "<b>{label}</b>: {y}%",
                                    indexLabelFontSize: 16,
                                    indexLabel: "{label} - {y}%",
                                    dataPoints: <%out.print(dataPoints2);%>
                                }]
                        });
                        chart2.render();

                    };
                </script>
                <div id="chartContainer1" style="height: 370px; width: 100%;"></div>
                <div id="chartContainer2" style="height: 370px; width: 100%;"></div>
            </div>
        </div>


    </body>
</html>
