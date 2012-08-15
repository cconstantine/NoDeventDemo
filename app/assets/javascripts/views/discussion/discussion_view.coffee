#= require '../../models/discussion'

class this.DiscussionView extends Backbone.View
  template: JST['discussion/discussion']

  initialize: (@discussion) ->
    if @discussion.isNew()
      @discussion.fetch()

    @discussion.on "change",() =>
      @render()

  render: ->
    @$el.html(@template(@discussion)).find("abbr.timeago").timeago()
    @$el