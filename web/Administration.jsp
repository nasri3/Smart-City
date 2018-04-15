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
        <link rel="stylesheet" href="css/style.css">
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
                            <a class="nav-link" href="/Profil">${compte.getPrenom()} ${compte.getNom()}</a>
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
        <div id="corps"><hr>
            <c:forEach items="${comptes}" var="compte">
                <div id="compte${compte.getIdCompte()}" class="row m-2 p-2">
                    <div class="col">${compte.getIdCompte()}</div>
                    <div class="col">${compte.getNom()}</div>
                    <div class="col">${compte.getPrenom()}</div>
                    <div class="col">${compte.getDateDeNaissance()}</div>
                    <div class="col">${compte.getVille()}</div>
                    <div class="col btn btn-primary">${compte.getRole()}</div>
                    <div class="col btn btn-primary" onclick="supprimerCompte('${compte.getIdCompte()}')">Supprimer son Compte</div>
                    <div class="col btn btn-primary" onclick="envoyerAlerte('${compte.getIdCompte()}')">Lui envoyer une alerte</div>
                    <a class="col btn btn-link" href="/Administration/${compte.getIdCompte()}">Voir ces publications</a>
                </div><hr>
            </c:forEach>
        </div>
        <script>
            $.get("ctrl?operation=initialiserComptes", function () {
                var d = document.createElement('div');
                $(d).load("Administration #corps", function () {
                    $("#corps").html($(d).children());
                });
            });
            
            function supprimerCompte(idCompte) {
                $.get("ctrl?operation=supprimerCompte&idCompte=" + idCompte, function (responseText) {
                    $("#compte" + idCompte).fadeOut("slow", function () {
                        $(this).remove();
                    });
                });
            }

            function envoyerAlerte(idCompte) {
                alert(idCompte);
                $.get("ctrl?operation=envoyerAlerte&idCompte=" + idCompte, function () {
                    alert("succes");
                });
            }
        </script>
    </body>
</html>
