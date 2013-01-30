module SimpleAttributeMapper
  class Mapper
    def initialize(mappings = {})
      @mappings = mappings
    end

    attr_reader :mappings

    def map(source, target_class)
      map_attributes(source, target_class.new)
    end

    def map_attributes(source, target_instance)
      raise UnMappableError.new("source has no attributes") unless source.respond_to?(:attributes)

      map_matching_attributes(source, target_instance)
      map_specified_attributes(source, target_instance)

      target_instance
    end

    def map_matching_attributes(source, target)
      source.attributes.each do |attribute|
        attribute_writer = "#{attribute[0]}=".to_sym
        attribute_value = attribute[1]

        if target.respond_to?(attribute_writer)
          target.send(attribute_writer, attribute_value)
        end
      end
    end

    def map_specified_attributes(source, target)
      mappings.each do |source_attribute, target_attribute|
        attribute_writer = "#{target_attribute}=".to_sym
        attribute_value = resolve_attribute_value(source_attribute, source)
        # puts "#{attribute_writer} - #{attribute_value}"
        target.send(attribute_writer, attribute_value)
      end
    end

    def resolve_attribute_value(mapping_key, source)
      if mapping_key.is_a?(Symbol)
        source.send(mapping_key)
      elsif mapping_key.is_a?(Array)
        resolve_nested_value(mapping_key, source)
      elsif mapping_key.is_a?(Proc)
        mapping_key.call(source)
      else
        raise "Fatal, mapping for '#{mapping_key}' is unknown"
      end
    end

    def resolve_nested_value(mapping_key, source)
      root_key = mapping_key.shift
      current = source.send(root_key)

      mapping_key.each do |nested|
        value = current.send(nested)
        if nested == mapping_key.last
          return value
        end
        current = value
      end
    end

  end
end