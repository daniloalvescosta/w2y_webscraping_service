class Task < ApplicationRecord
  has_many :vehicles

  enum status: {
    pending: "pending",
    failure: "failure",
    in_progress: "in_progress",
    complete: "complete"
  }
end
