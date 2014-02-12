class UpDownVotesController < ApplicationController
  
  def new
  	@up_down_vote = UpDownVote.new
  end

  def index
  	@up_down_votes = current_user.up_down_votes
  end

  def show
    @up_down_vote = current_user.up_down_votes.find(params[:id])
  end

  def create
    @voting_user = current_user
    @up_down_vote = UpDownVote.new(up_down_vote_params)
    
    @voting_user.up_down_votes << @up_down_vote.to_a

  	if @up_down_vote.save
  		redirect_to up_down_votes_path
  	else
  		redirect_to new_up_down_vote_path
  	end
  end

  def yes_vote
    up_down_vote = current_user.up_down_votes.find(params[:id])
    uv = up_down_vote.up_vote += 1
    up_down_vote.update_attributes(up_vote: uv)
    redirect_to up_down_vote_path
  end

  def no_vote
    up_down_vote = current_user.up_down_votes.find(params[:id])
    dv = up_down_vote.down_vote += 1
    up_down_vote.update_attributes(up_vote: dv)
    redirect_to up_down_vote_path
  end

  def destroy
    current_user.up_down_votes.find(params[:id]).destroy
    # @up_down_vote.destroy
    redirect_to up_down_votes_path
  end

end

private

def up_down_vote_params
	params.require(:up_down_vote).permit(:question, :up_vote, :down_vote, :vote_time)
end





