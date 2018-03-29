var auto = setInterval(function () {
    $(".commentaires.collapse.show").each(function () {
        var idPub = $(this).attr("id").replace("com", "");
        $.get("ctrl?operation=raifraichirCommentaires&ID=" + idPub, function (responseText) {
            var d = document.createElement('div');
            $(d).load("home_1.jsp?i=" + responseText + " #com", function () {
                if ($(d).find("#com").attr("id", "comm").children("div").length === 0)
                    $("#com" + idPub).collapse("hide");
                if ($(d).find("#comm").children("div").length !== $("#com" + idPub).find("#comm").children("div").length)
                    $("#com" + idPub).find("#comm").replaceWith($(d).find("#comm"));
            });
        });
    });
}, 1000); // refresh every 1000 milliseconds

function supprimer(idPub) {
    $.get("ctrl?operation=supprimerPub&ID=" + idPub, function (responseText) {
        $("#" + responseText).fadeOut("slow", function () {
            $(this).remove();
        });
    });
}

function signaler(idPub) {
    $.get("ctrl?operation=signalerPub&ID=" + idPub);
}

function commenter(idPub) {
    $("#com" + idPub).collapse("show");
    if($("#text" + idPub).val() !== "")
        $.get("ctrl?operation=commenter&ID=" + idPub + "&text=" + $("#text" + idPub).val().replace(/\n/g, "<br />"));
}
function afficherPlus(idPub) {
    var d = document.createElement("div");
    $("#afficherPlus").html('<i class="fas fa-circle-notch fa-spin" style="font-size: x-large;"></i>');
    $.get("ctrl?operation=ajouterPublications&ID=" + idPub + "&titre=" + document.title, function () {
        $(d).load("home_1.jsp #publications", function () {
            $("#afficherPlus").fadeOut(300, function () {
                document.getElementById("afficherPlus").outerHTML = "";
                if($(d.firstChild).children().length === 1)
                    $(d).find("#afficherPlus").empty();
                $("#publications").append($(d.firstChild).children());
            });
        });
    });
}