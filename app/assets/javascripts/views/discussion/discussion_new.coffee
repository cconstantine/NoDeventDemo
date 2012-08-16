#= require '../../models/discussion'

class this.DiscussionNew extends Backbone.View
  template: JST['discussion/new']

  initialize: () ->
    $.ajax("/discussions/new.partial").success (data) =>
      @$el.find("#edit_discussion").html('<div class="well">' + data + '</div>')

      $(".edit_form form").bind "ajax:success", (data) ->
        console.log data
        console.log 'submit!'

      $(".edit_form form").bind "ajax:error", () ->
        console.log "ERROR"



  render: ->
    @$el.html(@template())