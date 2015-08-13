class Message < ActiveRecord::Base
  validates :steps_needed, presence: true
  belongs_to :user
end
