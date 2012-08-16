#= require '../../models/discussion'

class this.DiscussionShow extends Backbone.View
  template: JST['discussion/show']

  initialize: (@discussion) ->
    @discussion_view = new DiscussionView(@discussion)
    @edit_view = new SimpleView(@discussion.get("user"), "discussion/edit")

    @discussion.on "change:user", () =>
      @edit_view.model = @discussion.get("user")
      @edit_view.render()

    @discussion.on "change:to_param", () =>
      console.log "to_param change " + @discussion.url()
      Backbone.history.navigate(@discussion.url(), true);

    @discussion.on "change:body_html", () =>
      @render()

    NoDeventDemo.on "change:current_user", (user) =>
      @render()

  events:
   "click .edit":          "showEdit"


  showEdit: ->
    $.ajax(@discussion.url() + "/edit.partial").success (data) =>
      @$el.find("#edit_discussion").html('<div class="well">' + data + '</div>')

      $(".edit_form form").bind "ajax:success", (data) ->
        console.log 'submit!'

      $(".edit_form form").bind "ajax:error", () ->
        console.log "ERROR"



  render: ->
    @$el.html(@template(@discussion))
    @$el.find("#view_discussion").html(@discussion_view.render())
    @$el.find("#edit_anchor").html(@edit_view.render())
    @$el