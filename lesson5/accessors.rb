module Accessors
  def attr_accessor_with_history(*params)
    params.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=") do |value|
        instance_variable_set(var_name, value)
        @var_storage ||= {}
        @var_storage[name] ||= []
        @var_storage[name] << value
      end
      define_method("#{name}_history") do
        Hash(@var_storage)[name]
      end
    end
  end

  def strong_attr_accessor(obj, obj_class)
    define_method(obj) { instance_variable_get("@#{obj}") }
    define_method("#{obj}=") do |value|
      raise "Class mismatch" if value.is_a?(obj_class)
      instance_variable_set("@#{obj}", value)
    end
  end

  def is_not_a?
    !is_a?
  end
end

class TestAccessors
  extend Accessors

  attr_accessor_with_history :attr1
  strong_attr_accessor :attr2, Float
end

test = TestAccessors.new
test.attr1 = 123
test.attr1 = 9.1
test.attr2 = 'test'
puts test.attr1
puts test.attr1_history
