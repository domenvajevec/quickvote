class UpDownVotesController < ApplicationController
  
  def new
  	@up_down_vote = UpDownVote.new
  end

  def index
  	@up_down_votes = UpDownVote.all
  end

  def create
  	@up_down_vote = UpDownVote.new(up_down_vote_params)

  	if @up_down_vote.save
  		redirect_to up_down_votes_path
  	else
  		redirect_to new_up_down_vote_path
  	end
  end

end

private

def up_down_vote_params
	params.require(:up_down_vote).permit(:question, :up_vote, :down_vote, :vote_time)
end




