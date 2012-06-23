jQuery ->
  $('.reload').click ->
    window.location.reload()

window.page_events = () ->
  console.log("page_events");
  hide_error = () ->
    $("#error-box").hide('puff', {}, 300);

  show_error = (msg) ->
    $("#error-box .message").html(msg);
    $("#error-box").show('bounce', {}, 300);


  NoDevent.socket.on 'disconnect', ->
    show_error("Disconnected");
    console.log("DISCONNECTED");

  NoDevent.socket.on 'connecting', (type) ->
    console.log("connecting: " + type);

  NoDevent.socket.on 'connect', ->
    hide_error()
    console.log("CONNECTED");

  NoDevent.socket.on 'connect_failed', ->
      console.log("connect_failed");

  NoDevent.socket.on 'reconnect_failed', ->
      console.log("reconnect_failed");

  NoDevent.socket.on 'reconnecting',(delay, attempts) ->
      console.log("reconnecting: " + delay + ", " + attempts);

  NoDevent.socket.on 'reconnect',(type, attempts) ->
      console.log("reconnect: " + type + ", " + attempts);

  NoDevent.socket.on 'reconnect_failed', ->
      console.log("reconnect_failed");

  NoDevent.socket.on 'close', ->
      console.log("close");
