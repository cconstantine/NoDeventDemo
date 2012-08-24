#= require '../../models/discussion'

class this.DiscussionView extends Backbone.View
  template: JST['discussion/view']

  events:
    "click .bonks":         "bonk"

  initialize: (@discussion) ->
    if @discussion.isNew()
      @discussion.fetch()

    @discussion.on "change",() =>
      @render()

  bonk: () ->
    $.ajax
      type: "POST",
      url: @discussion.url() + "/bonk.json"


  render: ->
    @$el.html(@template(@discussion)).find("abbr.timeago").timeago()
    @$el