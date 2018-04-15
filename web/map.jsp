<%-- 
    Document   : map
    Created on : 2 avr. 2018, 19:44:20
    Author     : Wissem
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Geolocation</title>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <meta charset="utf-8">
        <style>
            /* Always set the map height explicitly to define the size of the div
             * element that contains the map. */
            #map {
                height: 100%;
            }
            /* Optional: Makes the sample page fill the window. */
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }

            #panel {
                position: absolute;
                top: 5px;
                left: 50%;
                margin-left: -180px;
                width: 350px;
                z-index: 5;
                background-color: #fff;
                padding: 5px;
                border: 1px solid #999;
            }
            #latlng {
                width: 225px;
            }
        </style>
    </head>
    <body>
        <script>
            function codeLatLng() {
                var input = document.getElementById('latlng').value;
                var latlngStr = input.split(',', 2);
                var lat = parseFloat(latlngStr[0]);
                var lng = parseFloat(latlngStr[1]);
                //alert(lat);
                var latlng = new google.maps.LatLng(lat, lng);
                geocoder.geocode({'latLng': latlng}, function (results, status) {
                    if (status === google.maps.GeocoderStatus.OK) {
                        if (results[1]) {
                            map.setZoom(15);
                            marker = new google.maps.Marker({
                                position: latlng,
                                map: map
                            });
                            var str = results[1].formatted_address;
                            var n = str.indexOf(",");
                            var res = str.slice(0, n);
                            document.getElementById('ville').value = res;
                            infowindow.setContent(results[0].formatted_address);
                            infowindow.open(map, marker);
                        } else {
                            alert('No results found');
                        }
                    } else {
                        alert('Geocoder failed due to: ' + status);
                    }
                });
            }

            google.maps.event.addDomListener(window, 'load', initialize);

        </script>
        <div id="panel">
            <input id="latlng" type="text" value="36.5806067, 10.862080399999968">
            <input type="button" value="Reverse Geocode" onclick="codeLatLng()">
            <input type="text" id="ville" value="ville" >
        </div>
        <div id="map"></div>
        <script>
            // Note: This example requires that you consent to location sharing when
            // prompted by your browser. If you see the error "The Geolocation service
            // failed.", it means you probably did not give permission for the browser to
            // locate you.
            function initMap() {
                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 36, lng: 10},
                    zoom: 6
                });
                var infoWindow = new google.maps.InfoWindow({map: map});

                // Try HTML5 geolocation.
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(function (position) {
                        var pos = {
                            lat: position.coords.latitude,
                            lng: position.coords.longitude
                        };
                        getCity(pos.lat, pos.lng);

                        infoWindow.setPosition(pos);
                        infoWindow.setContent('Location found.');
                        map.setCenter(pos);
                    }, function () {
                        handleLocationError(true, infoWindow, map.getCenter());
                    });
                } else {
                    // Browser doesn't support Geolocation
                    handleLocationError(false, infoWindow, map.getCenter());
                }
            }

            function handleLocationError(browserHasGeolocation, infoWindow, pos) {
                infoWindow.setPosition(pos);
                infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
            }

            function getCity(lat, lng) {
                var latlng = new google.maps.LatLng(lat, lng);

                new google.maps.Geocoder().geocode({'latLng': latlng}, function (results, status) {
                    if (status === google.maps.GeocoderStatus.OK) {
                        if (results[1]) {
                            var country = null, countryCode = null, city = null, cityAlt = null;
                            var c, lc, component;
                            for (var r = 0, rl = results.length; r < rl; r += 1) {
                                var result = results[r];
                                for (c = 0, lc = result.address_components.length; c < lc; c += 1) {
                                    component = result.address_components[c];
                                }
                                if (!city && result.types[0] === 'locality') {
                                    for (c = 0, lc = result.address_components.length; c < lc; c += 1) {
                                        component = result.address_components[c];
                                        if (component.types[0] === 'locality') {
                                            city = component.long_name;
                                            break;
                                        }
                                    }
                                } else if (!city && !cityAlt && result.types[0] === 'administrative_area_level_1') {
                                    for (c = 0, lc = result.address_components.length; c < lc; c += 1) {
                                        component = result.address_components[c];

                                        if (component.types[0] === 'administrative_area_level_1') {
                                            cityAlt = component.long_name;
                                            break;
                                        }
                                    }
                                } else if (!country && result.types[0] === 'country') {
                                    country = result.address_components[0].long_name;
                                    countryCode = result.address_components[0].short_name;
                                }

                                if (city && country) {
                                    break;
                                }
                            }
                            alert("City: " + city + "City2: " + cityAlt + ", Country: " + country + ", lat: " + lat + ", lng: " + lng);
                        }
                    }
                });
            }
        </script>
        <script async defer
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAibq0y-rc3o6PG_tJb5LimMS0eZUMN8Vk&callback=initMap">
        </script>
    </body>
</html>