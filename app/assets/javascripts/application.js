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

function onJoin(name, room) {

  // Define the map to use from MapBox
  // This is the TileJSON endpoint copied from the embed button on your map
  var url = 'http://a.tiles.mapbox.com/v3/cconstantine.map-gyhx1cl1.jsonp';
  
  // Make a new Leaflet map in your container div
  map = new L.Map('mapbox').setView(new L.LatLng(39.572, -95.449), 4);
  
  // Get metadata about the map from MapBox
  wax.tilejson(url, function(tilejson) {
                 map.addLayer(new wax.leaf.connector(tilejson));
               });
  
  var users = {};
  console.log(name);
  room.on('location',
          function(data) {
            var circle = users[data.user.name];
            var coords = data.loc.coords;

            if (!circle) {
              var circleLocation = new L.LatLng(coords.latitude, coords.longitude),
              circleOptions = {
                color: 'blue',
                fillColor: 'blue',
                fillOpacity: 0.5
              };
              
              circle = new L.Circle(circleLocation, coords.accuracy, circleOptions);
              users[data.user.name] = circle; 
              map.addLayer(circle);
            } else {
              var latlng = new L.LatLng( coords.latitude, coords.longitude );
              circle.setLatLng(latlng, coords.accuracy);
            }
          });
  
  var user_counts = {};
  room.users.on(
    'join',
    function(user) {
      user_counts[user.name] |= 0;
      user_counts[user.name]++;
      console.log("joining ",  room.name, user.name);
    });

  room.users.on(
    'members', 
    function(members) {
      for(var i in members) {
        var member = members[i];
        if (!user_counts[member])
          user_counts[member] = 1;
      }
      console.log('members', members);
    });
  room.users.on(
    'leave',
    function(user) {
      console.log("leaving ",  room.name, user.name);
      user_counts[user.name]++;
      if (user_counts[user.name] == 0) {        
        delete user_counts[user.name];

        var circle = users[user.name];
        map.removeLayer(circle);
      }
      
    });
  
  var latestLoc = null;
  navigator.geolocation.watchPosition(
    function(location) {
      console.log(location);
      latestLoc = location;
      $.post(update_url, {user : user, loc : location});
    });

  setInterval(
    function() {
      $.post(update_url, {user : user, loc : latestLoc});
    },
    1000);
}
