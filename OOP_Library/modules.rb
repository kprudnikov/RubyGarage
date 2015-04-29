module Jsonable
  def stringify
    hash = {}
    self.instance_variables.each do |var|
        hash[var] = self.instance_variable_get var
      end
    hash.to_json
  end
end