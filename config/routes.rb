Rails.application.routes.draw do
 resources :users, only: [:index, :create, :show] do 
  resources :score_board, only: [:index, :update] do 
    collection do
      get 'local_leaderboard'
    end
  end
 end
 get 'leaderboard' => 'score_board#leaderboard'
end
