// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require hamlcoffee

//= require jquery_ujs
//= require jquery.ui.all

//= require backbone-rails
//= require_tree .

var clicked = null;

var tv = new TweetView();

$(function(){
    // Define the map to use from MapBox
    // This is the TileJSON endpoint copied from the embed button on your map
    var url = 'http://a.tiles.mapbox.com/v3/cconstantine.map-gyhx1cl1.jsonp';
    
    // Make a new Leaflet map in your container div
    window.map = new L.Map('mapbox').setView(new L.LatLng(39.572, -95.449), 3);
    
    // Get metadata about the map from MapBox
    wax.tilejson(url, function(tilejson) {
                   window.map.addLayer(new wax.leaf.connector(tilejson));
                 });
  });

window.TweetIcon = L.Icon.extend({options : {
                               iconUrl: null,
                               shadowUrl: null,
                               iconSize : new L.Point(10,10),
                               iconAnchor : new L.Point(10,10),
                               popupAnchor : new L.Point(10, 10),
                               className : "icon-asterisk"
                             }
                            });
window.TweetIconTrending = L.Icon.extend({options : {
                                       iconUrl: null,
                                       shadowUrl: null,
                                       iconSize : new L.Point(10,10),
                                       iconAnchor : new L.Point(10,10),
                                       popupAnchor : new L.Point(10, 10),
                                       className : "icon-fire"
                                     }
                                    });
