
AppRouter  = Backbone.Router.extend
  routes:
    "" : "discussions"
    "discussions/:id" : "discussion"
    "discussions/:id/edit" : "editDiscussion"

  discussions: () ->
    @page = {};

    $(".main_content").html('<div class="discussions-list"></div>')
    @page.discussions = new DiscussionCollection()
    @page.discussions_view_list = new DiscussionListView({collection : @page.discussions})

    @page.discussions.fetch({add: true})

  discussion: (id) ->
    console.log id
    @page = {};

    @page.discussion_view = new DiscussionView(new Discussion({to_param: id}))
    $(".main_content").html(@page.discussion_view.render())

  editDiscussion: (id) ->
    elem = @discussion(id)

    form = new Backbone.Form({
        model: @page.discussion_view.discussion
    }).render();

    $(elem).append(form.el);

$ ->
  app_router = new AppRouter
  Backbone.history.start({pushState: true});

$(document).on "click", "a:not([data-bypass])", (evt) ->
    # Get the absolute anchor href.
    href = { prop: $(this).prop("href"), attr: $(this).attr("href") }
    # Get the absolute root.
    root = location.protocol + "//" + location.host

    # Ensure the root is part of the anchor href, meaning it's relative.
    if (href.prop && href.prop.slice(0, root.length) == root)
      # Stop the default event to ensure the link will not cause a page
      # refresh.
      evt.preventDefault()

      # `Backbone.history.navigate` is sufficient for all Routers and will
      # trigger the correct events. The Router's internal `navigate` method
      # calls this anyways.  The fragment is sliced from the root.
      console.log href.attr
      Backbone.history.navigate(href.attr, true);
