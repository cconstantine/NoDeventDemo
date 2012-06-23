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

var map = null;
var tv = new TweetView();

var selectedTweet;
function selectTweet(status) {
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
var joined = false;
function onJoin(room) {
  if (joined)
    return;

  joined = true;
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
  
  var tweets = [];
  var trendingTweets = [];

  room.on("tweet",
         function(status) {
           if (selectedTweet == null) {// && status.entities.urls.length > 0) {
             selectTweet(status);
             selectedTweet = status;

           }
           
           var latlng = new L.LatLng(status.coordinates.coordinates[1], status.coordinates.coordinates[0]);
           var icon = status.is_trending.length > 0 ? new TweetIconTrending : new TweetIcon();
           var location = new L.Marker(latlng, {icon: icon});
           location.on('click', function(e) {
                         selectTweet(status);
                  });

           map.addLayer(location);
           if (status.is_trending.length == 0) {
             tweets.push(location);
             if (tweets.length > 100) {
               map.removeLayer( tweets.shift());
             }
           } else {
             trendingTweets.push(location);
             if (trendingTweets.length > 100) {
               map.removeLayer( trendingTweets.shift());
             }
           }
             
         });

  room.on("trends",
         function(new_trends) {
           trends = new_trends;
         });
}
