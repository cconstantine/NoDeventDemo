
AppRouter  = Backbone.Router.extend
  routes:
    "" : "discussions"
    "discussions/new" : "newDiscussion"
    "discussions/:id" : "discussion"

  discussions: () ->
    @page = {};

    $(".main_content").html('<div class="discussions-list"></div>')
    @page.discussions = new DiscussionCollection()
    @page.discussions_view_list = new DiscussionListView({collection : @page.discussions})

    @page.discussions.fetch({add: true})
    $(".main_content").html(@page.discussions_view_list.render())


  newDiscussion: () ->
    @page = {};
    @page.discussion_new = new DiscussionNew()
    $(".main_content").html(@page.discussion_new.render())

  discussion: (id) ->
    @page = {};
    window.discussion = new Discussion({id: id})
    window.discussion.fetch()
    @page.discussion_view = new DiscussionShow(window.discussion)
    $(".main_content").html(@page.discussion_view.render())

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
      Backbone.history.navigate(href.attr, true);
