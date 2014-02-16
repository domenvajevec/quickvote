class UpDownVote
  include Mongoid::Document

  belongs_to :user

  validates :question, presence: true
  validates :vote_time, presence: true

  field :question, type: String
  field :up_vote, type: Integer, default: 0
  field :down_vote, type: Integer, default: 0
  field :vote_time, type: Integer 
  field :created_at, type: Time, default: Time.now
  field :_id, type: String, default: -> {question.to_s.parameterize}
  field :voted, type: Array, default: ['']


	def vote_expired?
		self.created_at + self.vote_time.minutes
	end
end
