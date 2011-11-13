class Todo
  include Mongoid::Document
  include Mongoid::Versioning

  max_versions 0

  field :title
  field :completed, :type => Boolean
  field :created_at, :type => Time

  validates_presence_of :title

  before_create :set_defaults
  def set_defaults
    self.created_at = Time.now.iso8601
    self.completed  = 0 # not sure why but `false` doesn't work here
  end
end
