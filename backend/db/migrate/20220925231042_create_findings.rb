class CreateFindings < ActiveRecord::Migration[6.1]
  def change
    create_table :findings do |t|
      t.jsonb :schema, null: false, default: { "required": [ "plugin_name", "port", "severity", "plugin_id", "data" ],
                                               "attributes": { "plugin_name": { "type": "string", "default": "" },
                                                               "port": { "type": "string", "default": "" },
                                                               "severity": { "type": "string", "default": "" },
                                                               "plugin_id": { "type": "integer", "default": nil },
                                                               "data": { "type": "text", "default": "" } } }
      t.jsonb :description
      t.timestamps
    end
  end
end


# puts event.name if event.name   # The Event Name If Not Blank.
# puts event.port                 # The Event Port. (supports .number, .protocol and .service)
# puts event.severity             # The Event Severity (0->Informational, 1->low, 2->medium, 3->high, 4->critical)
# puts event.plugin_id            # The Nessus Plugin ID.
# puts event.data if event.data   # Raw Nessus Plugin Output Data.

# class CreateVehicles < ActiveRecord::Migration[5.2]
#   def change
#     create_table :findings do |t|
#       t.jsonb :schema, null: false, default: { "required": [ "plugin_name", "port", "severity", "plugin_id", "data" ],
#                                                "attributes": { "plugin_name": { "type": "string", "default": "" },
#                                                                "port": { "type": "string", "default": "" },
#                                                                "severity": { "type": "string", "default": "" },
#                                                                "plugin_id": { "type": "integer", "default": nil },
#                                                                "data": { "type": "text", "default": "" } } }
#       t.jsonb :description
#       t.timestamp
#     end
#   end
# end