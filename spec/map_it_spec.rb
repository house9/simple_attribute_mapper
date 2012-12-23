require 'spec_helper'

describe MapIt::Mapper do
  it "can be" do
    MapIt::Mapper.new.should be_an_instance_of(MapIt::Mapper)
  end

  describe "map" do
    class Foo
      include Virtus

      attribute :baz, String
    end

    class Bar
      include Virtus

      attribute :baz, String
    end

    it "maps attributes" do
      mapper = MapIt::Mapper.new
      foo = Foo.new({baz: "BAZ"})
      bar = mapper.map(foo, Bar)
      bar.baz.should == "BAZ"
    end
  end
end