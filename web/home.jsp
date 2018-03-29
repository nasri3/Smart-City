<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
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
        <script src="js/ajaxx.js" type="text/javascript"></script>
        <title>Page d'accueil</title>

        <link rel="stylesheet" type="text/css" href="css/style.css">

    </head>
    <body>

        <!-- debut menu haut de la page ***************************** -->
        <nav class="navbar navbar-expand-md bg-secondary navbar-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="#">Brand</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="#">Features</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Pricing</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">About</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="#">Contact us</a>
                        </li>
                    </ul>
                    <a class="btn btn-primary" href="ctrl?operation=logout"><span class="fa fa-sign-out-alt"></span>Déconnexion</a>

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

                    <div class="card-footer">
                        <label for="setCatégorie">Catégorie</label>
                        <select id="setCatégorie" name="Catégorie" class="form-control">
                            <option>Agriculture</option>
                            <option>Éducation</option>
                            <option>Environnement</option>
                            <option>Santé</option>
                            <option>Sécurité</option>
                            <option>Sport</option>
                            <option>Tourisme</option>
                            <option>Transport</option>
                        </select>
                        <label for="setVille">Ville</label>
                        <select id="setVille" name="Ville" class="form-control">
                            <option>Ariana</option>
                            <option>Bèja</option>
                            <option>Ben Arous</option>
                            <option>Bizerte</option>
                            <option>Gabès</option>
                            <option>Gafsa</option>
                            <option>Jendouba</option>
                            <option>Kairouan</option>
                            <option>Kasserine</option>
                            <option>Kébili</option>
                            <option>Kef</option>
                            <option>Mahdia</option>
                            <option>Manouba</option>
                            <option>Médenine</option>
                            <option>Monastir</option>
                            <option>Nabeul</option>
                            <option>Sfax</option>
                            <option>Sidi Bouzid</option>
                            <option>Siliana</option>
                            <option>Sousse</option>
                            <option>Tataouine</option>
                            <option>Tozeur</option>
                            <option>Tunis</option>
                            <option>Zaghouan</option>
                        </select>
                    </div>
                </div>
            </div>


            <!-- debut corps (milieu) de la page ***************************** -->
            <div class="offset-md-2 col-md-8" id="corps"> 

                <form class="card card-body align-content-center" action="upload" method="post" enctype="multipart/form-data">
                    <fieldset>
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
                                <option>Agriculture</option>
                                <option>Éducation</option>
                                <option>Environnement</option>
                                <option>Santé</option>
                                <option>Sécurité</option>
                                <option>Sport</option>
                                <option>Tourisme</option>
                                <option>Transport</option>
                            </select>
                        </div>

                        <!-- Ville -->
                        <div class="form-group">
                            <label for="Ville">Ville</label>
                            <select id="Ville" name="Ville" class="form-control">
                                <option>Ariana</option>
                                <option>Bèja</option>
                                <option>Ben Arous</option>
                                <option>Bizerte</option>
                                <option>Gabès</option>
                                <option>Gafsa</option>
                                <option>Jendouba</option>
                                <option>Kairouan</option>
                                <option>Kasserine</option>
                                <option>Kébili</option>
                                <option>Kef</option>
                                <option>Mahdia</option>
                                <option>Manouba</option>
                                <option>Médenine</option>
                                <option>Monastir</option>
                                <option>Nabeul</option>
                                <option>Sfax</option>
                                <option>Sidi Bouzid</option>
                                <option>Siliana</option>
                                <option>Sousse</option>
                                <option>Tataouine</option>
                                <option>Tozeur</option>
                                <option>Tunis</option>
                                <option>Zaghouan</option>
                            </select>
                        </div>

                        <!-- Fichier -->
                        <div class="form-group">
                            <input type="file" required name="fichier" accept="image/*,video/*">
                            <label class="badge badge-danger">${erreurUpload}</label>
                        </div>

                        <!-- Publier -->
                        <div class="form-group">
                            <input type="submit" value="publier">
                        </div>
                    </fieldset>
                </form>
            </div>



            <!-- fin de corps (milieu) de la page ***************************** -->

            <!-- debut menu droite (milieu) de la page ***************************** -->

            <div class="col-md-2" id="menud">
                <div class="">
                    <p>ADS</p>
                </div>
                <div class="">
                    <p>ADS</p>
                </div>
            </div>
        </div>
        <script>
            if (!!window.performance && window.performance.navigation.type === 2)
            {
                window.location.reload();
            }
            $.get("ctrl?operation=initialiserPublications", function () {
                var d1 = document.createElement('div');
                $(d1).load("home_1.jsp #publications", function () {
                    $("#corps").append($(d1).children());
                });
            });
        </script>

    </body>
</html>