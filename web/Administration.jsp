<%@page import="com.DAO.CompteFacade"%>
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
        <title>Administration</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-md bg-secondary navbar-dark fixed-top">
            <div class="container">
                <div class="navbar-brand">Administration</div>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="/">Accueil</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/profil">${compte.getPrenom()} ${compte.getNom()}</a>
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
