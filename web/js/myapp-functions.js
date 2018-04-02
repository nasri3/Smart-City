var auto = setInterval(function () {
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
            $(d).load("home_1.jsp?i=" + responseText + " #com", function () {
                if ($(d).find("#com").attr("id", "comm").children("div").length === 0)
                    $("#com" + idPub).collapse("hide");
                $("#com" + idPub).find("#comm").replaceWith($(d).find("#comm"));
            });
        });
    });
}, 1000); // refresh every 1000 milliseconds

function publier() {
    var fileSize = document.getElementById('UpFile').files[0].size;
    var fileType = document.getElementById('UpFile').files[0].type;
    var allowedTypes = ["image/jpeg", "image/gif", "image/png", "image/bmp", "image/svg+xml", "video/webm", "video/ogg", "video/mp4"];
    if (fileSize < 524288000 && allowedTypes.includes(fileType)) {
        $("#uploadForm").submit();
    } else
        alert("Le fichier doit etre de type image ou video et la taille de fichier doit etre inferieur a 500MO");
};

function supprimer(idPub) {
    $.get("ctrl?operation=supprimerPub&idPub=" + idPub, function (responseText) {
        $("#" + responseText).fadeOut("slow", function () {
            $(this).remove();
        });
    });
}

function signaler(idPub) {
    $.get("ctrl?operation=signalerPub&idPub=" + idPub);
}

function commenter(idPub) {
    $("#com" + idPub).collapse("show");
    if ($("#texte" + idPub).val() !== "")
        $.get("ctrl?operation=commenter&idPub=" + idPub + "&" + $("#texte" + idPub).serialize());
    $("#texte" + idPub).val("");
}

function ChangerPhotoDeProfil() {
    var fileSize = document.getElementById('fichier').files[0].size;
    var fileType = document.getElementById('fichier').files[0].type;
    var allowedTypes = ["image/jpeg", "image/gif", "image/png", "image/bmp", "image/svg+xml"];
    if (fileSize < 10485760 && allowedTypes.includes(fileType)) {
        $("#PhotoDeProfilForm").submit();
    } else
        alert("Le fichier doit etre de type image et la taille de fichier doit etre inferieur a 10MO");
}

function afficherPlus(idPub) {
    var d = document.createElement("div");
    $("#afficherPlus").html('<i class="fas fa-circle-notch fa-spin" style="font-size: x-large;"></i>');
    $.get("ctrl?operation=ajouterPublications&idPub=" + idPub + "&titre=" + document.title, function () {
        $(d).load("home_1.jsp #publications", function () {
            $("#afficherPlus").fadeOut(300, function () {
                document.getElementById("afficherPlus").outerHTML = "";
                if ($(d.firstChild).children().length === 1)
                    $(d).find("#afficherPlus").empty();
                $("#publications").append($(d.firstChild).children());
            });
        });
    });
}