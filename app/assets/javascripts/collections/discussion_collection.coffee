#= require '../models/discussion'

class this.DiscussionCollection extends Backbone.Collection
  model: Discussion
  url: '/discussions.json'

  initialize: (models) ->
    super(models)
    @room = NoDevent.room('Discussion')
    @room.join()
    @room.on 'create', (newDisc) =>
      @add newDisc
