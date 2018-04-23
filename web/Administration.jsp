<%@page import="com.DAO.CompteDAO"%>
<%@page import="com.beans.Compte"%>
<%@page import="java.util.List"%>
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
        <script src="js/myapp-functions.js" type="text/javascript"></script>

        <link rel="stylesheet" href="css/style.css">
        <title>Administration</title>
    </head>
    <body>

        <nav class="navbar navbar-expand-md navbar-dark fixed-top" style="background-color: #4d636f;">
            <a class="navbar-brand text-white">COCO</a>
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
                        <a class="nav-link" href="#">
                            <span class="fa fa-bell fa-2x"></span><span class="badge badge-danger">3</span> Notifications</a>
                    </li>
                    <li class="nav-item mx-2 selected"><a class="nav-link" href="Administration"> <i class="fa fa-briefcase fa-2x"></i> Administration</a>
                    </li>
                        <li class="nav-item mx-2"><a class="nav-link" href="Statistiques"> <i class="fa fa-2x">&#xf201;</i> Statistiques</a>
                    </li>
                </ul>
                <li class="navbar-nav nav-item"><a href="ctrl?operation=deconnecter" class="nav-link mx-2"><i class="fa fa-sign-out-alt fa-2x"></i> Déconnexion</a></li>

            </div>
        </nav>

        <div id="corps" style="padding-top: 30px; margin-top: 30px;"><hr>
            <c:forEach items="${comptes}" var="compte">
                <div id="compte${compte.getIdCompte()}" class="row m-2 p-2">
                    <div class="col">${compte.getIdCompte()}</div>
                    <div class="col">${compte.getNom()}</div>
                    <div class="col">${compte.getPrenom()}</div>
                    <div class="col">${compte.getDateDeNaissance()}</div>
                    <div class="col">${compte.getVille()}</div>
                    <div class="col m-2 btn btn-primary" data-toggle="modal" data-target="#modifierTypeDeCompteModal" 
                         onclick="setIdCompte('${compte.getIdCompte()}')">${compte.getType()}</div>
                    <div class="col m-2 btn btn-primary" data-toggle="modal" data-target="#supprimerCompteModal"
                         onclick="setIdCompte('${compte.getIdCompte()}')">Supprimer son Compte</div>
                    <div class="col m-2 btn btn-primary" data-toggle="modal" data-target="#envoyerAlerteModal" 
                         onclick="setIdCompte('${compte.getIdCompte()}')">Lui envoyer une alerte</div>
                    <a class="col btn btn-link" href="/Administration/${compte.getIdCompte()}">Voir ces publications</a>
                </div>
                <hr>
            </c:forEach>
            <div class="modal text-left" id="modifierTypeDeCompteModal">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Modifier le type de ce compte en :</h5>
                            <button class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body row" id="choixDeType">
                            <button class="btn btn-primary p-2 m-2 col-5" data-dismiss="modal"
                                    onclick = "modifierType('Administrateur')">Administrateur</button>
                            <button class="btn btn-primary p-2 m-2 col-5" data-dismiss="modal"
                                    onclick = "modifierType('Sous administrateur')">Sous administrateur</button>
                            <button class="btn btn-primary p-2 m-2 col-5" data-dismiss="modal"
                                    onclick = "modifierType('Utilisateur')">Utilisateur</button>
                        </div>
                    </div>  
                </div>
            </div>
            <div class="modal text-left" id="supprimerCompteModal">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Êtes-vous sûr de vouloir supprimer définitivement ce compte?</h5>
                            <button class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body row">
                            <button class="btn btn-primary p-2 m-2 col-5" onclick="supprimerCompte()" data-dismiss="modal">oui</button>
                            <button class="btn btn-primary p-2 m-2 col-5" data-dismiss="modal">non</button>
                        </div>
                    </div>  
                </div>
            </div>
            <div class="modal text-left" id="envoyerAlerteModal">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Envoyer une alerte à ce compte?</h5>
                            <button class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body row">
                            <button class="btn btn-primary p-2 m-2 col-5" onclick="envoyerAlerte()" data-dismiss="modal">oui</button>
                            <button class="btn btn-primary p-2 m-2 col-5" data-dismiss="modal">non</button>
                        </div>
                    </div>  
                </div>
            </div>
        </div>
        <script>
            initialiser();
            function initialiser() {
                $.get("ctrl?operation=initialiserComptes", function () {
                    var d = document.createElement('div');
                    $(d).load("Administration #corps", function () {
                        $("#corps").html($(d).children());
                    });
                });
            }

            var idCompte;
            function setIdCompte(id) {
                idCompte = id;
            }

            function modifierType(type) {
                $.get("ctrl?operation=modifierType&idCompte=" + idCompte + "&type=" + type, function (responseText) {
                    initialiser();
                });
            }

            function supprimerCompte() {
                $.get("ctrl?operation=supprimerCompte&idCompte=" + idCompte, function (responseText) {
                    initialiser();
                });
            }

            function envoyerAlerte() {
                alert(idCompte);
                $.get("ctrl?operation=envoyerAlerte&idCompte=" + idCompte, function () {
                    alert("succes");
                    initialiser();
                });
            }
        </script>
    </body>
</html>
