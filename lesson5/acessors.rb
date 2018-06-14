module Acessors
  def attr_acessor_with_history(*params)
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
        @var_storage ||= {}
        @var_storage[name]
      end
    end
  end

  def strong_attr_acessor(obj, obj_class)
    var_name = "@#{obj}".to_sym
    define_method(obj) { instance_variable_get(var_name) }
    define_method("#{name}=") do |value|
      raise "Class mismatch" unless obj.class.is_a?(obj_class)
      instance_variable_set(var_name, value)
    end
  end
end