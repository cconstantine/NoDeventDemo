
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