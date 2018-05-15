/* global google */

var geocoder;
var map;
var infowindow = new google.maps.InfoWindow();
var marker = new google.maps.Marker();
var adresse;

function initMap() {
    var pos = {
        lat: 36.8064948,
        lng: 10.181531599999971
    };

    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(pos.lat, pos.lng);
    var mapOptions = {
        zoom: 15,
        center: latlng,
        mapTypeId: 'roadmap'
    };
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
    map.addListener('click', function (e) {
        codeLatLng(e.latLng);
        document.getElementById('pac-input').value = adresse;
    });

    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };
            latlng = new google.maps.LatLng(pos.lat, pos.lng);
            codeLatLng(latlng);
        });
    } else {
        // Browser doesn't support Geolocation
        codeLatLng(latlng);
    }
    // Create the search box and link it to the UI element.
    var input = document.getElementById('pac-input');
    input.value = "";
    var searchBox = new google.maps.places.SearchBox(input);
    
    searchBox.addListener('places_changed', function () {
        var places = searchBox.getPlaces();

        if (places.length === 0) {
            return;
        }

        // For each place, get the icon, name and location.
        //var bounds = new google.maps.LatLngBounds();
        var place = places[0];
        if (!place.geometry) {
            console.log("Returned place contains no geometry");
            return;
        }
        codeLatLng(place.geometry.location);
    });
}

function fixContainerPos() {
    $("#pac-input").after($(".pac-container"));
}

function isComplexName(ville) {
    return ville.includes("Gouvernorat") || ville.includes("de") || ville.includes("du") || ville.includes("La") || ville.includes("Le");
}

function reverse(lat, lng) {
    var latlng = new google.maps.LatLng(lat, lng);
    codeLatLng(latlng);
}

function codeLatLng(latlng) {
    map.setCenter(latlng);
    geocoder.geocode({'latLng': latlng}, function (results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
            if (results[1]) {
                var Gouvernorats = ["Ariana", "Bèja", "Ben Arous", "Bizerte", "Gabès", "Gafsa", "Jendouba", "Kairouan", "Kasserine",
                    "Kébili", "Kef", "Mahdia", "Manouba", "Médenine", "Monastir", "Nabeul", "Sfax", "Sidi Bouzid", "Siliana",
                    "Sousse", "Tataouine", "Tozeur", "Tunis", "Zaghouan"];
                var done1 = false, done2 = false, ville = "", gouvernorat = "";
                for (i = 0; i < results.length; i++) {
                    var a = results[i].address_components;
                    for (j = 0; j < a.length && (!done1 || !done2); j++) {
                        if (i === 0 && !done2 && (a[j].types[0] === "locality" || a[j].types[0] === "administrative_area_level_2")) {
                            done2 = true;
                            ville = a[j].long_name;
                            for (var g = 0; g < Gouvernorats.length; g++)
                                if ((isComplexName(ville) && ville.replace(/[éè]/g, "e").includes(Gouvernorats[g].replace(/[éè]/g, "e"))) || (ville.replace(/[éè]/g, "e") === Gouvernorats[g].replace(/[éè]/g, "e"))) {
                                    gouvernorat = ville = Gouvernorats[g];
                                    done1 = true;
                                    break;
                                }
                        }
                        if (!done1 && (a[j].types[0] === "administrative_area_level_1" || a[j].types[0] === "administrative_area_level_2")) {
                            gouvernorat = a[j].long_name;
                            for (var g = 0; g < Gouvernorats.length; g++)
                                if (gouvernorat.replace(/[éè]/g, "e").includes(Gouvernorats[g].replace(/[éè]/g, "e"))) {
                                    gouvernorat = Gouvernorats[g];
                                    if (gouvernorat !== "Tunis") {
                                        done1 = true;
                                        break;
                                    }
                                }
                        }
                    }
                }
                if (gouvernorat === "")
                    gouvernorat = "Tunis";
                if (ville === "")
                    ville = gouvernorat;
                if(!Gouvernorats.includes(gouvernorat)){
                    alert('hors de Tunisie'); 
                    document.getElementById('pac-input').value ='';
                    return;
                }

                marker.setPosition(latlng);
                marker.setMap(map);
                document.getElementById('Lat').value = latlng.lat();
                document.getElementById('Lng').value = latlng.lng();
                document.getElementById('ville').value = ville;
                document.getElementById('gouvernorat').value = gouvernorat;
                adresse = results[0].formatted_address.replace("Tunisie", gouvernorat).replace("Unnamed Road", "Route Sans Nom");
                var pac_input = document.getElementById('pac-input');
                if(pac_input.value === "") pac_input.value = adresse;
                pac_input.value = pac_input.value.replace("Tunisie", gouvernorat);
                infowindow.setContent(pac_input.value);
                infowindow.open(map, marker);
            } else {
                alert('No results found');
            }
        } else {
            alert('Geocoder failed due to: ' + status);
        }
    });
}