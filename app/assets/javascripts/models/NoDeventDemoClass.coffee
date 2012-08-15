class this.NoDeventDemoClass extends Backbone.RelationalModel

  isCurrentUser: (user) ->
    @get("current_user")? && user? && @get("current_user").id == user.id
