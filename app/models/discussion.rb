class Discussion < ActiveRecord::Base
  attr_accessible :username, :body

  include NoDevent::Base

  after_create :nodevent_create
  after_update :nodevent_update

  validates_presence_of :username, :body

  def as_json(options={})
    super(options).merge(:nodevent => {:room => room})
  end

end
