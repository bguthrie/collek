module Collek
  class Mapping
    class << self
      def output(name, opts={}, &block)
        if block.nil?
          method_name = opts[:input] || name
          self.send(:define_method, name) { self.object.send(method_name) }
        else
          self.send(:define_method, name, &block)
        end
      end
    end

    attr_reader :object

    def initialize(object)
      @object = if object.is_a?(Hash)
        OpenStruct.new(object)
      else
        object
      end
    end

    def to_h
      self.class.instance_methods(false).inject({}) do |result, method|
        result.merge method => self.send(method)
      end
    end
  end
end
