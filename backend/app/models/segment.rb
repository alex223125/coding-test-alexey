# frozen_string_literal: true

class Segment < ApplicationRecord
  belongs_to :report
  has_many :findings, dependent: :destroy
end
