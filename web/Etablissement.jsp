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
                    <button class="m-2 btn btn-info" style="white-space: normal" data-toggle="modal" data-target="#CSAModal">
                        Changer un utilisateur en un sous administrateur de cet établissement</button>
                    <button class="m-2 btn btn-info" data-toggle="modal" data-target="#evModal">Nouvel évenement</button>
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
                    alert("ok");
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
                        if (responseText.includes("bg-success")) {
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
    </body>
</html>