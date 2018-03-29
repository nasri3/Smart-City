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
        <title>Connexion</title>
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
                </div>
            </div>
        </nav>
        <div class="row justify-content-center pt-5 mt-5 px-1 mx-1">
            <div class="col-md-4 bg-primary text-white">
                <h1>Se connecter</h1>
                <form action="signin" method="post">
                    <!-- CIN -->
                    <div id="cin" class="form-group">
                        <label for="CIN">CIN</label>
                        <input id="CIN" name="CIN" pattern="[0-9]{8}" maxlength="8" type="text" placeholder="CIN" class="form-control" required>
                        <label class="badge badge-danger">${erreurCmpt}</label> 
                    </div>
                    
                    <!-- Mot de passe -->
                    <div class="form-group"> 
                        <label for="MotDePasse">Mot de passe</label>
                        <input id="MotDePasse" name="Mot de passe" type="password" placeholder="Mot de passe" class="form-control" required>
                        <label class="badge badge-danger">${erreurMP}</label>
                    </div>
                    <button type="submit" class="btn btn-block">Se connecter</button>

                    <div class="py-5">
                        <a class="btn btn-success btn-block" href="/Register">Créer un compte</a>
                    </div>
                </form>
            </div>
        </div>
        <script src="js/verification.js" type="text/javascript"></script>
    </body>
</html>