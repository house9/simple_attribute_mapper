module SimpleAttributeMapper
  class Mapper
    def initialize(mappings = {})
      @mappings = mappings
    end

    attr_reader :mappings

    def map(source, target_class)
      raise UnMappableError.new("source has no attributes") unless source.respond_to?(:attributes)

      target = target_class.new

      source.attributes.each do |attribute|
        attribute_writer = "#{attribute[0]}=".to_sym
        attribute_value = attribute[1]

        if target.respond_to?(attribute_writer)
          target.send(attribute_writer, attribute_value)
        end
      end

      mappings.each do |source_attribute, target_attribute|
        attribute_writer = "#{target_attribute}=".to_sym
        attribute_value = source.send(source_attribute)
        # puts attribute_writer
        # puts attribute_value
        target.send(attribute_writer, attribute_value)
      end

      target
    end
  end
end