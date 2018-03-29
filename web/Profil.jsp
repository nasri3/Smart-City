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

        <title>${compte.getPrenom()} ${compte.getNom()}</title>

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
        <div class="row" id="page">  
            <div class="col-md-2 mx-1 my-1 pb-2" id="menug">
                <div class="card text-center justify-content-md-center">
                    <div class="card-body">
                        <img src="files/${compte.getPhotoDeProfil()}" class="rounded-circle" height="50" width="50" alt="Avatar">
                        <button data-toggle="modal" data-target="#myModal" style="font-size: smaller;">
                            Modifier la photo de profil
                        </button>
                    </div>

                    <div class="card-footer">
                        <p><a href="#">Categorie</a></p>
                        <p><a href="#">Groupe</a></p>
                    </div>
                </div>
            </div>


            <!-- debut corps (milieu) de la page ***************************** -->
            <div class="offset-md-2 col-md-8" id="corps">
                <!-- The Modal -->
                <form class="modal fade text-left" id="myModal" action="ctrl" method="post" enctype="multipart/form-data">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <!-- Modal Header -->
                            <div class="modal-header">
                                <h4 class="modal-title">Modifier la photo</h4>
                                <button class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <!-- Modal body -->
                            <div class="modal-header">
                                <input class="btn btn-block btn-info" type="submit" name="submit" value="Supprimer la photo de profil">
                            </div>
                            <!-- Modal footer -->
                            <div class="modal-body">
                                <div>
                                    <input class="btn btn-info" type="file" name="fichier" accept="image/*">
                                    <input class="btn btn-info" type="submit" name="submit" value="Accepter">
                                </div>
                            </div>
                            <input type="hidden" name="operation" value="modifierPP">

                        </div>
                    </div>
                </form>
                <h1>Mes Publications</h1>
            </div>

        </div>
        <script>
            if (!!window.performance && window.performance.navigation.type === 2)
            {
                window.location.reload();
            }
            $.get("ctrl?operation=initialiserMesPublications", function () {
                var d1 = document.createElement('div'), d2 = document.createElement('div');
                $(d1).load("home_1.jsp #publications", function () {
                    $("#corps").append($(d1).children());
                });
                $(d2).load("home.jsp #menud", function () {
                    $("#page").append($(d2).children());
                });
            });
        </script>
    </body>
</html>