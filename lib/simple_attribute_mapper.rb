require "simple_attribute_mapper/version"
require "simple_attribute_mapper/mapper"
require "simple_attribute_mapper/un_mappable_error"
require "simple_attribute_mapper/map"

module SimpleAttributeMapper
  def self.from(source_class)
    Map.new(source_class)
  end
end
