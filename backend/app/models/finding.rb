# frozen_string_literal: true

class Finding < ApplicationRecord
  store_accessor :schema, :required, :attributes
  serialize :description

  belongs_to :segment

  after_initialize :define_default_values

  private

  def define_default_values
    return if description.present?

    self.description = schema['attributes'].keys.index_with do |field|
      schema['attributes'][field]['default']
    end
  end

  def validate_from_schema
    schema['required'].each do |field|
      errors.add(field, 'is required') if description[field].blank?
    end
  end
end
