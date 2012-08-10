class Discussion < ActiveRecord::Base
  attr_accessible :body, :subject

  include NoDevent::Base
  extend FriendlyId
  friendly_id :subject, use: :slugged

  after_create :nodevent_create
  after_update :nodevent_update

  belongs_to :user

  validates_presence_of :body, :user

  def html_body
    BlueCloth.new(body).to_html
  end

  def as_json(options={})
    super(options.merge({:methods => [:html_body, :to_param], :include => :user})).merge(:nodevent => {:room => room})
  end


end
