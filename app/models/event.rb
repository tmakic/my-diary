class Event < ApplicationRecord
    has_many :event_exercise, dependent: :destroy
    has_many :exercises, :through => :event_exercise
    
    accepts_nested_attributes_for :event_exercise, allow_destroy: true
end
