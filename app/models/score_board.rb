# 
# Class for maintaining score details of an user
# 
# @author [rohan]
# 
class ScoreBoard < ActiveRecord::Base

	belongs_to :user

	after_save :update_leaderboard


	# 
	# Checks and Updates the redis which is storing top 20 scorer at a time whenever a score is updated
	# 
	# @return [nil] 
	def update_leaderboard
		if $redis_leader_board.zcard('leaderboard') >= 20
			last_score_card = $redis_leader_board.zrevrangebyscore('leaderboard',"+inf", "(-inf", :with_scores => true).last
			last_score = last_score_card.last.to_i
			if self.score > last_score
				$redis_leader_board.zremrangebyrank("leaderboard", 0, 0)
				$redis_leader_board.zadd('leaderboard',self.score, self.user.name)
			end
		else
			$redis_leader_board.zadd('leaderboard',self.score, self.user.name)
		end
	end
end 