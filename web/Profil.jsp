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

        <title>Profil</title>

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
                    <li class="nav-item mx-2"><a class="nav-link" href="/"><i class="fa fa-home fa-2x"></i> Accueil</a>
                    </li>
                    <li class="nav-item mx-2"><a class="nav-link selected" href="profil"><i class="fa fa-user fa-2x"></i> Profil</a>
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
        <div class="row" id="page">  
            <div class="col-md-3 mx-1 my-1 pb-2" id="menug">
                <div class="card card-body bg-white ml-2 text-center">
                    <div class="form-group">
                        <img src="files/${compte.getPhotoDeProfil()}" class="rounded-circle" height="50" width="50" alt="Avatar">
                    </div>
                    <div class="form-group">
                        <button class="btn btn-success btn-block" data-toggle="modal" data-target="#modifModal">
                            Modifier la photo de profil
                        </button>
                    </div>
                    <form action="register" method="get">
                        <hr>
                        <!-- CIN -->
                        <div class="form-group">
                            <label for="CIN">CIN</label>
                            <label id="CIN">${compte.getIdCompte()}</label>
                        </div>

                        <!-- Nom -->
                        <div class="form-group">
                            <label for="Nom">Nom de la famille</label>  
                            <input id="Nom" name="Nom" type="text" value="${compte.getNom()}" class="form-control" required>
                        </div>

                        <!-- Prenom -->
                        <div class="form-group">
                            <label for="Prenom">Prénom</label>  
                            <input id="Prenom" name="Prenom" type="text" value="${compte.getPrenom()}" class="form-control" required>
                        </div>

                        <!-- Date De Naissance -->
                        <div class="form-group">
                            <label for="DateDeNaissance">Date de Naissance</label>  
                            <input  id="DateDeNaissance" name='DateDeNaissance' value="${compte.getDateDeNaissance()}" type="date" class="form-control" required>
                        </div>
                        <!-- Ville -->
                        <div class="form-group">
                            <label for="Ville">Ville</label>
                            <input id="Ville" name="Ville" type="text" value="${compte.getVille()}" placeholder="Ville" class="form-control" required>
                        </div>

                        <!-- Mot de passe 1-->
                        <div class="form-group">
                            <label for="MotDePasse1">Nouvelle mot de passe</label>
                            <input id="MotDePasse1" name="MotDePasse1" type="password" value="" placeholder="Mot de passe" class="form-control">
                        </div>

                        <!-- Mot de passe 2-->
                        <div class="form-group">
                            <label for="MotDePasse2">Confirmer le mot de passe</label>
                            <input id="MotDePasse2" name="MotDePasse2" type="password" value="" placeholder="Mot de passe" class="form-control">
                            <label class="badge badge-danger">${erreurMP}</label>
                        </div>
                        <!-- Soumettre -->
                        <div class="form-group">
                            <button type="submit" class="btn btn-block btn-success">Enregistrer les modifications</button>
                        </div>
                        <hr>
                    </form>
                        <button class="btn btn-success btn-block" data-toggle="modal" data-target="#supprModal">
                            Supprimer le compte
                        </button>
                </div>
            </div>


            <!-- debut corps (milieu) de la page ***************************** -->
            <div class="offset-md-3 col-md-6" id="corps">
                <div class="modal fade text-left" id="modifModal">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">Modifier la photo de profil</h4>
                                <button class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <form class="modal-header"  action="ctrl" method="post">
                                <input class="btn btn-block btn-primary" type="submit" name="SupprimerPP" value="Supprimer la photo de profil">
                            </form>
                            <form id="PhotoDeProfilForm" class="modal-body row"  action="ctrl" method="post" enctype="multipart/form-data">
                                <label class="btn btn-primary col-7 m-2 p-2 text-center" for="fichier">
                                    <input type="hidden" name="operation" value="modifierPhotoDeProfil">
                                    <input id="fichier" type="file" required hidden name="fichier" accept="image/*"
                                           onchange="$('#upload-file-info').html('Parcourir');$('#upload-file-info').html(this.files[0].name);">
                                    <span id="upload-file-info">Parcourir</span>
                                </label>
                                <label class="btn btn-primary col-3 m-2 p-2" onclick="ChangerPhotoDeProfil()">Accepter</label>
                            </form>
                        </div>
                    </div>
                </div>
                <form class="modal fade text-left" id="supprModal" action="ctrl" method="get">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Êtes-vous sûr de vouloir supprimer définitivement le compte</h5>
                                <button class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body row">
                                <input class="btn btn-primary p-2 m-2 col-5" type="submit" value="oui">
                                <button class="btn btn-primary p-2 m-2 col-5" data-dismiss="modal">non</button>
                            </div>
                            <input type="hidden" name="operation" value="supprimerMonCompte">
                        </div>
                    </div>
                </form>

                <h1 class="ml-4">Mes Publications</h1><hr>
            </div>

        </div>
        <script>
            if (!!window.performance && window.performance.navigation.type === 2)
            {
                window.location.reload();
            }
            $.get("ctrl?operation=initialiserProfil", function () {
                var d1 = document.createElement('div'), d2 = document.createElement('div');
                $(d1).load("navigation.jsp #publications", function () {
                    setCommentaireTextAreaFct(d1);
                    $("#corps").append($(d1).children());
                });
                $(d2).load("home.jsp #menud", function () {
                    $("#page").append($(d2).children());
                });
            });
        </script>
    </body>
</html>