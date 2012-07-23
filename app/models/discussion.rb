class Discussion < ActiveRecord::Base
  attr_accessible :body, :subject

  include NoDevent
  after_create :nodevent_create
  after_update :nodevent_update

  def as_json(options={})
    super(options.merge(:except => :password_digest)).merge(:nodevent => {:room => room})
  end

  def nodevent_create
    NoDevent::Emitter.emit(self.class, 'create', self)
  end

  def nodevent_update
    self.emit('update')
  end
end
