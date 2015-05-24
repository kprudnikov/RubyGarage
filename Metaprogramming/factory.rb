class Factory

  def self.new(*args, &block)
    Class.new do
      args.each do |arg|
        attr_accessor arg
      end

      class_eval &block if block_given?

      define_method :initialize do |*elements|
        elements.each.with_index do |el, index|
          instance_variable_set("@#{args[index]}".to_sym, el)          
        end
      end

      def [](arg)
        if (arg.is_a? String) || (arg.is_a? Symbol)
          instance_variable_get arg
        elsif arg.is_a? Fixnum
          instance_variables[arg]
        end
      end
      
    end
  end
end

Pers = Factory.new(:name)
john = Pers.new("Smith")
puts john.inspect
puts john.name
puts john[1]
puts john[:name]