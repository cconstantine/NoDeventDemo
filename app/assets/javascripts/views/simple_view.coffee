
class this.SimpleView extends Backbone.View

  initialize: (@model, template) ->
    @template = JST[template]

  render: ->
    @$el.html(@template(@model))