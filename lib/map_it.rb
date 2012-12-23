require "map_it/version"
require "map_it/mapper"
require "map_it/un_mappable_error"
require "map_it/map"

module MapIt
  def self.from(source_class)
    Map.new(source_class)
  end
end
