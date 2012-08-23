class this.DiscussionListView extends Backbone.View
  template: JST["discussion/index"]

  initialize: () ->
    @collection.on 'add', (newThing) =>
      @render()

    @$el.html(@template());

    @new_form = new DiscussionNew();
    @$el.find(".new_discussion").html(@new_form.render())


  addOne: (model) ->
    @collection.add(new DiscussionView(model))

  render: () ->
    @$el.find(".discussion-list").html("")
    @collection.each (item) =>
      v = new DiscussionView(item)
      @$el.find(".discussion-list").prepend(v.make("div", {class: "well"}, v.render()))
    @$el
