jQuery ->
  if NoDevent.connected()
    $("#error-box").hide('puff', {}, 300);

  $('.reload').click ->
    window.location.reload()


NoDevent.on 'disconnect', ->
  $("#error-box .message").html("Disconnected");
  $("#error-box").show('bounce', {}, 300);

NoDevent.on 'connect', ->
  $("#error-box").hide('puff', {}, 300);