class Tweet extends Backbone.Model
  initialize: (status) ->
    @status = status

  spans: ->
    text = @status.text
    if @status.entities.urls.length == 0
      return [text]
    else
      spans = []
      urls = @status.entities.urls
      spans = [text.slice(0, url[0].indices[0])]
      for url in urls
        href=url.expanded_url
        toDisplay=url.display_url
        spans.push('<a target="_blank" href="'+href+'">'+toDisplay+"</a>"
        spans.push(text.slice(url.indices[1]);

window.Tweet = Tweet;