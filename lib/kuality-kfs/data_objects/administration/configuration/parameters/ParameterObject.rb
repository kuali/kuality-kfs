class ParameterObject < MaintenanceObject

  attr_accessor :namespace_code, :component, :application_id,
                :parameter_name, :parameter_value, :parameter_description,
                :parameter_type_code, :parameter_constraint_code_allowed, :parameter_constraint_code_denied

  def build

  end

end
