module MapIt
  class Mapper
    def initialize

    end

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

      target
    end
  end
end