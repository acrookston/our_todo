class Todo
  include Mongoid::Document
  include Mongoid::Versioning

  max_versions 10

  field :title
  field :completed, :type => Boolean
  field :created_at, :type => Time

  validates_presence_of   :title

  before_create :set_created_at
  def set_created_at
    self.created_at = Time.now.iso8601
  end
end
