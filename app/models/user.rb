class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :cid
  has_secure_password

  validates_presence_of :password, :on => :create
  validates_presence_of :username

  validates_uniqueness_of :username


  include NoDevent::Base

  after_create :nodevent_create
  after_update :nodevent_update

  def as_json(options={})
    super(options.merge(:except => :password_digest)).merge(:nodevent => {:room => room})
  end
end
