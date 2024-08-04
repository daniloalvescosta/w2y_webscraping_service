class Task < ApplicationRecord
  has_many :vehicles
  validates :user_email, presence: true
  validates :user_id, presence: true
  validates :status, presence: true
  validates :uuid, presence: true

  enum status: {
    pending: "pending",
    failure: "failure",
    in_progress: "in_progress",
    complete: "complete"
  }
end
