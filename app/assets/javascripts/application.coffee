# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http://example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.

#= require jquery
#= require jquery-ui
#= require jquery_ujs

#= require backbone-rails
#= require backbone-relational

#= require hamlcoffee
#= require rails-timeago

#= require_tree .

window.NoDeventDemo = new NoDeventDemoClass()

NoDeventDemo.on "change:current_user", (user) ->
  if NoDeventDemo.get("current_user").get("username")?
    $("#login").hide();
    $("#logout").show();
  else
    $("#login").show();
    $("#logout").hide();

$ () ->
  $(".session_form").parents("form").bind "ajax:error", (xhr, data, status) ->
    data = JSON.parse(data.responseText)

    for field, errors of data.errors
      d = $(@).find("#user_#{field}-error")
      d.html(field + " " + data.errors[field][0])
      d.show("show")


  $(".session_form").parents("form").bind "ajax:success", (xhr, data, status) ->
    window.NoDeventDemo.set("current_user", new User(data));
    $(".login_forms .error").hide()

if !console? || !console.log?
  console.log = () ->