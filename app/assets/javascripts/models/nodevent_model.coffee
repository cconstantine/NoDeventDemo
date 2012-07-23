class this.NoDeventModel extends Backbone.Model
  urlRoot: '/users'

  initialize: () ->
    @_onJoinRoom()
    @on 'change', () =>
      @_onJoinRoom()

  onUpdate: (user) ->
    @set(user)

  _onJoinRoom: () ->
    nodevent = @get('nodevent')
    if !@room? && nodevent?
      @room = NoDevent.room(nodevent.room)
      @room.setKey(nodevent.key) if nodevent.key?
      @room.join()

      @room.on 'update', (user) =>
        @onUpdate(user)

