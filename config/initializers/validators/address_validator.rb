require 'open-uri'

class ArcGISValidator < ActiveModel::EachValidator
    def validate_each(record, attr_name, value)
        response = nil
        begin
            response = open("#{Address::GIS_URL}?#{record.arc_gis_params}")
        rescue => exception
            record.errors.add(attr_name, :validation_service, options.merge(value: value))            
            return
        end
        candidates = JSON.parse(response.read)["candidates"]
        matches = candidates.select { |candidate| candidate["score"] == 100 }
        if matches.empty?
            record.errors.add(attr_name, :real_address, options.merge(value: value))
            return
        end
        attributes = matches.first["attributes"].presence
        record.house_number ||= attributes["AddNum"].presence
        record.street_name ||= attributes["StName"].presence
        record.street_predirection ||= attributes["StPreDir"].presence
        record.street_postdirection ||= attributes["StDir"].presence
        # overwrite because we always want the two letter abbreviation for state
        record.state = attributes["RegionAbbr"].presence if record.state.present?
        record.county ||= attributes["Subregion"].presence
        record.zip_5 ||= attributes["Postal"].presence
        record.zip_4 ||= attributes["PostalExt"].presence
        match = /\b(#{Address::STREET_TYPES.join('|')})\b/i.match(value)
        record.street_type ||= match[1] if match
        match = /\b(#{Address::UNIT_TYPES.join('|')}) (.+?)\b/i.match(value)
        if match
            record.unit_type = match[1]
            record.unit_number = match[2]
        end
        if record.zip_4.nil? && /\d{5}-?(?<zip_4>\d{4})?/ =~ record.zip_code
            record.zip_4 ||= zip_4
        end
    end
end

# This allows us to assign the validator in the model
module ActiveModel::Validations::HelperMethods
    def validates_address(*attr_names)
        validates_with ArcGISValidator, _merge_attributes(attr_names)
    end
end