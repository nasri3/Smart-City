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
        <nav class="navbar navbar-expand-md bg-secondary navbar-dark fixed-top">
            <div class="container">
                <div class="navbar-brand">Accueil</div>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="profil">${compte.getPrenom()} ${compte.getNom()}</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Notifications</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">À propos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Contactez-nous</a>
                        </li>
                    </ul>
                    <a class="btn btn-primary" href="ctrl?operation=deconnecter"><span class="fa fa-sign-out-alt"></span>Déconnexion</a>

                </div>
            </div>
        </nav>

        <!-- debut menu gauche (milieu) de la page ***************************** -->  
        <div class="row">  
            <div class="col-md-2 mx-1 my-1 pb-2" id="menug">
                <div class="card text-center">
                    <div class="card-body">
                        <img src="files/${compte.getPhotoDeProfil()}" class="rounded-circle" height="35" width="35" alt="Avatar">
                        <a href="profil">${compte.getPrenom()} ${compte.getNom()}</a>
                    </div>

                    <div class="row card-footer">
                        <label class="col-12">Catégorie</label>
                        <c:forEach items="${Catégories}" var="catégorie">
                            <c:choose>
                                <c:when test='${compte.getCatégorieinteret().contains(catégorie)}'>
                                    <button class="col btn btn-success" onclick="toggleCatégorie(this)">${catégorie}</button>
                                </c:when>
                                <c:otherwise><button class="col btn btn-outline-success" onclick="toggleCatégorie(this)">${catégorie}</button></c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <label class="col-12">Ville</label>
                        <c:forEach items="${Villes}" var="ville">
                            <c:choose>
                                <c:when test='${compte.getVilleinteret().contains(ville)}'>
                                    <button class="col btn btn-danger" onclick="toggleVille(this)">${ville}</button>
                                </c:when>
                                <c:otherwise><button class="col btn btn-outline-danger" onclick="toggleVille(this)">${ville}</button></c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div class="card-footer">
                        <label for="setCatégorie">Catégorie</label>
                        <select id="setCatégorie" name="Catégorie" class="form-control">
                            <c:forEach items="${Catégories}" var="catégorie">
                                <option>${catégorie}</option>
                            </c:forEach>
                        </select>
                        <label for="setVille">Ville</label>
                        <select id="setVille" name="Ville" class="form-control">
                            <c:forEach items="${Villes}" var="ville">
                                <option>${ville}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>


            <!-- debut corps (milieu) de la page ***************************** -->
            <div class="offset-md-2 col-md-8" id="corps"> 
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

            <div class="col-md-2" id="menud">
                <div class="">
                    <h4>&Eacute;vènements</h4><hr>
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