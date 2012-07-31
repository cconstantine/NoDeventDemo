#= require '../models/discussion'

class this.DiscussionView extends Backbone.View
  template: JST['discussion']

  initialize: (@discussion) ->
    @discussion.on "change",() =>
      @render()
    @render()

  render: ->
    r = @$el.html(@template(@discussion))
    $(r).find("abbr.timeago").timeago()
    r