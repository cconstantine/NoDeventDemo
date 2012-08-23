#= require '../../models/discussion'

class this.DiscussionNew extends Backbone.View
  template: JST['discussion/new']

  initialize: () ->
    NoDeventDemo.on "change:current_user", (user) =>
      @render()

  render: ->
    @$el.html(@template())

    $.ajax("/discussions/new.partial").success (data) =>
      @$el.find("#new_discussion").html( data )

    return @$el
