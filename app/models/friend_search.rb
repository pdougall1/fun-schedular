class FriendSearch

  def self.user_from(prefix)
    $redis.zrevrange "user_suggestion:#{prefix.downcase}", 0, 9
  end 

  def self.build_index
    User.find_each do |user|
      full_name = "#{user.first_name} #{user.last_name}"
      result = {id: user.id, name: full_name}
      
      index_term(user.first_name, result)
      index_term(user.last_name, result)
      index_term(full_name, result)
    end
  end

  def self.index_term(term, result)
    1.upto(term.length - 1) do |n|
      prefix = term[0, n]
      $redis.zincrby "user_suggestion:#{prefix.downcase}", 1, result.to_json
    end
  end


end