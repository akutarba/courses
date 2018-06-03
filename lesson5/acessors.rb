module Acessors
  def attr_acessor_with_history(*params)
    params.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        @var_storage ||= {}
        @var_storage[name] ||= []
        @var_storage[name] << value
      end
      define_method("#{name}_history") { @var_storage[name] }
    end
  end

  def strong_attr_acessor(obj, obj_class)
    var_name = "@#{obj}".to_sym
    define_method(obj) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise "Class mismatch" if obj.class != obj_class
      instance_variable_set(var_name, value)
    end
  end
end