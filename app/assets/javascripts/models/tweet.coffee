
#= require backbone-rails
class Tweet extends Backbone.Model
  initialize: (status) ->
    @status = status

  name : ->
    @status.user.name

  spans: ->
    text = @status.text
    if @status.entities.urls.length == 0
      return [text]
    else
      spans = []
      urls = @status.entities.urls
      spans = [text.slice(0, urls[0].indices[0])]

      for url in urls
        href=url.expanded_url
        toDisplay=url.display_url
        spans.push({href: href, display: toDisplay});
        spans.push(text.slice(url.indices[1]));
      return spans

  toJSON: ->
    {name : @name(), spans : @spans()}

window.Tweet = Tweet

room = NoDevent.room('twitter')
room.join()
selectedTweet = null;


room.on "tweet",(status) ->
  latlng = new L.LatLng(status.coordinates.coordinates[1], status.coordinates.coordinates[0])
  icon = if status.is_trending.length > 0 then new TweetIconTrending() else new TweetIcon()

  location = new L.Marker(latlng, {icon: icon})
  location.on 'click', (e) ->
    setTimeout () ->
      if selectedTweet != status
        window.map.removeLayer( location)
    , 10000
    selectedTweet = status;
    tv.update(new Tweet(status).toJSON())


  window.map.addLayer(location)

  if selectedTweet == null
    setTimeout () ->
      if selectedTweet != status
        window.map.removeLayer( location)
    , 10000
    selectedTweet = status;
    tv.update(new Tweet(status).toJSON())


  setTimeout ()->
    if selectedTweet != status
      map.removeLayer(location)
  , 10000


room.on "trends", (new_trends) ->
  trends = new_trends
