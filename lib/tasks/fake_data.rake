

namespace :fake_data do

  task :users => [:environment] do |t, args|
  	20.times do |n|
	  	u = User.new
	  	u.first_name = Faker::Name.first_name
		u.last_name = Faker::Name.last_name
		u.email = Faker::Internet.email
		p_word = Faker::Internet.password(8)
		u.password = p_word
		u.password_confirmation = p_word
		if u.save
			puts "good"
		else
			puts "bad"
		end
	end
  end

end
