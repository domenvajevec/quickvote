class UpDownVote
  include Mongoid::Document

  belongs_to :user

  validates :question, presence: true
  validates :vote_time, presence: true

  field :question, type: String
  field :up_vote, type: Integer
  field :down_vote, type: Integer, default: 0
  field :vote_time, type: Integer, default: 0
  field :expiration_time, type: Time
end
