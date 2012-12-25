module SimpleAttributeMapper
  class Configuration
    def initialize
      @maps = []
    end

    attr_reader :maps

    def add_mapping(map)
      maps.each do |existing_map|
        if existing_map.source_class == map.source_class && existing_map.target_class == map.target_class
          raise DuplicateMappingError.new("Map is already configured for '#{map.source_class}' -> '#{map.target_class}'")
        end
      end

      maps << map
    end

    def << map
      add_mapping(map)
    end

    def find_mapping(source_class, target_class)
      maps.select do |map|
        map.source_class == source_class && map.target_class == target_class
      end
    end

    # for testing only
    def clear
      @maps = []
    end
  end
end