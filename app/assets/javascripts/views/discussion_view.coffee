#= require '../models/discussion'

class this.DiscussionView extends Backbone.View
  template: JST['discussion']

  initialize: (@discussion) ->
    @render()

  render: ->
    r = @$el.html(@template(@discussion.toJSON()))
    $(r).find("abbr.timeago").timeago()
    r