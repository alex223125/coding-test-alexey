class CreateFindings < ActiveRecord::Migration[6.1]
  def change
    create_table :findings do |t|
      t.jsonb :schema, null: false, default: { "required": [ "port", "svc_name", "protocol",
                                                             "severity", "plugin_id",
                                                             "plugin_name", "plugin_family" ],
                                               "attributes": {
                                                 "port": { "type": "string", "default": "" },
                                                 "svc_name": { "type": "string", "default": "" },
                                                 "protocol": { "type": "string", "default": "" },
                                                 "severity": { "type": "string", "default": "" },
                                                 "plugin_id": { "type": "string", "default": "" },
                                                 "plugin_name": { "type": "string", "default": "" },
                                                 "plugin_family": { "type": "string", "default": "" } } }
      t.jsonb :description
      t.timestamps
    end
  end
end