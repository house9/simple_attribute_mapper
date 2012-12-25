module SimpleAttributeMapper
  class Configuration
    def initialize
      @maps = []
    end

    attr_reader :maps

    def add_mapping(map)
      maps << map
    end

    def << map
      add_mapping(map)
    end

    # for testing only
    def clear
      @maps = []
    end
  end
end