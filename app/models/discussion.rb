class Discussion < ActiveRecord::Base
  attr_accessible :username, :body

  include NoDevent::Base

  after_create :nodevent_create
  after_update :nodevent_update

  belongs_to :user

  validates_presence_of :user, :body

  def as_json(options={})

    super(options).merge(:nodevent => {:room => room}).merge(:user => user)
  end

end
