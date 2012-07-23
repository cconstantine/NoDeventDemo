class this.DiscussionListView extends Backbone.View
  el: ".discussions-list"

  initialize: () ->
    @collection.on 'add', (newThing) =>
      @addOne(newThing)

    @collection.each (m) =>
      @addOne(m)

  addOne: (model) ->
    v = new DiscussionView(model)
    @$el.prepend(v.el)
