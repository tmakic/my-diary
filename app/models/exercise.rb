class Exercise < ApplicationRecord
    has_many :event_exercise, dependent: :destroy
    has_many :events, :through => :event_exercise
end
