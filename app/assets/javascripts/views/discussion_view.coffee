#= require '../models/discussion'

class this.DiscussionView extends Backbone.View
  template: JST['discussion']

  initialize: (@discussion) ->
    @render()

  render: ->
    @$el.html(@template(@discussion.toJSON()))
