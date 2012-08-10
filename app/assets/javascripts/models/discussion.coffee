#= require '../models/nodevent_model'
class this.Discussion extends this.NoDeventModel
  urlRoot: '/discussions'
  schema:
    subject:    'Text',
    body:       'Text'

  url: () ->
    @urlRoot + "/" + @get("to_param")