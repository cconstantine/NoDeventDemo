
$ ->
  $("#error-box").hide();
  setTimeout(
    () ->
      unless NoDevent.connected()
        $("#error-box .message").html("Still waiting ...");
        $("#error-box").show('bounce', {}, 300);

      NoDevent.on 'connect', ->
        console.log 'connect'
        $("#error-box").hide('puff', {}, 300);
  , 3000
  )


  $('.reload').click ->
    window.location.reload()


NoDevent.on 'disconnect', ->
  $("#error-box .message").html("Disconnected");
  $("#error-box").show('bounce', {}, 300);

