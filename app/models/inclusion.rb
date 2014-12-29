class Inclusion < ActiveRecord::Base

  belongs_to :user
  belongs_to :event

  ATTENDING_MAP = {
    0 => 'no',
    1 => 'yes',
    2 => 'maybe'
  }

  def attending_status
    ATTENDING_MAP[status]
  end

end
