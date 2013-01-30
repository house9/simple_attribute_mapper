require "simple_attribute_mapper/version"
require "simple_attribute_mapper/mapper"
require "simple_attribute_mapper/configuration_error"
require "simple_attribute_mapper/duplicate_mapping_error"
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
    mapper_for(source_instance, target_class).map(source_instance, target_class)
  end

  def self.map_attributes(source_instance, target_instance)
    mapper_for(source_instance, target_instance.class).map_attributes(source_instance, target_instance)
  end

  def self.mapper_for(source_instance, target_class)
    if self.configuration.maps.length == 0
      raise ConfigurationError.new("There are no mappings configured, check the documentation for configuration steps")
    end

    mappings = configuration.find_mapping(source_instance.class, target_class)
    if mappings.length == 0
      raise ConfigurationError.new("There are no mappings configured for '#{source_instance.class}' -> '#{target_class}'")
    end

    Mapper.new(mappings[0].mappings)
  end
end
