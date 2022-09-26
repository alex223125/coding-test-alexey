class Finding < ApplicationRecord
  store_accessor :schema, :required, :attributes
  serialize :description

  after_initialize :define_default_values

  private

  def define_default_values
    return unless self.description.blank?
    self.description = self.schema['attributes'].keys.reduce({}) do |acc, field|
      acc[field] = self.schema['attributes'][field]['default']
      acc
    end
  end

  def validate_from_schema
    self.schema['required'].each do |field|
      errors.add(field, 'is required') if self.description[field].blank?
    end
  end

end


