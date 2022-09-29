module Services
  module Reports
    class NessusReportItemParser < Nokogiri::XML::SAX::Document

      def initialize(segment)
        @segment = segment
        @finding = Finding.new
        @finding.segment = @segment
        @current_element = {}
      end

      def start_element(name, attrs = [])
        attrs = attrs.to_h

        @current_element[:name] = name

        case name
        when 'ReportItem'
          @finding.tap do |u|
            u.description["port"] = attrs['port']
            u.description["svc_name"] = attrs['svc_name']
            u.description["protocol"] = attrs['protocol']
            u.description["severity"] = attrs['severity']
            u.description["plugin_id"] = attrs['pluginID']
            u.description["plugin_name"] = attrs['pluginName']
            u.description["plugin_family"] = attrs['pluginFamily']
          end
        end

      end

      def characters(string)
        if @current_element[:name] == "description"
          @finding.description["data"] = string
        elsif @current_element[:name] == "fname"
          @finding.description["fname"] = string
        elsif @current_element[:name] == "plugin_modification_date"
          @finding.description["plugin_modification_date"] = string
        elsif @current_element[:name] == "plugin_name"
          @finding.description["plugin_name"] = string
        elsif @current_element[:name] == "plugin_publication_date"
          @finding.description["plugin_publication_date"] = string
        elsif @current_element[:name] == "plugin_type"
          @finding.description["plugin_type"] = string
        elsif @current_element[:name] == "risk_factor"
          @finding.description["risk_factor"] = string
        elsif @current_element[:name] == "script_version"
          @finding.description["script_version"] = string
        elsif @current_element[:name] == "synopsis"
          @finding.description["synopsis"] = string
        elsif @current_element[:name] == "plugin_output"
          @finding.description["plugin_output"] = string
        end
      end

      def end_element(name)
        @current_element[:name] = nil
      end

      def end_document
        @finding.save!
      end
    end
  end
end