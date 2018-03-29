<%@page import="com.DAO.PublicationFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@page import="com.beans.Publication"%>
<%@page import="java.util.ArrayList"%>
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
    <body style="font-size: small;">
        <!-- debut menu haut de la page ***************************** -->
        <%
            ArrayList<Publication> pubs = (ArrayList<Publication>) session.getAttribute("pubs");
            String i = request.getParameter("i");
            if (i != null && i != "") {
                pageContext.setAttribute("pub", pubs.get(Integer.valueOf(i)));
            }
        %>

        <div id="com" style="max-height: 500px;  overflow-y: auto;">
            <c:forEach items="${pub.getCommentaireList()}" var="commentaire">
                <c:set var="cc" value="${commentaire.getIdCompte()}"/>
                <div class="media">
                    <img class="mr-1 mt-2 rounded-circle" src="files/${cc.getPhotoDeProfil()}" width="35" height="35" alt="avatar">
                    <div class="media-body commentaire">
                        <div class="mt-0">
                            <a href="#">${cc.getPrenom()} ${cc.getNom()}</a>
                            <p class="mb-0" style="white-space: pre-line;">${commentaire.getText()}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div id="publications">
            <c:forEach items="${publications}" var="publication">
                <c:set var="idPub" value="${publication.getIdPublication()}" />
                <div id="pub${idPub}" class="card card-body">
                    <c:set var="Cmpt" value="${compteAnonyme}"/>
                    <c:if test="${!publication.getAnonyme()}">
                        <c:set var="Cmpt" value="${publication.getIdCompte()}"/>
                    </c:if>
                    <div class="media">
                        <img src="files/${Cmpt.getPhotoDeProfil()}" class="rounded-circle" height="45" width="45" alt="Avatar">
                        <div class="media-body ml-2" style="font-family: calibri;">
                            <div class="media">
                                <div class="col">
                                    <a href="#">${Cmpt.getPrenom()} ${Cmpt.getNom()}</a><br>
                                    <time datetime="${publication.getDate_Temps()}">${publication.getDate_Temps()}</time>
                                    <br>
                                    <i class="fa fa-map-marker"> ${publication.getLieu()} </i>
                                </div>
                                <div class="media-body text-right">
                                    <button class="btn btn-light fa fa-caret-square-down" data-toggle="dropdown"></button>
                                    <div id="dropdown${idPub}" class="dropdown-menu dropdown-menu-right">
                                        <button onclick="signaler(${idPub})" class="dropdown-item">signaler</button>
                                        <c:if test='${(compte==publication.getIdCompte()) || compte.getRole()== "Administrateur"}'>
                                            <button onclick="supprimer(${idPub})" class="dropdown-item">supprimer</button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <c:choose>
                            <c:when test='${publication.getType().contains("video")}'>
                                <video controls style="width:100%;">
                                    <source src="files/${publication.getTitre()}" type="video/mp4">
                                </video>
                            </c:when>
                            <c:otherwise>
                                <a href="files/${publication.getTitre()}" target="_blank">
                                    <img src="files/${publication.getTitre()}" style="max-width:100%; max-height: 400px;" alt="">
                                </a>
                            </c:otherwise>
                        </c:choose>
                        <div class="figure-caption">
                            <p style="white-space: pre-line;">${publication.getExprimer()}</p>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div id="monCommentaire${idPub}">
                            <div class="media">
                                <img class="rounded-circle" src="files/${Cmpt.getPhotoDeProfil()}" height="35" width="35" alt="Avatar">
                                <div class="media-body row ml-1">
                                    <div class="col-md-10"><textarea class="form-control" name="text" id="text${idPub}" placeholder="Ajouter un commentaire..."></textarea></div>
                                    <div class="col-md-2"><button onclick="commenter(${idPub})">Publier</button></div>
                                </div>
                            </div>
                        </div>
                        <label class="btn btn-link" data-toggle="collapse" data-target="#com${idPub}">
                            Afficher les commentaires
                        </label>
                        <div id="com${idPub}" class="commentaires collapse mt-1">
                            <div id="comm" class="text-center">
                                <i class="fas fa-circle-notch fa-spin" style="font-size: x-large;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <div class="row justify-content-center py-2" id="afficherPlus">
                <button onclick="afficherPlus(${idPub})">afficher plus..</button>
            </div>
        </div>

    </body>
</html>