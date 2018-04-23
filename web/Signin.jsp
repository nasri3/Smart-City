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
        
        <link rel="stylesheet" href="css/style.css">
        <title>Connexion</title>
    </head>
    <body>
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
        <script>
            var CIN = document.getElementById("CIN");
            CIN.oninput = function () {
                if (CIN.value.length === 8 && !CIN.value.toString().match(/[^0-9]/g))
                    CIN.style = "color:green";
                else
                    CIN.style = "color:red";
            };
        </script>
    </body>
</html>