class Discussion < ActiveRecord::Base
  attr_accessible :username, :body

  include NoDevent::Base

  after_create :nodevent_create
  after_update :nodevent_update

  belongs_to :user

  validates_presence_of :body

  def as_json(options={})
    super(options.merge({:include => :user})).merge(:nodevent => {:room => room})
  end

end
