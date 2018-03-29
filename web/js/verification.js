var CIN = document.getElementById("CIN");
CIN.oninput = function () {
    if (CIN.value.length === 8 && !CIN.value.toString().match(/[^0-9]/g))
        CIN.style = "color:green";
    else
        CIN.style = "color:red";
};