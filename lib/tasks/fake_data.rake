namespace :fake_data do

  def random_user
    User.find(rand(1..User.count))
  end

  def set_associations(subject, method, count_modfier)
    count = User.count
    users = Set.new
    rand(0..(count/count_modfier).to_i).times do
      user = random_user
      if method == :include!
        subject.send(method user, rand(0..2)) unless users.include? user
      else
        subject.send(method, user) unless users.include? user
      end
      users << user
    end if count > 1
  end

  task :users => [:environment] do |t, args|
    u = User.new
    u.first_name = 'Patrick'
    u.last_name = "Dougall"
    u.email = 'pdougall1@gmail.com'
    u.color_key = 1
    p_word = '1qaz2wsx'
    u.password = p_word
    u.password_confirmation = p_word
    if u.save
      puts 'u r saved'
    else
      puts 'bad'
    end
    1000.times do |n|
      u = User.new
      u.first_name = Faker::Name.first_name
      u.last_name = Faker::Name.last_name
      u.email = Faker::Internet.email
      u.color_key = rand(1..17)
      p_word = Faker::Internet.password(8)
      u.password = p_word
      u.password_confirmation = p_word
      if u.save
        set_associations(u, :follow!, 10)
        puts "good"
      else
        puts "bad"
      end
      me = User.find(1)
      set_associations(me, :follow!, 5)
    end
  end

  task my_associations: :environment do 
    me = User.find(1)
    set_associations(me, :follow!, 5)
  end

  def random_date_time
    possibles = [(DateTime.now + rand(1..3000)), rand(1..3000).hours.ago]
    possibles[rand(0..1)]
  end

  task events: :environment do 
    User.all.each do |u|
      rand(5..20).times do
        e = u.events.new
        e.begin_time = random_date_time
        e.end_time = e.begin_time + rand(1..7).hours
        e.date = e.begin_time
        e.latitude = Faker::Address.latitude
        e.longitude = Faker::Address.longitude
        e.name = Faker::Commerce.product_name
        e.description = Faker::Lorem.sentences(rand(1..4)).join("  ")
        if e.save
          set_associations(e, :include!, 3)
          puts 'good'
        else
          puts 'bad'
        end
      end

    end
  end

  task load_all: :environment do
    puts "resetting db"
    Rake::Task["db:reset"].execute
    puts 'loading all'
    Rake::Task["fake_data:users"].execute
    Rake::Task["fake_data:my_associations"].execute
    Rake::Task["fake_data:events"].execute
    puts ""
    puts "TOTALLY AWESOME DUDE!!"
    puts ""
  end

end
