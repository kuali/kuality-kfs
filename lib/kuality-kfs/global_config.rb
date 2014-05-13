module GlobalConfig
  def ksb_client
    @@ksb_client ||= KSBServiceClient.new()
  end
  def role_service
    @@role_service ||= ksb_client.getRoleService()
  end
  def identity_service
    @@identity_service ||= ksb_client.getIdentityService()
  end
  def group_service
    @@group_service ||= ksb_client.getGroupService()
  end
  def parameter_service
    @@parameter_service ||= ksb_client.getParameterService()
  end
  def get_parameter_values(namespace_code, parameter_name, component_code='All')
    paramKey = ParameterKeyType.new()
    paramKey.setApplicationId('KFS')
    paramKey.setNamespaceCode(namespace_code)
    paramKey.setComponentCode(component_code)
    paramKey.setName(parameter_name)
    @@parameter_values = parameter_service.getParameterValuesAsString(paramKey).getValue().to_a
  end
  def get_aft_parameter_values(parameter_name)
    get_parameter_values('KFS-AFTEST', parameter_name)
  end
  def get_aft_parameter_value(parameter_name)
    get_parameter_values('KFS-AFTEST', parameter_name)[0]
  end
  def get_group_member_principal_ids(group_id)
    group_service.getMemberPrincipalIds(group_id).getPrincipalId()
  end
  def get_group_members(group_id)
    group_service.getMembersOfGroup(group_id).getMember()
  end
  def get_first_principal_id_for_role(name_space, role_name)
    role_service.getRoleMemberPrincipalIds(name_space, role_name, StringMapEntryListType.new).getPrincipalId().get(0)
  end
  #def get_random_principal_id_for_role(name_space, role_name)
  #  principal_ids ||= role_service.getRoleMemberPrincipalIds(name_space, role_name, StringMapEntryListType.new)
  #  principal_ids.sample
  #end
  def get_principal_name_for_principal_id(principal_name)
    identity_service.getEntityByPrincipalId(principal_name).getPrincipals().getPrincipal().get(0).getPrincipalName()
  end
  def get_first_principal_name_for_role(name_space, role_name)
    @@prinicpal_names ||= Hash.new{|hash, key| hash[key] = Hash.new}

    if !@@prinicpal_names[name_space][role_name].nil?
      @@prinicpal_names[name_space][role_name]
    else
      @@prinicpal_names[name_space][role_name] = get_principal_name_for_principal_id(get_first_principal_id_for_role(name_space, role_name))
    end
  end
  def get_principal_name_for_role(name_space, role_name)
    principal_names = Array.new
    role_service.getRoleMemberPrincipalIds(name_space, role_name, StringMapEntryListType.new).getPrincipalId().each {|id| principal_names.push(get_principal_name_for_principal_id(id))}
    principal_names
  end
  def get_principal_name_for_group(group_id)
    principal_names = Array.new
    get_group_member_principal_ids(group_id).each {|id| principal_names.push(get_principal_name_for_principal_id(id))}
    principal_names
  end
  #def get_random_principal_name_for_role(name_space, role_name)
  #  @@prinicpal_names ||= Hash.new{|hash, key| hash[key] = Hash.new}
  #
  #  if !@@prinicpal_names[name_space][role_name].nil?
  #    @@prinicpal_names[name_space][role_name]
  #  else
  #    @@prinicpal_names[name_space][role_name] = get_principal_name_for_principal_id(get_random_principal_id_for_role(name_space, role_name))
  #  end
  #end
end

World(GlobalConfig)