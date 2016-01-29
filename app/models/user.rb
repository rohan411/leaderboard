# 
# Class for mainting user details
# 
# @author [rohan]
# 
class User < ActiveRecord::Base
	validates_uniqueness_of :phone

	has_one :score_board

	after_create :create_score_entry

	# 
	# Creates and entry in the ScoreBoard with default score 0 
	# 
	# @return [type] [description]
	def create_score_entry
		ScoreBoard.create(score: 0, user_id: self.id)
	end

end