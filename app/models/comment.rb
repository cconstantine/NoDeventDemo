class Comment < ActiveRecord::Base
  attr_accessible :account_id, :discussion_id, :message
end
