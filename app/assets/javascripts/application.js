// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
var map = null;
var lastStatus;

function selectTweet(status) {
  $("#name").html(status.user.name);
  var text = status.text;
  if (status.entities.urls.length > 0) {
    var urls = status.entities.urls;
    for(var i = urls.length - 1;i >= 0;--i) {
      var url = status.entities.urls[i];
      text = text.slice(0, url.indices[0]) +
        '<a target="_blank" href=' +
        '"'+url.expanded_url+'">' +
        url.display_url + "</a>" +
        text.slice(url.indices[1]);
      console.log(text);
    }
  }
  $("#tweet").html(text);
}
function onJoin(name, room) {
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
  
  // Define the map to use from MapBox
  // This is the TileJSON endpoint copied from the embed button on your map
  var url = 'http://a.tiles.mapbox.com/v3/cconstantine.map-gyhx1cl1.jsonp';
  
  // Make a new Leaflet map in your container div
  map = new L.Map('mapbox').setView(new L.LatLng(39.572, -95.449), 3);
  
  // Get metadata about the map from MapBox
  wax.tilejson(url, function(tilejson) {
                 map.addLayer(new wax.leaf.connector(tilejson));
               });

  var tweets = [];
  var trendingTweets = [];
  room.on("tweet",
         function(status) {
           if (lastStatus == null) {// && status.entities.urls.length > 0) {
             selectTweet(status);
             lastStatus = status;

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
