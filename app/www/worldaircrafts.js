$(function() {
    // Setup leaflet map
    var map = new L.Map('map');


    // Center map and default zoom level
    map.setView([0, 0], 3);

    // Adds the background layer to the map
    var basemapLayer = new L.TileLayer('https://{s}.tiles.mapbox.com/v3/examples.map-zr0njcqy/{z}/{x}/{y}.png', {
        attribution: '<a href="http://www.mapbox.com/about/maps/" target="_blank">Terms &amp; Feedback</a>'
    });
L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png?{foo}', {foo: 'bar'}).addTo(map);

    //map.addLayer(basemapLayer);

    // =====================================================
    // =============== Playback ============================
    // =====================================================
    
    var shipIcon = L.icon({
                            iconUrl: 'ship-icon.png',
                            iconSize: [7, 20], // size of the icon
                            shadowSize: [0, 0], // size of the shadow
                            iconAnchor: [3.5, 10], // point of the icon which will correspond to marker's location
                            shadowAnchor: [0, 0], // the same for the shadow
                            popupAnchor: [0, -10] // point from which the popup should open relative to the iconAnchor
                        });
    // Playback options
    var playbackOptions = {
        playControl: true,
        dateControl: true,
        sliderControl: true,
        orientIcons:true,
        marker: function (featureData) {
                    return {
                        icon: shipIcon,
                        getPopup: function (feature) {
                            return feature.properties.title;
                        }
                    };
                }
    };
        
    // Initialize playback
    var playback = new L.Playback(map, demoTracks, null, playbackOptions);   
});
