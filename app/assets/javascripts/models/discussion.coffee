#= require '../models/nodevent_model'
class this.Discussion extends this.NoDeventModel
  relations: [{
          type: Backbone.HasOne,
          key: 'user',
          relatedModel: 'User',
          reverseRelation: {
              key: 'discussions',
              includeInJSON: 'id'
              # 'relatedModel' is automatically set to 'Zoo'; the 'relationType' to 'HasOne'.
          }
      }]


  urlRoot: '/discussions'