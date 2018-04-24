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
                        <a class="nav-link" href="Notifications">
                            <span class="fa fa-bell fa-2x"></span>
                            <span id="nbNotif" class="badge badge-danger">${nbNotif}</span> Notifications</a>
                    </li>
                    <li class="nav-item mx-2 selected"><a class="nav-link" href="Administration"> <i class="fa fa-briefcase fa-2x"></i> Administration</a>
                    </li>
                    <li class="nav-item mx-2"><a class="nav-link" href="Statistiques"> <i class="fa fa-2x">&#xf201;</i> Statistiques</a>
                    </li>
                </ul>
                <li class="navbar-nav nav-item"><a href="ctrl?operation=deconnecter" class="nav-link mx-2"><i class="fa fa-sign-out-alt fa-2x"></i> Déconnexion</a></li>

            </div>
        </nav>

        <div id="corps">
            <div id="comptes">
                <c:forEach items="${comptes}" var="c">
                    <c:if test="${compte != c}">
                    <div id="compte${c.getIdCompte()}" class="media-body commentaire row">
                        <div class="col">${c.getIdCompte()}</div>
                        <div class="col">${c.getNom()}</div>
                        <div class="col">${c.getPrenom()}</div>
                        <div class="col">${c.getDateDeNaissance()}</div>
                        <div class="col">${c.getVille()}</div>
                        <div class="col btn btn-primary" data-toggle="modal" data-target="#modifierSousAdministrateurModal" 
                             onclick="setIdCompte('${c.getIdCompte()}')">
                            <c:choose>
                                <c:when test='${c.getType()=="Sous administrateur"}'>${c.getEtablissement().getNom()}</c:when>
                                <c:otherwise>Pas d'etablissement</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col btn btn-primary" data-toggle="modal" data-target="#modifierTypeDeCompteModal" 
                             onclick="setIdCompte('${c.getIdCompte()}')">${c.getType()}</div>
                        <div class="col btn btn-primary" data-toggle="modal" data-target="#supprimerCompteModal"
                             onclick="setIdCompte('${c.getIdCompte()}')">Supprimer son Compte</div>
                        <div class="col btn btn-primary" data-toggle="modal" data-target="#envoyerAlerteModal" 
                             onclick="setIdCompte('${c.getIdCompte()}')">Lui envoyer une alerte</div>
                        <a class="col btn btn-link" href="/Administration/${c.getIdCompte()}">Voir ces publications</a>
                    </div>
                    </c:if>
                </c:forEach>

                <div class="modal fade text-left" id="modifierSousAdministrateurModal">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Modifier le type de ce compte en un sous administrateur de :</h5>
                                <button class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body row" id="choixDeType">
                                <button class="btn btn-primary p-2 col-5" data-dismiss="modal"
                                        onclick = "modifierSousAdministrateur('Etablissement1')">Etablissement1</button>
                                <button class="btn btn-primary p-2 col-5" data-dismiss="modal"
                                        onclick = "modifierSousAdministrateur('Etablissement2')">Etablissement2</button>
                            </div>
                        </div>  
                    </div>
                </div>
                <div class="modal fade text-left" id="modifierTypeDeCompteModal">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Modifier le type de ce compte en :</h5>
                                <button class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body row" id="choixDeType">
                                <button class="btn btn-primary p-2 col-5" data-dismiss="modal"
                                        onclick = "modifierType('Administrateur')">Administrateur</button>
                                <button class="btn btn-primary p-2 col-5" data-dismiss="modal"
                                        onclick = "modifierType('Utilisateur')">Utilisateur</button>
                            </div>
                        </div>  
                    </div>
                </div>
                <div class="modal fade text-left" id="supprimerCompteModal">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Êtes-vous sûr de vouloir supprimer définitivement ce compte?</h5>
                                <button class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body row">
                                <button class="btn btn-primary p-2 col-5" onclick="supprimerCompte()" data-dismiss="modal">oui</button>
                                <button class="btn btn-primary p-2 col-5" data-dismiss="modal">non</button>
                            </div>
                        </div>  
                    </div>
                </div>
                <div class="modal fade text-left" id="envoyerAlerteModal">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Envoyer une alerte à ce compte?</h5>
                                <button class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body row">
                                <button class="btn btn-primary p-2 col-5" onclick="envoyerAlerte()" data-dismiss="modal">oui</button>
                                <button class="btn btn-primary p-2 col-5" data-dismiss="modal">non</button>
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
                            $("#corps").html($(d).children().children());
                        });
                    });
                }

                var idCompte;
                function setIdCompte(id) {
                    idCompte = id;
                }

                function modifierType(type) {
                    $.get("ctrl?operation=modifierType&idCompte=" + idCompte + "&type=" + type, function () {
                        initialiser();
                    });
                }

                function modifierSousAdministrateur(etablissement) {
                    $.get("ctrl?operation=modifierSousAdministrateur&idCompte=" + idCompte + "&etablissement=" + etablissement, function () {
                        initialiser();
                    });
                }

                function supprimerCompte() {
                    $.get("ctrl?operation=supprimerCompte&idCompte=" + idCompte, function (responseText) {
                        initialiser();
                    });
                }

                function envoyerAlerte() {
                    $.get("ctrl?operation=envoyerAlerte&idCompte=" + idCompte, function () {
                        alert("Alerte envoy\351");
                        initialiser();
                    });
                }
            </script>
    </body>
</html>
