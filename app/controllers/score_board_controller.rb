class ScoreBoardController < ApplicationController

	# 
	# Gets all the users and scores
	# 
	# @return [array] 	
	def index
		@score_boards = ScoreBoard.joins(:user).select('score_boards.score, users.name')
    api_response(@score_boards, 'Score Board details', :ok)
	end

	# 
	# Updates score of an user
	# 
	# @return ScoreBoard object 	
	def update
		@score_board = ScoreBoard.find(params[:id])
		if @score_board
			@score_board.update_attributes(score: params[:score].to_i)
			api_response(@score_board, 'Score Board updated', :ok)
		else
			api_response(nil, 'Cannot find score', :bad_request)
		end
	end

	# 
	# Gets the top 20 scorers
	# 
	# @return [array] 	
	def leaderboard
		leader_board = $redis_leader_board.zrevrangebyscore('leaderboard',"+inf", "(-inf", :with_scores => true).collect{|x| {name: x.first, score: x.last}}
		api_response(leader_board, 'Leaderboard Scores', :ok)
	end

	# 
	# Gets local leaderboard based on the users score
	# 
	# @return [array] 	
	def local_leaderboard
		payload ={}
		user_score = ScoreBoard.where(user_id: params[:user_id]).first
		if user_score
			higher_leaderboard = ScoreBoard.joins(:user).select('score_boards.score, users.name').where('score_boards.score >= ?', user_score.score).order('score_boards.score ASC').limit(10).collect{ |x| 
				{
					name: x.name,
					score: x.score
				}
			}
			lower_leaderboard = ScoreBoard.joins(:user).select('score_boards.score, users.name').where('score_boards.score < ?', user_score.score).order('score_boards.score DESC').limit(10).collect{ |x| 
				{
					name: x.name,
					score: x.score
				}
			}
			payload = higher_leaderboard + lower_leaderboard
			payload = payload.sort_by { |k| k[:score] }.reverse
		end
		api_response(payload, 'Local leaderboard', :ok)
	end

	private
	def score_board_params
		params.permit(:user_id, :score)
	end
end