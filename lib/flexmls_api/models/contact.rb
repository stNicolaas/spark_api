module FlexmlsApi
  module Models
    class Contact < Base
      extend Finders
      self.element_name="contacts"
      
      def save(arguments={})
        begin
          return save!(arguments)
        rescue BadResourceRequest => e
        rescue NotFound => e
          # log and leave
          FlexmlsApi.logger.error("Failed to save contact #{self}: #{e.message}")
        end
        false
      end
      def save!(arguments={})
        results = connection.post self.class.path, {"Contacts" => [ attributes ]}, arguments
        result = results.first
        attributes['ResourceUri'] = result['ResourceUri']
        attributes['Id'] = parse_id(result['ResourceUri'])
        true
      end
    end
  end
end
