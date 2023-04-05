class User < ApplicationRecord
  include Followable
  include SleepRecordable

  validates_presence_of :name
end
