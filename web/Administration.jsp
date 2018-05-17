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
                    <li class="nav-item mx-2 selected"><a class="nav-link" href="Administration"> <i class="fa fa-briefcase fa-2x"></i> Administration</a>
                    </li>
                    <li class="nav-item mx-2"><a class="nav-link" href="Statistiques"> <i class="fa fa-2x">&#xf201;</i> Statistiques</a>
                    </li>
                </ul>
                <li class="navbar-nav nav-item"><a href="ctrl?operation=deconnecter" class="nav-link mx-2"><i class="fa fa-sign-out-alt fa-2x"></i> Déconnexion</a></li>

            </div>
        </nav>

        <div id="comptes" class="mt-5 pt-5">
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
                            <c:forEach items="${Etablissements}" var="etablissement">
                                <div class="btn btn-primary col" data-dismiss="modal"
                                     onclick = "modifierSousAdministrateur('${etablissement.getNom()}')">${etablissement.getNom()}</div>
                            </c:forEach>
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
                            <button class="btn btn-primary p-2 m-2 col-5" data-dismiss="modal"
                                    onclick = "modifierType('Administrateur')">Administrateur</button>
                            <button class="btn btn-primary p-2 m-2 col-5" data-dismiss="modal"
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
                            <button class="btn btn-primary p-2 m-2 col-5" onclick="supprimerCompte()" data-dismiss="modal">oui</button>
                            <button class="btn btn-primary p-2 m-2 col-5" data-dismiss="modal">non</button>
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
                            <button class="btn btn-primary p-2 m-2 col-5" onclick="envoyerAlerte()" data-dismiss="modal">oui</button>
                            <button class="btn btn-primary p-2 m-2 col-5" data-dismiss="modal">non</button>
                        </div>
                    </div>  
                </div>
            </div>
        </div>
                    <!--<table width="100%" cellspacing="2" cellpadding="2" border="1">
            <thead>
                <tr>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='id'; document.getElementById('refreshButton').click(); return true;">Session Id</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='id'; document.getElementById('refreshButton').click(); return true;">Type</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='locale'; document.getElementById('refreshButton').click(); return true;">Guessed Locale</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='user'; document.getElementById('refreshButton').click(); return true;">Guessed User name</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='CreationTime'; document.getElementById('refreshButton').click(); return true;">Creation Time</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='LastAccessedTime'; document.getElementById('refreshButton').click(); return true;">Last Accessed Time</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='UsedTime'; document.getElementById('refreshButton').click(); return true;">Used Time</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='InactiveTime'; document.getElementById('refreshButton').click(); return true;">Inactive Time</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='TTL'; document.getElementById('refreshButton').click(); return true;"><span title="Time To Live">TTL</span></a></th>
                </tr>
            </thead>
            
            <tfoot>
                <tr>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='id'; document.getElementById('refreshButton').click(); return true;">Session Id</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='id'; document.getElementById('refreshButton').click(); return true;">Type</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='locale'; document.getElementById('refreshButton').click(); return true;">Guessed Locale</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='user'; document.getElementById('refreshButton').click(); return true;">Guessed User name</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='CreationTime'; document.getElementById('refreshButton').click(); return true;">Creation Time</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='LastAccessedTime'; document.getElementById('refreshButton').click(); return true;">Last Accessed Time</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='UsedTime'; document.getElementById('refreshButton').click(); return true;">Used Time</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='InactiveTime'; document.getElementById('refreshButton').click(); return true;">Inactive Time</a></th>
                    <th><a onclick="document.getElementById('sessionsFormSort').value='TTL'; document.getElementById('refreshButton').click(); return true;"><span title="Time To Live">TTL</span></a></th>
                </tr>
            </tfoot>
            
            <tbody>

                <tr>
                    <td><input name="sessionIds" value="CED0953BBA1639DD249111E0ECD23395" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=CED0953BBA1639DD249111E0ECD23395&amp;sessionType=Primary">CED0953BBA1639DD249111E0ECD23395</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 23:26:13</td>
                    <td style="text-align: center;">2018-05-16 23:32:06</td>
                    <td style="text-align: center;">00:05:53</td>
                    <td style="text-align: center;">00:00:02</td>
                    <td style="text-align: center;">-00:01:02</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="E92AF66154D54EAD6705038C4A9510DD" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=E92AF66154D54EAD6705038C4A9510DD&amp;sessionType=Primary">E92AF66154D54EAD6705038C4A9510DD</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 18:54:02</td>
                    <td style="text-align: center;">2018-05-16 23:25:03</td>
                    <td style="text-align: center;">04:31:00</td>
                    <td style="text-align: center;">00:07:05</td>
                    <td style="text-align: center;">-00:08:05</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="CFF719642C0EB7BABBDFC1738D3DD890" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=CFF719642C0EB7BABBDFC1738D3DD890&amp;sessionType=Primary">CFF719642C0EB7BABBDFC1738D3DD890</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 23:25:03</td>
                    <td style="text-align: center;">2018-05-16 23:26:13</td>
                    <td style="text-align: center;">00:01:10</td>
                    <td style="text-align: center;">00:05:55</td>
                    <td style="text-align: center;">-00:06:55</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="FA5DFCBB545F3640D166102BE5DB5254" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=FA5DFCBB545F3640D166102BE5DB5254&amp;sessionType=Primary">FA5DFCBB545F3640D166102BE5DB5254</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 18:54:02</td>
                    <td style="text-align: center;">2018-05-16 18:54:02</td>
                    <td style="text-align: center;">00:00:00</td>
                    <td style="text-align: center;">04:38:06</td>
                    <td style="text-align: center;">-04:39:06</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="B208A30D91B9BEFA066335A98379463F" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=B208A30D91B9BEFA066335A98379463F&amp;sessionType=Primary">B208A30D91B9BEFA066335A98379463F</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-15 23:33:55</td>
                    <td style="text-align: center;">2018-05-16 13:44:16</td>
                    <td style="text-align: center;">14:10:20</td>
                    <td style="text-align: center;">09:47:52</td>
                    <td style="text-align: center;">-09:48:52</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="588F8173E39BF776363970C5F0775F60" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=588F8173E39BF776363970C5F0775F60&amp;sessionType=Primary">588F8173E39BF776363970C5F0775F60</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 13:44:16</td>
                    <td style="text-align: center;">2018-05-16 13:57:51</td>
                    <td style="text-align: center;">00:13:34</td>
                    <td style="text-align: center;">09:34:17</td>
                    <td style="text-align: center;">-09:35:17</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="A3DF36A9EF493183C438D0A1B707D84D" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=A3DF36A9EF493183C438D0A1B707D84D&amp;sessionType=Primary">A3DF36A9EF493183C438D0A1B707D84D</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 14:00:05</td>
                    <td style="text-align: center;">2018-05-16 14:09:02</td>
                    <td style="text-align: center;">00:08:57</td>
                    <td style="text-align: center;">09:23:06</td>
                    <td style="text-align: center;">-09:24:06</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="A11C58613398C545E440195998BB580E" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=A11C58613398C545E440195998BB580E&amp;sessionType=Primary">A11C58613398C545E440195998BB580E</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 15:14:27</td>
                    <td style="text-align: center;">2018-05-16 15:16:10</td>
                    <td style="text-align: center;">00:01:42</td>
                    <td style="text-align: center;">08:15:58</td>
                    <td style="text-align: center;">-08:16:58</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="EF95AAEF32A14375D0F05466CE1AE214" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=EF95AAEF32A14375D0F05466CE1AE214&amp;sessionType=Primary">EF95AAEF32A14375D0F05466CE1AE214</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 14:11:27</td>
                    <td style="text-align: center;">2018-05-16 14:11:27</td>
                    <td style="text-align: center;">00:00:00</td>
                    <td style="text-align: center;">09:20:41</td>
                    <td style="text-align: center;">-09:21:41</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="D37E11A7E9BE5D8151DEAC9E7E0C6646" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=D37E11A7E9BE5D8151DEAC9E7E0C6646&amp;sessionType=Primary">D37E11A7E9BE5D8151DEAC9E7E0C6646</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 16:36:25</td>
                    <td style="text-align: center;">2018-05-16 17:13:01</td>
                    <td style="text-align: center;">00:36:35</td>
                    <td style="text-align: center;">06:19:07</td>
                    <td style="text-align: center;">-06:20:07</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="EA8B466E35D40571E470602D01917B9E" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=EA8B466E35D40571E470602D01917B9E&amp;sessionType=Primary">EA8B466E35D40571E470602D01917B9E</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 15:16:49</td>
                    <td style="text-align: center;">2018-05-16 16:21:55</td>
                    <td style="text-align: center;">01:05:06</td>
                    <td style="text-align: center;">07:10:13</td>
                    <td style="text-align: center;">-07:11:13</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="C52878EF9FC4A6EBEC25A522871A8DCA" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=C52878EF9FC4A6EBEC25A522871A8DCA&amp;sessionType=Primary">C52878EF9FC4A6EBEC25A522871A8DCA</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 14:05:59</td>
                    <td style="text-align: center;">2018-05-16 14:05:59</td>
                    <td style="text-align: center;">00:00:00</td>
                    <td style="text-align: center;">09:26:09</td>
                    <td style="text-align: center;">-09:27:09</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="347CC26407CBB84FCDDE3C5279AF533D" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=347CC26407CBB84FCDDE3C5279AF533D&amp;sessionType=Primary">347CC26407CBB84FCDDE3C5279AF533D</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 14:14:23</td>
                    <td style="text-align: center;">2018-05-16 14:14:24</td>
                    <td style="text-align: center;">00:00:00</td>
                    <td style="text-align: center;">09:17:44</td>
                    <td style="text-align: center;">-09:18:44</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="987431195B049A915EBC055CB52EC660" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=987431195B049A915EBC055CB52EC660&amp;sessionType=Primary">987431195B049A915EBC055CB52EC660</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 14:51:57</td>
                    <td style="text-align: center;">2018-05-16 14:51:57</td>
                    <td style="text-align: center;">00:00:00</td>
                    <td style="text-align: center;">08:40:11</td>
                    <td style="text-align: center;">-08:41:11</td>
                </tr>

                <tr>
                    <td><input name="sessionIds" value="AB1DC90E26885CD60FE44D9E495E70FF" type="checkbox">
                      
                      <a href="/manager/html/sessions?path=&amp;version=&amp;org.apache.catalina.filters.CSRF_NONCE=F1475D3D851387BD896F7991AEC1D503&amp;action=sessionDetail&amp;sessionId=AB1DC90E26885CD60FE44D9E495E70FF&amp;sessionType=Primary">AB1DC90E26885CD60FE44D9E495E70FF</a>
                      
                    </td>
                    <td style="text-align: center;">Primary</td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;"></td>
                    <td style="text-align: center;">2018-05-16 18:54:02</td>
                    <td style="text-align: center;">2018-05-16 18:54:02</td>
                    <td style="text-align: center;">00:00:00</td>
                    <td style="text-align: center;">04:38:06</td>
                    <td style="text-align: center;">-04:39:06</td>
                </tr>

            </tbody>
        </table>-->
        <script>
            initialiserComptes();
            function initialiserComptes() {
                $.get("ctrl?operation=initialiserComptes", function () {
                    var d = document.createElement('div');
                    $(d).load("Administration #comptes", function () {
                        $("#comptes").html($(d).children().children());
                    });
                });
            }

            var idCompte;
            function setIdCompte(id) {
                idCompte = id;
            }

            function modifierType(type) {
                $.get("ctrl?operation=modifierType&idCompte=" + idCompte + "&type=" + type, function () {
                    initialiserComptes();
                });
            }

            function modifierSousAdministrateur(etablissement) {
                $.get("ctrl?operation=modifierSousAdministrateur&idCompte=" + idCompte + "&etablissement=" + etablissement, function () {
                    initialiserComptes();
                });
            }

            function supprimerCompte() {
                $.get("ctrl?operation=supprimerCompte&idCompte=" + idCompte, function (responseText) {
                    initialiserComptes();
                });
            }

            function envoyerAlerte() {
                $.get("ctrl?operation=envoyerAlerte&idCompte=" + idCompte, function () {
                    alert("Alerte envoy\351");
                    initialiserComptes();
                });
            }
        </script>
    </body>
</html>
