require 'spec_helper'

describe SimpleAttributeMapper do
  describe "from" do
    it "returns map" do
      source = Struct.new(:foo)
      map = SimpleAttributeMapper.from(source).should be_an_instance_of(SimpleAttributeMapper::Map)
    end
  end
end

describe SimpleAttributeMapper::Map do
  let(:source) { Struct.new(:foo) }
  let(:target) { Struct.new(:bar) }

  context "returns the same map" do
    it "to" do
      map = SimpleAttributeMapper::Map.new(source)
      to = map.to(target)
      to.should be_an_instance_of(SimpleAttributeMapper::Map)
      to.should == map
    end

    it "with" do
      map = SimpleAttributeMapper::Map.new(source)
      with = map.with({})
      with.should be_an_instance_of(SimpleAttributeMapper::Map)
      with.should == map
    end
  end

  describe "with" do
    it "adds mapping" do
      map = SimpleAttributeMapper::Map.new(source)
      map.with({:a => :b})
      map.mappings.has_key?(:a).should be_true
      map.with({:x => :y})
      map.mappings.has_key?(:x).should be_true
    end
  end
end

describe SimpleAttributeMapper::Mapper do
  it "can be" do
    SimpleAttributeMapper::Mapper.new.should be_an_instance_of(SimpleAttributeMapper::Mapper)
  end

  describe "map" do
    class Foo
      include Virtus

      attribute :baz, String
      attribute :foo, String
      attribute :abc, String
    end

    class Bar
      include Virtus

      attribute :baz, String
      attribute :xyz, String
    end

    it "raises error when no source has no attributes" do
      expect { SimpleAttributeMapper::Mapper.new.map(Object.new, Bar) }.to raise_error(SimpleAttributeMapper::UnMappableError)
    end

    it "maps attributes" do
      mapper = SimpleAttributeMapper::Mapper.new
      foo = Foo.new({baz: "BAZ"})
      bar = mapper.map(foo, Bar)
      bar.baz.should == "BAZ"
    end

    it "does not map when no target attribute" do
      mapper = SimpleAttributeMapper::Mapper.new
      foo = Foo.new({baz: "BAZ", foo: "FOO"})
      bar = mapper.map(foo, Bar)
      bar.baz.respond_to?(:foo).should be_false
    end

    it "maps specified attributes" do
      mapper = SimpleAttributeMapper::Mapper.new({:abc => :xyz})
      foo = Foo.new({baz: "BAZ", foo: "FOO", abc: "ABC"})
      bar = mapper.map(foo, Bar)
      bar.xyz.should == "ABC"
    end
  end
end

describe "Building a mapping" do
  let(:source) { Struct.new(:foo) }
  let(:target) { Struct.new(:bar) }

  it "is built" do
    map = SimpleAttributeMapper.from(source).to(target).with({foo: :bar}).with(xyz: :abc)
    map.should be_an_instance_of(SimpleAttributeMapper::Map)
  end
end