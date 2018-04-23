<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>Page d'accueil</title>

        <link rel="stylesheet" type="text/css" href="css/style.css">

    </head>
    <body>
        
        <!-- debut menu haut de la page ***************************** -->
        <nav class="navbar navbar-expand-md navbar-dark fixed-top" style="background-color: #4d636f;">
            <a class="navbar-brand text-white">COCO</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navb" aria-expanded="false">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div id="navb" style="" class="navbar-collapse collapse">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item mx-2"><a class="nav-link selected" href="/"><i class="fa fa-home fa-2x"></i> Accueil</a>
                    </li>
                    <li class="nav-item mx-2"><a class="nav-link" href="profil"><i class="fa fa-user fa-2x"></i> Profil</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="Notifications">
                            <span class="fa fa-bell fa-2x"></span>
                            <span id="nbNotif" class="badge badge-danger">${nbNotif}</span> Notifications</a>
                    </li>
                    <c:if test='${compte.getType() == "Sous administrateur"}'>
                        <li class="nav-item mx-2"><a class="nav-link" href="Etablissement"> <i class="fa fa-building fa-2x"></i> Etablissement</a>
                        </li>
                    </c:if>
                    <c:if test='${compte.getType() == "Administrateur"}'>
                        <li class="nav-item mx-2"><a class="nav-link" href="Administration"> <i class="fa fa-briefcase fa-2x"></i> Administration</a>
                        </li>
                        <li class="nav-item mx-2"><a class="nav-link" href="Statistiques"> <i class="fa fa-2x">&#xf201;</i> Statistiques</a>
                        </li>
                    </c:if>
                </ul>
                <li class="navbar-nav nav-item"><a href="ctrl?operation=deconnecter" class="nav-link mx-2"><i class="fa fa-sign-out-alt fa-2x"></i> Déconnexion</a></li>

            </div>
        </nav>

        <!-- debut menu gauche (milieu) de la page ***************************** -->  
        <div class="row">  
            <div class="col-md-3 mx-1 my-1 pb-2" id="menug">
                <div class="card text-center">
                    <div class="card-body">
                        <img src="files/${compte.getPhotoDeProfil()}" class="rounded-circle" height="35" width="35" alt="Avatar">
                        <a href="profil">${compte.getPrenom()} ${compte.getNom()}</a>
                    </div>

                    <div class="row card-footer">
                        <label class="col-12">Catégorie</label>
                        <c:choose>
                            <c:when test='${compte.getCategorieinteret().equals("")}'>
                                <a class="col btn btn-success">Tous</a>
                            </c:when>
                            <c:otherwise><a class="col btn btn-outline-success" href="ctrl?operation=toggleCatégorie">Tous</a></c:otherwise>
                        </c:choose>
                        <c:forEach items="${Catégories}" var="catégorie">
                            <c:choose>
                                <c:when test='${compte.getCategorieinteret().equals(catégorie)}'>
                                    <a class="col btn btn-success">${catégorie}</a>
                                </c:when>
                                <c:otherwise><a class="col btn btn-outline-success" href="ctrl?operation=toggleCatégorie&catégorie=${catégorie}">${catégorie}</a></c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <label class="col-12">Ville</label>
                        <c:choose>
                            <c:when test='${compte.getVilleinteret().equals("")}'>
                                <a class="col btn btn-danger">Tous</a>
                            </c:when>
                            <c:otherwise><a class="col btn btn-outline-danger"  href="ctrl?operation=toggleVille">Tous</a></c:otherwise>
                        </c:choose>
                        <c:forEach items="${Villes}" var="ville">
                            <c:choose>
                                <c:when test='${compte.getVilleinteret().equals(ville)}'>
                                    <a class="col btn btn-danger">${ville}</a>
                                </c:when>
                                <c:otherwise><a class="col btn btn-outline-danger" href="ctrl?operation=toggleVille&ville=${ville}">${ville}</a></c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                </div>
            </div>


            <!-- debut corps (milieu) de la page ***************************** -->
            <div class="offset-md-3 col-md-6" id="corps"> 
                <label class="btn btn-block btn-outline-primary" data-toggle="modal" data-target="#uploadForm">Nouvelle Publication</label>
                <form class="modal fade align-content-center" id="uploadForm" action="upload" method="post" enctype="multipart/form-data">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">Nouvelle Publication</h4>
                                <button class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <fieldset class="modal-body">
                                <!-- Exprimer -->
                                <div class="form-group">                 
                                    <textarea class="form-control" id="Exprimer" name="Exprimer" placeholder="Exprimez-vous"></textarea>
                                </div>

                                <!-- anonyme -->
                                <div class="form-group">
                                    <label class="container form-control">Anonyme
                                        <input type="checkbox" name="Anonyme">
                                    </label>
                                </div>

                                <!-- Catégorie -->
                                <div class="form-group">
                                    <label for="Catégorie">Catégorie</label>
                                    <select id="Catégorie" name="Catégorie" class="form-control">
                                        <c:forEach items="${Catégories}" var="catégorie">
                                            <option>${catégorie}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Ville -->
                                <div class="form-group">
                                    <label for="Ville">Ville</label>
                                    <select id="Ville" name="Ville" class="form-control">
                                        <c:forEach items="${Villes}" var="ville">
                                            <option>${ville}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Fichier -->
                                <div class="form-group">
                                    <input id="UpFile" type="file" required name="fichier" accept="image/*,video/*">
                                    <label class="badge badge-danger">${erreurUpload}</label>
                                </div>

                                <!-- Publier -->
                                <div class="form-group">
                                    <label class="btn btn-outline-primary" onclick="publier()">Publier</label>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </form>
                <div id="publications"></div>
            </div>



            <!-- fin de corps (milieu) de la page ***************************** -->

            <!-- debut menu droite (milieu) de la page ***************************** -->

            <div class="col-md-3" id="menud">
                <h4>&Eacute;vènements</h4><hr>
                <div id="events" class="carousel slide" data-ride="carousel">

                    <div class="carousel-inner text-center">
                        <ul class="carousel-indicators">
                            <li data-target="#events" data-slide-to="0" class="active"></li>
                            <li data-target="#events" data-slide-to="1"></li>
                            <li data-target="#events" data-slide-to="2"></li>
                        </ul>
                        <div class="carousel-item active">
                            <img src="img/6.jpg" alt="Los Angeles">
                            <div class="">
                                <h3>Los Angeles</h3>
                                <p>We had such a great time in LA!</p>
                            </div>   
                        </div> 
                        <div class="carousel-item">
                            <img src="img/7.jpg" alt="Chicago">
                            <div class="">
                                <h3>Chicago</h3>
                                <p>Thank you, Chicago!</p>
                            </div>   
                        </div>
                        <div class="carousel-item">
                            <img src="img/9.jpg" alt="New York">
                            <div class="">
                                <h3>New York</h3>
                                <p>We love the Big Apple!</p>
                            </div>   
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#events" data-slide="prev">
                        <span class="carousel-control-prev-icon"></span>
                    </a>
                    <a class="carousel-control-next" href="#events" data-slide="next">
                        <span class="carousel-control-next-icon"></span>
                    </a>
                </div> 
            </div>
        </div>
        <script>
            if (!!window.performance && window.performance.navigation.type === 2)
            {
                window.location.reload();
            }
            initialiser();
        </script>

    </body>
</html>