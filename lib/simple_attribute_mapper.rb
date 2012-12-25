require "simple_attribute_mapper/version"
require "simple_attribute_mapper/mapper"
require "simple_attribute_mapper/un_mappable_error"
require "simple_attribute_mapper/map"
require "simple_attribute_mapper/configuration"

module SimpleAttributeMapper
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.from(source_class)
    Map.new(source_class)
  end

  def self.map(source_instance, target_class)
    raise "TODO: implement"
  end
end
