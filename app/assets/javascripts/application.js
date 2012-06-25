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

var map = null;
var tv = new TweetView();

var selectedTweet;
function selectTweet(status, location) {
  setTimeout(function() {
               if (selectedTweet != status) {
                 map.removeLayer( location); 
               }
             }, 10000);
  selectedTweet = status;
  tv.update(new Tweet(status).toJSON());
}
$(function(){
    // Define the map to use from MapBox
    // This is the TileJSON endpoint copied from the embed button on your map
    var url = 'http://a.tiles.mapbox.com/v3/cconstantine.map-gyhx1cl1.jsonp';
    
    // Make a new Leaflet map in your container div
    map = new L.Map('mapbox').setView(new L.LatLng(39.572, -95.449), 3);
    
    // Get metadata about the map from MapBox
    wax.tilejson(url, function(tilejson) {
                   map.addLayer(new wax.leaf.connector(tilejson));
                 });
  });

function onReady(room_name) { 
  var TweetIcon = L.Icon.extend({options : {
                                   iconUrl: null,
                                   shadowUrl: null,
                                   iconSize : new L.Point(10,10),
                                   iconAnchor : new L.Point(10,10),
                                   popupAnchor : new L.Point(10, 10),
                                   className : "icon-asterisk"
                                 }
                                });
  var TweetIconTrending = L.Icon.extend({options : {
                                           iconUrl: null,
                                           shadowUrl: null,
                                           iconSize : new L.Point(10,10),
                                           iconAnchor : new L.Point(10,10),
                                           popupAnchor : new L.Point(10, 10),
                                           className : "icon-fire"
                                         }
                                        });
  
  page_events();
  NoDevent.join(
    room_name,
    function() {
      var room = NoDevent.room(room_name);
      
      room.on("tweet",
              function(status) {
                
                var latlng = new L.LatLng(status.coordinates.coordinates[1], status.coordinates.coordinates[0]);
                var icon = status.is_trending.length > 0 ? new TweetIconTrending() : new TweetIcon();
                var location = new L.Marker(latlng, {icon: icon});
                location.on('click', function(e) {
                              console.log(this, e);
                              clicked = this;
                              selectTweet(status, location);
                            });
                map.addLayer(location);
                
                if (selectedTweet == null) {
                  selectTweet(status, location);
                }
                
                setTimeout(function() {
                        if (selectedTweet != status) {
                          map.removeLayer( location); 
                        }
                           }, 10000);
              });
      
      room.on("trends",
              function(new_trends) {
                trends = new_trends;
              });
    });
}