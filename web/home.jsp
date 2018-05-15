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
        <script src="https://maps.googleapis.com/maps/api/js?libraries=places"></script>
        <script src="js/map.js" type="text/javascript"></script>

        <title>Page d'accueil</title>

        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>

    <body>

        <!-- debut menu haut de la page ***************************** -->
        <nav class="navbar navbar-expand-md navbar-dark fixed-top" style="background-color: #4d636f;">
            <a class="navbar-brand text-white"><img src="files/SC.png" alt="SC" height="40"></a>
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

        <!-- debut menu gauche (milieu) de la page ***************************** -->  
        <div class="row">  
            <div id="menug" class="text-center col-md-3 mx-1 my-1 pb-2">
                <div style="background-color: #b0bdc5; color:blue;" class="card card-header my-1 py-3">
                    <img src="files/${compte.getPhotoDeProfil()}" alt="Avatar" class="rounded-circle mx-auto" width="55" height="55">
                    <br><big>${compte.getPrenom()} ${compte.getNom()}</big>
                </div>
                <div class="card bg-light">
                    <button data-toggle="modal" data-target="#uploadForm" onclick="initMap()" class="m-2 btn btn-info">Nouvelle Publication</button>

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


            <!-- debut corps (milieu) de la page ***************************** -->
            <div class="offset-md-3 col-md-6" id="corps">
                <form class="modal fade align-content-center" data-backdrop="static" onkeypress="return event.keyCode!==13"
                      id="uploadForm" action="upload" method="post" enctype="multipart/form-data">
                    <div class="modal-dialog modal-dialog-centered modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">Nouvelle Publication</h4>
                                <a class="close" data-dismiss="modal">&times;</a>
                            </div>
                            <fieldset class="modal-body row">
                                <!-- Description -->
                                <div class="col-md-6">                 
                                    <textarea class="form-control" id="Description" name="Description" placeholder="Exprimez-vous"></textarea>
                                    <label class="col-md-12 border">Anonyme
                                        <input type="checkbox" name="Anonyme">
                                    </label><br>
                                </div>

                                <!-- anonyme -->
                                <!-- Catégorie -->
                                <div class="col-md-6">
                                    <label for="Catégorie">Catégorie</label>
                                    <select id="Catégorie" name="Catégorie" class="form-control">
                                        <c:forEach items="${Catégories}" var="catégorie">
                                            <c:if test='${!catégorie.equals("Tous")}'><option>${catégorie}</option></c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <!-- Gouvernorat -->
                                <div class="col-md-6">
                                    <label for="gouvernorat">Gouvernorat</label>
                                    <input class="form-control" type="text" onmousedown='return false;' 
                                           onselectstart='return false;' readonly required id="gouvernorat" name="Gouvernorat" placeholder="Gouvernorat">
                                </div>

                                <!-- Ville -->
                                <div class="col-md-6">        
                                    <label for="ville">Ville</label>         
                                    <input class="form-control" type="text" onmousedown='return false;' 
                                           onselectstart='return false;' readonly required id="ville" name="Ville" placeholder="Ville">
                                </div>

                                <!-- Addresse -->
                                <div class="col-md-12"> 
                                    <label for="pac-input">Adresse</label>                
                                    <input id="pac-input" class="form-control" type="text" required id="Addresse" name="Addresse" placeholder="Addresse" oninput="fixContainerPos()">
                                </div>
                                <div class="col-md-11" id="map-canvas"></div>
                                <!-- Lat -->                
                                <input type="hidden" required id="Lat" name="Lat">

                                <!-- Lng -->               
                                <input type="hidden" required id="Lng" name="Lng">
                                
                                <!-- Publier -->
                                <div class="col-md-12">
                                    <label class="btn btn-info col-md-7 text-center" for="UpFile">
                                        <input id="UpFile" type="file" required hidden name="fichier" accept="image/*,video/*"
                                               onchange="$('#upload-file-info').html('Choisir un fichier');$('#upload-file-info').html(this.files[0].name);">
                                        <span id="upload-file-info">Choisir un fichier</span>
                                        <label class="badge badge-danger">${erreurUpload}</label>
                                    </label>
                                    <label class="btn btn-info offset-md-1 col-md-3" onclick="publier()">Publier</label>
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
                            <li data-target="#events" data-slide-to="0" class="active">
                            </li>
                            <c:forEach items="${evenements}" begin="1" varStatus="i">
                                <li data-target="#events" data-slide-to="${i.index}">
                                </li>
                            </c:forEach>
                        </ul>
                        <c:forEach items="${evenements}" var="e" varStatus="i">
                            <c:if test="${i.index == 0}"><div class="carousel-item active"></c:if>
                                <c:if test="${i.index != 0}"><div class="carousel-item"></c:if>
                                    <img src="files/${e.getImage()}" alt="image">
                                    <div>
                                        <h5>${e.getTitre()}</h5>
                                        <g>${e.getDate()}</g>
                                        <p>${e.getTexte()}</p>
                                    </div>   
                                </div>
                            </c:forEach>
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
        </div>
        <script>
            if (!!window.performance && window.performance.navigation.type === 2)
            {
                window.location.reload();
            }
            init();
        </script>

    </body>
</html>
