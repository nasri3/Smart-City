setInterval(function () {
    $(".commentaires.collapse.show").each(function () {
        var idPub = $(this).attr("id").replace("com", "");
        var nbCom = $("#com" + idPub).find("#comm").children("div").length;
        $.get("ctrl?operation=raifraichirCommentaires&idPub=" + idPub + "&nbCom=" + nbCom, function (responseText) {
            if (responseText === "-1") {
                if (nbCom === 0)
                    $("#com" + idPub).collapse("hide");
                return;
            }
            var d = document.createElement('div');
            $(d).load("navigation.jsp?i=" + responseText + " #com", function () {
                if ($(d).find("#com").attr("id", "comm").children("div").length === 0)
                    $("#com" + idPub).collapse("hide");
                $("#com" + idPub).find("#comm").replaceWith($(d).find("#comm"));
            });
        });
    });
}, 1000); // raifraichir les commentaires chaque 1 seconde

setInterval(function () {
    $.get("ctrl?operation=raifraichirNotifications", function (responseText) {
        $("#nbNotif").html(responseText);
    });
}, 5000); // raifraichir les notifications chaque 1 seconde

function publier() {
    var fileSize = document.getElementById('UpFile').files[0].size;
    var fileType = document.getElementById('UpFile').files[0].type;
    var allowedTypes = ["image/jpeg", "image/gif", "image/png", "image/bmp", "image/svg+xml", "video/webm", "video/ogg", "video/mp4"];
    if (fileSize < 524288000 && allowedTypes.includes(fileType)) {
        $("#uploadForm").submit();
    } else
        alert("Le fichier doit \352tre de type image ou video et la taille de fichier doit \352tre inf\350rieur \340 500MO");
}

function supprimer(idPub) {
    $.get("ctrl?operation=supprimerPub&idPub=" + idPub, function (responseText) {
        $("#" + responseText).fadeOut("slow", function () {
            $(this).remove();
        });
    });
}

function signaler(idPub) {
    $.get("ctrl?operation=signalerPub&idPub=" + idPub, function () {
        $("#dropdown" + idPub).children().eq(0).replaceWith('<button class="dropdown-item">Publication Signalé</button>');
    });
}
function suivre(idPub) {
    $.get("ctrl?operation=suivrePub&idPub=" + idPub, function () {
        $("#dropdown" + idPub).children().eq(1).replaceWith('<button class="dropdown-item">Publication Suivi</button>');
    });
}

function changerEtat(idPub, etat) {
    $.get("ctrl?operation=changerEtat&idPub=" + idPub + "&etat=" + etat, function () {
        $("#dropdown" + idPub).children().eq(2).html(etat);
    });
}

function commenter(idPub) {
    if ($("#texte" + idPub).val() !== "") {
        $.get("ctrl?operation=commenter&idPub=" + idPub + "&" + $("#texte" + idPub).serialize());
        $("#com" + idPub).collapse("show");
        $("#texte" + idPub).val("");
        $("#texte" + idPub).blur();
    }
}

function ChangerPhotoDeProfil() {
    var fileSize = document.getElementById('fichier').files[0].size;
    var fileType = document.getElementById('fichier').files[0].type;
    var allowedTypes = ["image/jpeg", "image/gif", "image/png", "image/bmp", "image/svg+xml"];
    if (fileSize < 10485760 && allowedTypes.includes(fileType)) {
        $("#PhotoDeProfilForm").submit();
    } else
        alert("Le fichier doit \352tre de type image et la taille de fichier doit \352tre inf\350rieur \340 10MO");
}

function afficherPlus(idPub) {
    var d = document.createElement("div");
    $("#afficherPlus").html('<i class="fas fa-circle-notch fa-spin fa-2x"></i>');
    $.get("ctrl?operation=ajouterPublications&idPub=" + idPub + "&titre=" + document.title, function () {
        $(d).load("navigation.jsp #publications", function () {
            $("#afficherPlus").fadeOut(300, function () {
                document.getElementById("afficherPlus").outerHTML = "";
                if ($(d.firstChild).children().length === 1)
                    $(d).find("#afficherPlus").empty();
                setCommentaireTextAreaFct(d);
                $("#publications").append($(d.firstChild).html());
            });
        });
    });
}

function setCommentaireTextAreaFct(d) {
    $(d).find("textarea").keypress(function (e) {
        if ($(document.getElementsByClassName("commenterBtn")[0]).css("display") === "none" && e.keyCode === 13 && !e.shiftKey) {
            e.preventDefault();
            commenter($(this).attr("id").toString().replace("texte", ""));
        }
    });
}

function initialiser() {
    $.get("ctrl?operation=raifraichirNotifications", function (responseText) {
        $("#nbNotif").html(responseText);
    });
    $("#publications").html('<div class="text-center"><i class="fas fa-circle-notch fa-spin fa-2x"></i></div>');
    $.get("ctrl?operation=initialiserPageAccueil", function () {
        var d1 = document.createElement('div');
        $(d1).load("home.jsp #menud", function () {
            $("#menud").html($(d1).children().eq(0).html());
        });
        var d = document.createElement('div');
        $(d).load("navigation.jsp #publications", function () {
            setCommentaireTextAreaFct(d);
            $("#publications").html($(d).html());
        });
    });
}
function modifierCatégorie(arg) {
    $.get("ctrl?operation=modifierCatégorie&catégorie=" + $(arg).html(), function () {
        if ($(arg).attr("class") === "col btn btn-outline-success")
            $(arg).attr("class", "col btn btn-success");
        else
            $(arg).attr("class", "col btn btn-outline-success");
        initialiser();
    });
}

function modifierGouvernorat(arg) {
    $.get("ctrl?operation=modifierGouvernorat&gouvernorat=" + $(arg).html(), function () {
        if ($(arg).attr("class") === "col btn btn-outline-danger")
            $(arg).attr("class", "col btn btn-danger");
        else
            $(arg).attr("class", "col btn btn-outline-danger");
        initialiser();
    });
}