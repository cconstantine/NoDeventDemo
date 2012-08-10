#= require '../models/discussion'

class this.DiscussionView extends Backbone.View
  template: JST['discussion']

  initialize: (@discussion) ->
    if @discussion.isNew()
      @discussion.fetch()

    @discussion.on "change",() =>
      @render()

  anchor: () -> "<div id='discussion_#{@discussion.get("to_param")}'></div>"

  render: ->
    r = $(@$el).html(@template(@discussion))
    $(r).find("abbr.timeago").timeago()
    r