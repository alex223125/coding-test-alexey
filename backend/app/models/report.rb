class Report < ApplicationRecord

  has_many :segments
  has_many :findings, through: :segments

end
