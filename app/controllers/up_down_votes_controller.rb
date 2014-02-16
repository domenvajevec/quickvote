class UpDownVotesController < ApplicationController
  
  def new
  	@up_down_vote = UpDownVote.new
  end

  def index
  	@up_down_votes = UpDownVote.where(user_id: current_user.id)
  end

  def show


    if current_user
     
      @up_down_vote = UpDownVote.where(_id: params[:id]).first

      if !@up_down_vote 
        flash[:error] = "Sorry, that vote does not exist. Please check your spelling and try again"
        redirect_to root_path
      end
    else

        flash[:notice]= "Please log in before voting. Thanks"
        redirect_to new_auth_path
    end


  end

  def create
    
    @voting_user = current_user
    @up_down_vote = UpDownVote.new(up_down_vote_params)

  	if @up_down_vote.save
  		redirect_to up_down_votes_path
  	else
      flash[:notice]="Something went wrong"
  		redirect_to new_up_down_vote_path
  	end
  end

  def yes_vote
    register_vote("Yes")
  end

  def no_vote
    register_vote("no")
  end

  def destroy
    current_user.up_down_votes.find(params[:id]).destroy
    # @up_down_vote.destroy
    redirect_to up_down_votes_path
  end

end



private

def up_down_vote_params
	params.require(:up_down_vote).permit(:question, :up_vote, :down_vote, :vote_time, :voted)
end

def voted?(cv)
    return true if cv.voted.include?(current_user._id.to_s)  
end

def register_vote(vote)

current_vote = UpDownVote.where(_id: params[:id]).first

  if voted?(current_vote) 
    flash[:notice]="Sorry, you already voted"
    
    redirect_if_owner

  else

    flash[:notice] = "Thanks for your vote"
    current_vote.voted << current_user._id.to_s #add user to already voted

    if vote == "Yes"
      uv = current_vote.up_vote
      current_vote.up_vote = uv +1
      current_vote.save
    else
      dv = current_vote.down_vote 
      current_vote.down_vote = dv +1
      current_vote.save
    end
    
    redirect_if_owner
    
  end

end

def redirect_if_owner
  current_vote = UpDownVote.where(_id: params[:id]).first
  if current_vote.user_id == current_user.id
      redirect_to up_down_votes_path
  else
      redirect_to up_down_vote_path
  end
end




