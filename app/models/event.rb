class Event < ActiveRecord::Base

  belongs_to :user
  has_many :inclusions, dependent: :destroy
  has_many :included_users, through: :inclusions, source: :user
  scope :within_month, -> (date) { 
    where( "date >= ? AND date <= ?", date, date.end_of_month )
  }

  def include! user, status = 0
    inclusions.create!(user_id: user.id, status: status)
  end

  def uninclude! user
    rel = inclusions.where("event_id = ? AND user_id = ?", self.id, user.id)
    rel.delete
    self
  end

  def self.all_for_ember(user, date)
    events = within_month(date).map do |event|
      attrs = event.attributes
      attrs[:friends] = event.included_users.pluck(:id)
      attrs
    end
  end

end



 

