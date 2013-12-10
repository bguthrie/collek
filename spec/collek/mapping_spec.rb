require 'spec_helper'

describe Collek::Mapping do

  def collek(&block)
    Class.new(Collek::Mapping, &block)
  end

  context "defined by column" do
    context "simple" do
      let(:mapping) { collek { column :name } }
      subject { mapping.new(name: "Guybrush") }
      its(:name) { should eq("Guybrush") }
      its(:to_h) { should eq(name: "Guybrush") }
    end

    context "multiple bindings" do
      let(:mapping) { collek { column :name; column :age } }
      subject { mapping.new(name: "Guybrush", age: 19) }
      its(:to_h) { should eq(age: 19, name: "Guybrush") }
    end

    context "by delegate" do
      let(:mapping) { collek { column :name, method: :display_name } }
      subject { mapping.new(display_name: "Guybrush Threepwood") }
      its(:name) { should eq("Guybrush Threepwood")}
    end

    context "by block" do
      let(:mapping) { collek { column(:name) { object.display_name } } }
      subject { mapping.new(display_name: "Guybrush Threepwood") }
      its(:name) { should eq("Guybrush Threepwood") }
    end
  end

  context "defined by def" do
    context "simple" do
      let(:mapping) { collek { def name; object.name; end } }
      subject { mapping.new(name: "Guybrush") }
      its(:name) { should eq("Guybrush") }
      its(:to_h) { should eq(name: "Guybrush") }
    end

    context "multiple bindings" do
      let(:mapping) { collek { def name; object.name; end; def age; object.age; end } }
      subject { mapping.new(name: "Guybrush", age: 19) }
      its(:to_h) { should eq(age: 19, name: "Guybrush") }
    end

    context "mixed bindings" do
      let(:mapping) { collek { def name; object.name; end; column :age } }
      subject { mapping.new(name: "Guybrush", age: 19) }
      its(:to_h) { should eq(age: 19, name: "Guybrush") }
    end
  end

end
