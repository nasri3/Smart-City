<%@page import="com.DAO.PublicationDAO"%>
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
        <div id="fb-root"></div>
        <script>(function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id))
                    return;
                js = d.createElement(s);
                js.id = id;
                js.src = 'https://connect.facebook.net/fr_FR/sdk.js#xfbml=1&version=v2.12';
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));
        </script>

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
                <div id="pub${idPub}" class="card card-body bg-light">
                    <c:set var="Cmpt" value="${compteAnonyme}"/>
                    <c:if test="${!publication.getAnonyme()}">
                        <c:set var="Cmpt" value="${publication.getCompte()}"/>
                    </c:if>
                    <div class="media">
                        <img src="files/${Cmpt.getPhotoDeProfil()}" class="rounded-circle mt-2" height="45" width="45" alt="Avatar">
                        <div class="media-body ml-2" style="font-family: calibri;">
                            <div class="media">
                                <div style="font-size: 15px;" class="col-10"> <big><g>${Cmpt.getPrenom()} ${Cmpt.getNom()}</g></big><br>
                                    <i class="fas fa-calendar-alt"></i>${publication.getDatedecreation()}<br>
                                    <i class="fas fa-map-marker-alt"></i> ${publication.getGouvernorat()} 
                                    <i class="fas fa-th"></i> ${publication.getCategorie()}
                                    <br>
                                </div>
                                <div class="media-body text-right">
                                    <i class="fa fa-ellipsis-h" data-toggle="dropdown"></i>
                                    <div id="dropdown${idPub}" class="dropdown-menu dropdown-menu-right nav-item text-center" style="background:#4d636f;">
                                        <c:choose>
                                            <c:when test="${!compte.DejaSignaler(publication)}">
                                                <a onclick="signaler(${idPub})" class="dropdown-item nav-item">signaler</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="dropdown-item nav-item">Publication Signalé</a>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${!compte.DejaSuivi(publication)}">
                                                <a onclick="suivre(${idPub})" class="dropdown-item nav-item">suivre</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="dropdown-item nav-item">Publication Suivi</a>
                                            </c:otherwise>
                                        </c:choose>
                                        <iframe src="https://www.facebook.com/plugins/share_button.php?href=http%3A%2F%2Fpcdjee.hopto.org%2FPublication%3FidPub%3D${idPub}&layout=button_count&size=large&mobile_iframe=true&width=102&height=28&appId" 
                                                width="102" height="28" style="border:none;overflow:hidden" scrolling="no" frameborder="0" 
                                                allowTransparency="true" allow="encrypted-media">
                                        </iframe>
                                        <c:if test='${(compte==publication.getCompte())}'>
                                            <a onclick="supprimer(${idPub})" class="dropdown-item nav-item">supprimer</a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="text-center">
                        <c:choose>
                            <c:when test='${publication.getType().contains("video")}'>
                                <video controls style="width: 100%;">
                                    <source src="files/${publication.getTitre()}" type="video/mp4">
                                </video>
                            </c:when>
                            <c:otherwise>
                                <a href="files/${publication.getTitre()}" target="_blank">
                                    <img src="files/${publication.getTitre()}" style="max-width: 100%; max-height: 75vh;" alt="">
                                </a>
                            </c:otherwise>
                        </c:choose>
                        <div class="figure-caption">
                            <p style="white-space: pre-line;">${publication.getExprimer()}</p>
                        </div>
                    </div>
                    <hr>

                    <div class="container-fluid">
                        <div id="monCommentaire${idPub}">
                            <div class="media">
                                <img class="rounded-circle mt-2" src="files/${compte.getPhotoDeProfil()}" height="35" width="35" alt="Avatar">
                                <div class="media-body ml-1 row">
                                    <textarea class="form-control col-md-10" name="texte" id="texte${idPub}" placeholder="Ajouter un commentaire..." style="height: 62px; font-size:small;"></textarea>
                                    <div class="col-md-2 text-center">
                                        <button class="btn btn-primary mt-1 commenterBtn" onclick="commenter(${idPub})"><i class="fa fa-comment"> Commenter</i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <label class="btn btn-link" data-toggle="collapse" data-target="#com${idPub}">
                            Afficher les commentaires
                        </label>
                        <div id="com${idPub}" class="commentaires collapse mt-1">
                            <div id="comm" class="text-center">
                                <i class="fas fa-circle-notch fa-spin fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${idPub != null && publications.size()>=3}">
                <div class="text-center" id="afficherPlus">
                    <label class="btn btn-link" onclick="afficherPlus(${idPub})">afficher plus..</label>
                </div>
            </c:if>
        </div>

    </body>
</html>