class this.NoDeventModel extends Backbone.RelationalModel
  urlRoot: '/users'

  initialize: () ->
    @_onJoinRoom()
    @on 'change', () =>
      @_onJoinRoom()

  onUpdate: (m) ->
    @set(m)

  _onJoinRoom: () ->
    nodevent = @get('nodevent')
    if !@room? && nodevent?
      @room = NoDevent.room(nodevent.room)
      @room.setKey(nodevent.key) if nodevent.key?
      @room.join()

      @room.on 'update', (m) =>
        console.log m
        @onUpdate(m)

