class Segment < ApplicationRecord

  belongs_to :report
  has_many :findings

end
