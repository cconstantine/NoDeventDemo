#= require '../models/discussion'

class this.DiscussionCollection extends Backbone.Collection
  model: Discussion
  url: '/discussions.json'

  initialize: (models) ->
    super(models)
    @room = NoDevent.room(DiscussionCollection.nodevent.room)
    @room.setKey(DiscussionCollection.nodevent.key)
    @room.join()
    @room.on 'create', (newDisc) =>
      @add newDisc

  comparator: (model) ->
    model.id