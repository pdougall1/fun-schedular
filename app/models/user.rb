class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :inclusions, dependent: :destroy
  has_many :events_included_in, through: :inclusions

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
    self
  end

  def stop_following!(other_user)
  	rel = relationships.where("follower_id = ? AND followed_id = ?", self.id, other_user.id)
  	rel.delete
  	self
  end

  def watch!(other_user)
  	rel = relationships.where("follower_id = ? AND followed_id = ?", self.id, other_user.id).first_or_initialize
  	rel.watching = true
  	self
  end

  def stop_watching!(other_user)
  	rel = relationships.where("follower_id = ? AND followed_id = ?", self.id, other_user.id)
  	rel.watching = false
  	self
  end

  def watching
  	relationships.where("follower_id = ? AND watching = ", self.id, true)
  end

  def to_ember_json(options = nil)
  	with = options[:with]
  	user_hash = attributes
  	if with == :friends
      friends = followed_users
  	end
  	if with
  		user_hash[:friend_ids] = friends.map(&:id)
  		result = { user: user_hash, friends: friends }
  	else
  		result = { user: user_hash }
  	end
  	result
  end

  def self.create_trial!
    params = { 
      first_name: "Trial", 
      last_name: "User", 
      email: "trail_#{User.last.id}@user.com", 
      password: "123456789", 
      password_confirmation: '123456789' 
    }
    User.create! params
  end

  def is_trial_user
    "#{first_name} #{last_name}" == "Trial User"
  end
  
end
