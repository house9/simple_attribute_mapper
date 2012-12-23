module MapIt
  class Map
    def initialize(source_class)
      @source_class = source_class
      @mappings = {}
    end

    attr_accessor :target_class
    attr_accessor :source_class
    attr_accessor :mappings

    def to(target_class)
      @target_class = target_class
      self
    end

    def with(args)
      mappings.merge!(args)
      self
    end
  end
end