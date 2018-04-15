<%@page import="com.DAO.PublicationFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@page import="com.beans.Publication"%>
<%@page import="java.util.ArrayList"%>
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
                <c:set var="cc" value="${commentaire.getCompte()}"/>
                <div class="media">
                    <img class="mr-1 mt-2 rounded-circle" src="files/${cc.getPhotoDeProfil()}" width="35" height="35" alt="avatar">
                    <div class="media-body commentaire">
                        <a href="#">${cc.getPrenom()} ${cc.getNom()}</a>
                        <p class="mb-0" style="white-space: pre-line;">${commentaire.getTexte()}</p>
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
                        <c:set var="Cmpt" value="${publication.getCompte()}"/>
                    </c:if>
                    <div class="media">
                        <img src="files/${Cmpt.getPhotoDeProfil()}" class="rounded-circle" height="45" width="45" alt="Avatar">
                        <div class="media-body ml-2" style="font-family: calibri;">
                            <div class="media">
                                <div class="col">
                                    <a href="#">${Cmpt.getPrenom()} ${Cmpt.getNom()}</a><br>
                                    <time datetime="${publication.getDatedecréation()}">${publication.getDatedecréation()}</time>
                                    <br>
                                    <i class="fa fa-map-marker"> ${publication.getVille()} ${publication.getCatégorie()} </i>
                                </div>
                                <div class="media-body text-right">
                                    <button class="btn btn-light fa fa-caret-square-down" data-toggle="dropdown"></button>
                                    <div id="dropdown${idPub}" class="dropdown-menu dropdown-menu-right">
                                        <c:choose>
                                            <c:when test="${!compte.DejaSignaler(publication)}">
                                                <button onclick="signaler(${idPub})" class="dropdown-item">signaler</button>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="dropdown-item">Publication Signalé</div>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test='${(compte==publication.getCompte())}'>
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
                                <img class="rounded-circle mt-2" src="files/${compte.getPhotoDeProfil()}" height="35" width="35" alt="Avatar">
                                <div class="media-body row ml-1">
                                    <textarea class="form-control" name="texte" id="texte${idPub}" placeholder="Ajouter un commentaire..."></textarea>
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
            <c:if test="${idPub != null}">
                <div class="text-center" id="afficherPlus">
                    <label class="btn btn-link" onclick="afficherPlus(${idPub})">afficher plus..</label>
                </div>
            </c:if>
        </div>
        
    </body>
</html>