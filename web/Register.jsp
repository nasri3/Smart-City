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
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <title>Créer un compte</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-md bg-secondary navbar-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="#">Brand</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="#">Features</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Pricing</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">About</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="#">Contact us</a>
                        </li>
                    </ul>
                    <a class="btn btn-primary" href="/"><span class="fa fa-sign-out-alt"></span>Connexion</a>
                </div>
            </div>
        </nav>
        <div class="row justify-content-center py-5 my-5 px-1 mx-1">
            <div class="col-md-4 bg-primary text-white">
                <h1>Créer un compte</h1>
                <form action="register" method="post">
                    <!-- CIN -->
                    <div class="form-group">
                        <label for="CIN">CIN</label>  
                        <input id="CIN" name="CIN" pattern="[0-9]{8}" maxlength="8" type="text" placeholder="CIN" class="form-control" required>
                        <label class="badge badge-danger">${erreurCmpt}</label>
                    </div>

                    <!-- Nom -->
                    <div class="form-group">
                        <label for="Nom">Nom de la famille</label>  
                        <input id="Nom" name="Nom" type="text" placeholder="Nom de la famille" class="form-control" required>
                    </div>

                    <!-- Prenom -->
                    <div class="form-group">
                        <label for="Prenom">Prénom</label>  
                        <input id="Prenom" name="Prenom" type="text" placeholder="Prénom" class="form-control" required>
                    </div>

                    <!-- Date De Naissance -->
                    <div class="form-group">
                        <label for="DateDeNaissance">Date de Naissance</label>  
                        <input  id="DateDeNaissance" name='DateDeNaissance' type="date" class="form-control" required>
                    </div>
                    <!-- Ville -->
                    <div class="form-group">
                        <label for="Ville">Ville</label>
                        <select id="Ville" name="Ville" class="form-control dropdown">
                            <option>Ariana</option>
                            <option>Bèja</option>
                            <option>Ben Arous</option>
                            <option>Bizerte</option>
                            <option>Gabès</option>
                            <option>Gafsa</option>
                            <option>Jendouba</option>
                            <option>Kairouan</option>
                            <option>Kasserine</option>
                            <option>Kébili</option>
                            <option>Kef</option>
                            <option>Mahdia</option>
                            <option>Manouba</option>
                            <option>Médenine</option>
                            <option>Monastir</option>
                            <option>Nabeul</option>
                            <option>Sfax</option>
                            <option>Sidi Bouzid</option>
                            <option>Siliana</option>
                            <option>Sousse</option>
                            <option>Tataouine</option>
                            <option>Tozeur</option>
                            <option>Tunis</option>
                            <option>Zaghouan</option>
                        </select>
                    </div>

                    <!-- Mot de passe 1-->
                    <div class="form-group">
                        <label for="MotDePasse1">Créer un mot de passe</label>
                        <input id="MotDePasse1" name="MotDePasse1" type="password" placeholder="Mot de passe" class="form-control" required>
                    </div>

                    <!-- Mot de passe 2-->
                    <div class="form-group">
                        <label for="MotDePasse2">Confirmer le mot de passe</label>
                        <input id="MotDePasse2" name="MotDePasse2" type="password" placeholder="Mot de passe" class="form-control" required>
                        <label class="badge badge-danger">${erreurMP}</label>
                    </div>

                    <!-- Soumettre -->
                    <div class="pb-5">
                        <button type="submit" class="btn col-12">Soumettre</button>
                    </div>
                </form>
            </div>
        </div>
                    
        <script src="js/verification.js" type="text/javascript"></script>
    </body>
</html>