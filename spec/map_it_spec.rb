require 'spec_helper'

describe MapIt do
  describe "from" do
    it "returns map" do
      source = Struct.new(:foo)
      map = MapIt.from(source).should be_an_instance_of(MapIt::Map)
    end
  end
end

describe MapIt::Map do
  let(:source) { Struct.new(:foo) }
  let(:target) { Struct.new(:bar) }

  context "returns the same map" do
    it "to" do
      map = MapIt::Map.new(source)
      to = map.to(target)
      to.should be_an_instance_of(MapIt::Map)
      to.should == map
    end

    it "with" do
      map = MapIt::Map.new(source)
      with = map.with({})
      with.should be_an_instance_of(MapIt::Map)
      with.should == map
    end
  end

  describe "with" do
    it "adds mapping" do
      map = MapIt::Map.new(source)
      map.with({:a => :b})
      map.mappings.has_key?(:a).should be_true
      map.with({:x => :y})
      map.mappings.has_key?(:x).should be_true
    end
  end
end

describe MapIt::Mapper do
  it "can be" do
    MapIt::Mapper.new.should be_an_instance_of(MapIt::Mapper)
  end

  describe "map" do
    class Foo
      include Virtus

      attribute :baz, String
      attribute :foo, String
    end

    class Bar
      include Virtus

      attribute :baz, String
    end

    it "raises error when no source has no attributes" do
      expect { MapIt::Mapper.new.map(Object.new, Bar) }.to raise_error(MapIt::UnMappableError)
    end

    it "maps attributes" do
      mapper = MapIt::Mapper.new
      foo = Foo.new({baz: "BAZ"})
      bar = mapper.map(foo, Bar)
      bar.baz.should == "BAZ"
    end

    it "does not map when no target attribute" do
      mapper = MapIt::Mapper.new
      foo = Foo.new({baz: "BAZ", foo: "FOO"})
      bar = mapper.map(foo, Bar)
      bar.baz.respond_to?(:foo).should be_false
    end
  end
end

describe "Building a mapping" do
  let(:source) { Struct.new(:foo) }
  let(:target) { Struct.new(:bar) }

  it "is built" do
    map = MapIt.from(source).to(target).with({foo: :bar}).with(xyz: :abc)
    map.should be_an_instance_of(MapIt::Map)
  end
end