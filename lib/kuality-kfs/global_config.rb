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
  def parameter_service
    @@parameter_service ||= ksb_client.getParameterService()
  end
  def parameter_service
    @@parameter_service ||= ksb_client.getParameterService()
  end
  def get_parameter_values(namespace_code, parameter_name)
    raise ArgumentError, 'namespace_code missing' if namespace_code.to_s == ''
    raise ArgumentError, 'parameter_name missing' if parameter_name.to_s == ''

    paramKey = ParameterKeyType.new()
    paramKey.setApplicationId('KFS')
    paramKey.setNamespaceCode(namespace_code)
    paramKey.setComponentCode('All')
    paramKey.setName(parameter_name)
    parameter = parameter_service.getParameterValuesAsString(paramKey)
    puts parameter
    raise 'No parameter found for namespace_code=' + namespace_code + ' and parameter_name=' + parameter_name if parameter.nil?

    @@parameter_values = parameter_service.getParameterValuesAsString(paramKey).getValue().to_a
  end
  def get_aft_parameter_values(parameter_name)
    get_parameter_values('KFS-AFTEST', parameter_name)
  end
  def get_aft_parameter_values_as_hash(parameter_name)
    h = {}
    get_parameter_values('KFS-AFTEST', parameter_name).each do |kay_val_pair|
      k,v = kay_val_pair.split('=')
      h[k] = v
    end
    h
  end
  def get_aft_parameter_value(parameter_name)
    get_parameter_values('KFS-AFTEST', parameter_name)[0]
  end
  def get_first_principal_id_for_role(name_space, role_name)
    role_service.getRoleMemberPrincipalIds(name_space, role_name, StringMapEntryListType.new).getPrincipalId().get(0)
  end
  def get_random_principal_id_for_role(name_space, role_name)
    principalIds = role_service.getRoleMemberPrincipalIds(name_space, role_name, StringMapEntryListType.new).getPrincipalId()
    principalIds.get(java.lang.Math.random() * principalIds.size())
  end
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
  def get_random_principal_name_for_role(name_space, role_name)
    @@prinicpal_names ||= Hash.new{|hash, key| hash[key] = Hash.new}

    if !@@prinicpal_names[name_space][role_name].nil?
       @@prinicpal_names[name_space][role_name]
    else
       @@prinicpal_names[name_space][role_name] = get_principal_name_for_principal_id(get_random_principal_id_for_role(name_space, role_name))
    end
  end

  def get_kuali_business_objects(namespace_code, object_type, identifiers)
    get_kuali_business_object(namespace_code, object_type, identifiers)[0]
  end

  def get_kuali_business_object(namespace_code, object_type, identifiers)
    # Create new mechanize agent and hit the main page
    # then login once directed to CUWA
    agent = Mechanize.new
    page = agent.get($base_url)

    #First we need to hit up the weblogin form and get our selves a cookie
    perform_university_login(page)

    #now lets backdoor
    agent.get($base_url + '/portal.do?selectedTab=main&backdoorId=' + get_first_principal_name_for_role('KFS-SYS', 'Manager'))
    #TODO fix
    #finally make the request to the data object page
    page = agent.get($base_url + '/dataobjects/' + namespace_code + '/' + object_type + '.xml?' + identifiers)
    #TODO fix

    #pares the XML into a hash
    XmlSimple.xml_in(page.body)
  end

  def perform_university_login(page)
    #do nothing - override this in the university project
  end
end

World(GlobalConfig)