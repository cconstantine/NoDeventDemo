class Discussion < ActiveRecord::Base
  attr_accessible :body, :user

  include NoDevent::Base

  after_create :nodevent_create
  after_update :nodevent_update

  belongs_to :user

  validates_presence_of :body, :user

  def html_body
    BlueCloth.new(body).to_html
  end

  def as_json(options={})
    super(options.merge({:methods => [:html_body], :include => :user})).merge(:nodevent => {:room => room})
  end


end
