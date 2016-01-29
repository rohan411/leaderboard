namespace :seed_data do
  desc "TODO"
  task create_users: :environment do
  	i = 0
  	100.times do
  		user_hash = {
  			name:  (0...5).map { (65 + rand(26)).chr }.join,
  			phone: (0...10).map { (65 + rand(26)).chr }.join, 
  			age: 23
  		}
  		User.create(user_hash)
  	end
  end

  desc "TODO"
  task update_scores: :environment do
  	ScoreBoard.all.each do |score|
  		score.update_attributes(score: Random.rand(1000))
  	end
  end

end
