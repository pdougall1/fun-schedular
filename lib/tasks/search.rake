namespace :search do
	task friends_index: :environment do 
		FriendSearch.build_index
	end
end