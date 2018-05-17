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

        <c:set var="etablissement" value="${compte.getEtablissement()}"/>
        <title>${etablissement.getNom()}</title>

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
                    <li class="nav-item mx-2"><a class="nav-link" href="/"><i class="fa fa-home fa-2x"></i> Accueil</a>
                    </li>
                    <li class="nav-item mx-2"><a class="nav-link" href="profil"><i class="fa fa-user fa-2x"></i> Profil</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="Notifications">
                            <span class="fa fa-bell fa-2x"></span>
                            <span id="nbNotif" class="badge badge-danger">${nbNotif}</span> Notifications</a>
                    </li>
                    <li class="nav-item mx-2"><a class="nav-link selected" href="Etablissement"> <i class="fa fa-building fa-2x"></i> ${etablissement.getNom()}</a>
                    </li>
                    <li class="nav-item mx-2"><a class="nav-link" href="Statistiques"> <i class="fa fa-2x">&#xf201;</i> Statistiques</a>
                    </li>
                </ul>
                <li class="navbar-nav nav-item"><a href="ctrl?operation=deconnecter" class="nav-link mx-2"><i class="fa fa-sign-out-alt fa-2x"></i> Déconnexion</a></li>

            </div>
        </nav>
        <div class="row">       
            <div class="col-md-3 mx-1 my-1 pb-2 text-center" id="menug">
                <div style="background-color: #b0bdc5; color:blue;" class="card card-header my-1 py-3">
                    <img src="files/${compte.getPhotoDeProfil()}" alt="Avatar" class="rounded-circle mx-auto" width="55" height="55">
                    <br><big>${compte.getPrenom()} ${compte.getNom()}</big>
                </div>
                <div class="card bg-light">
                    <button class="m-2 btn btn-info" data-toggle="modal" data-target="#CSAModal">
                        Changer un utilisateur en un sous administrateur de cet établissement</button>
                    <button class="m-2 btn btn-info" data-toggle="modal" data-target="#evModal">
                        Nouvel évènement</button>
                    <button class="m-2 btn btn-info" data-toggle="modal" data-target="#mapModal" onclick="initMapEtablissement()">
                        Diffusion des cas de corruption</button>
                </div>
            </div>

            <div  class="offset-md-3 col-md-6" id="corps">
            </div>

            <div class="modal fade text-left" id="CSAModal">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Changer un utilisateur en un sous administrateur de cet établissement</h5>
                            <button class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <label for="CIN">Donner le CIN d'un utilisateur</label>
                            <input class="form-control" id="CIN" name="idCompte" pattern="[0-9]{8}" maxlength="8" type="text" placeholder="CIN" required>
                            <label class="mt-1 mb-2 mx-3" id="resultat" name="resultat">Veuillez respecter le format requis.</label>
                            <button class="btn btn-primary btn-block m-1" disabled="" id="op" data-dismiss="" onclick="">Changer en un sous administrateur</button>
                        </div>
                    </div>  
                </div>
            </div>
            <div class="modal fade text-left" id="evModal">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Nouvel évènement</h5>
                            <button class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <form id="evForm" class="modal-body" action="ctrl" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="nouvelEvenement">
                            <div class="form-group">
                                <label for="Titre">Titre</label>
                                <input id="Titre" name="Titre" type="text" placeholder="Titre" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="Texte">Description</label>
                                <textarea id="Texte" name="Texte" placeholder="Description" class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="Date">Date</label>
                                <input id="Date" name="Date" type="date" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="Temps">Temps</label>
                                <input id="Temps" name="Temps" type="time" class="form-control" required>
                            </div>
                            <label class="btn btn-info col-md-7 text-center" for="fichier">
                                <input id="fichier" type="file" required hidden name="fichier" accept="image/*"
                                       onchange="$('#upload-file-info').html('Choisir une image');$('#upload-file-info').html(this.files[0].name);">
                                <span id="upload-file-info">Choisir une image</span>
                            </label>
                            <label class="btn btn-info offset-md-1 col-md-3" onclick="submitFormWithImage('#evForm')">Accepter</label>
                        </form>
                    </div>  
                </div>
            </div>
            <div class="modal fade text-left" id="mapModal">
                <div class="modal-dialog modal-dialog-centered  modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Diffusion des cas de corruption sur ${etablissement.getVille()}</h5>
                            <button class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div id="map"></div>
                        </div>
                    </div>  
                </div>
            </div>
            <div id="maap" style="display: hidden;">
                <c:forEach items="${allPub}" var="publ">
                    <div type="hidden"> ${publ.getTitre()}</div>
                    <div type="hidden"> ${publ.getLat()}</div>
                    <div type="hidden"> ${publ.getLng()}</div>
                </c:forEach>
            </div>
        </div>


        <script>
            if (!!window.performance && window.performance.navigation.type === 2)
            {
                window.location.reload();
            }
            $.get("ctrl?operation=initialiserEtablissementPublications", function () {
                var d1 = document.createElement('div'), d2 = document.createElement('div');
                $(d1).load("navigation.jsp #publications", function () {
                    setCommentaireTextAreaFct(d1);
                    $("#corps").append($(d1).children());
                    $(".etat").attr("data-toggle", "modal");
                });
                $(d2).load("home.jsp #menud", function () {
                    $("#corps").after($(d2).children());
                });
            });

            function changerRoleEnSousAdministrateur(idCompte) {
                $.get("ctrl?operation=changerRoleEnSousAdministrateur&idCompte=" + idCompte, function (responseText) {
                    alert(responseText + " est maintenant un sous administrateur de cet \351tablissement");
                });
            }

            var CIN = document.getElementById("CIN");
            var op = document.getElementById("op");
            CIN.oninput = function () {
                if (CIN.value.length === 8 && !CIN.value.toString().match(/[^0-9]/g)) {
                    CIN.style = "color:green";
                    $.get("ctrl?operation=verifierExistenceCompteUtilisateur&idCompte=" + CIN.value, function (responseText) {
                        $("#resultat").html(responseText);
                        if (responseText.includes("border-success")) {
                            op.disabled = false;
                            $(op).attr("data-dismiss", "modal");
                            $(op).attr("onclick", "changerRoleEnSousAdministrateur('" + CIN.value + "')");
                        } else {
                            $("#op").attr("data-dismiss", "");
                            $(op).attr("onclick", "");
                            op.disabled = true;
                            CIN.style = "color:red";
                        }
                    });
                } else {
                    $("#op").attr("data-dismiss", "");
                    $(op).attr("onclick", "");
                    op.disabled = true;
                    $("#resultat").html("Veuillez respecter le format requis.");
                    CIN.style = "color:red";
                }
            };
        </script>
        <script>
            var markers = [];
            function addMarker(titre, lat, lng) {
                alert("markers");
                markers.push([titre, lat, lng]);
            }

            function initMapEtablissement() {
                $.get("ctrl?operation=getAllPubPlaces", function () {
                    var d = document.createElement('div');
                    $(d).load("Etablissement #maap", function () {
                        $(d).children().each(function () {
                            markers.push([$(this).children().eq(0).html(),
                                $(this).children().eq(1).html(), $(this).children().eq(2).html()]);
                        });
                        var position = new google.maps.LatLng(markers[0][1], markers[0][2]);
                        var map = new google.maps.Map(document.getElementById('map'), {
                            zoom: 12,
                            center: position
                        });
                        for (i = 0; i < markers.length; i++) {
                            alert("0: " + markers[i][0] + " 1: " + markers[i][1] + " 2: " + markers[i][2]);
                            position = new google.maps.LatLng(markers[i][1], markers[i][2]);
                            marker = new google.maps.Marker({
                                position: position,
                                map: map,
                                title: markers[i][0]
                            });
                        }
                    });
                });
            }
        </script>
        <script async defer
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD1HDRMB-tDCVaIJGpmU_0JC2HCo2YEfUs">
        </script>

    </body>
</html>