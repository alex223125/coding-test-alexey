# frozen_string_literal: true

class FindingSerializer < ActiveModel::Serializer
  attributes :id, :port, :protocol, :severity, :svc_name, :plugin_id, :plugin_name,
             :plugin_family, :data, :fname, :plugin_modification_date,
             :plugin_publication_date, :plugin_type, :risk_factor,
             :script_version, :synopsis, :plugin_output

  FIELDS = %i[port protocol severity svc_name plugin_id plugin_name
              plugin_family data fname plugin_modification_date
              plugin_publication_date plugin_type risk_factor
              script_version synopsis plugin_output].freeze

  FIELDS.each do |method_name|
    define_method :"#{method_name}" do
      object.description.try(:[], method_name.to_s)
    end
  end
end
