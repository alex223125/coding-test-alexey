# frozen_string_literal: true

class Report < ApplicationRecord
  has_many :segments, dependent: :destroy
  has_many :findings, through: :segments
end
