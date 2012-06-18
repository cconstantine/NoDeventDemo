class TweetView extends Backbone.View
  initialize: () ->
    @el = $('.tweetbox')
    @tweet = {name : "", spans : []};
    _.bindAll @
    super()

  update: (obj) ->
    @el = $('.tweetbox')
    @tweet = obj
    @render()

  template: JST['tweet']

  render: ->
    $(@el).html(@template(@tweet))

window.TweetView = TweetView;
