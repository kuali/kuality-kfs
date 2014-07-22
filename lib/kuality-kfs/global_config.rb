module GlobalConfig
  require 'mechanize'
  require 'xmlsimple'

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
  def state_service
    @@state_service ||= ksb_client.getStateService()
  end
  def postal_code_service
    @@postal_code_service ||= ksb_client.getPostalCodeService()
  end
  def parameter_service
    @@parameter_service ||= ksb_client.getParameterService()
  end
  def workflow_document_service
    @@workflow_document_service ||= ksb_client.getWorkflowDocumentService()
  end
  # Can be used to get any of the system parameters
  # get_parameter_values('KFS-PURAP', 'B2B_TOTAL_AMOUNT_FOR_AUTO_PO', 'Requisition'
  def get_parameter_values(namespace_code, parameter_name, component_code='All')
    raise ArgumentError, 'namespace_code missing' if namespace_code.to_s == ''
    raise ArgumentError, 'parameter_name missing' if parameter_name.to_s == ''

    paramKey = ParameterKeyType.new()
    paramKey.setApplicationId('KFS')
    paramKey.setNamespaceCode(namespace_code)
    paramKey.setComponentCode(component_code)
    paramKey.setName(parameter_name)
    parameter_service.getParameterValuesAsString(paramKey).getValue().to_a
  end
  # Used to get any of the AFT-specific parameters - should be used with a constant, not passing in a string
  # get_aft_parameter_values_as_hash(ParameterConstants::DEFAULTS_FOR_ASSET_GLOBAL)
  def get_aft_parameter_values(parameter_name)
    get_parameter_values('KFS-AFTEST', parameter_name)
  end
  # same as above but ureturns a hash which is easier to work with
  def get_aft_parameter_values_as_hash(parameter_name)
    h = {}
    get_parameter_values('KFS-AFTEST', parameter_name).each do |key_val_pair|
      k,v = key_val_pair.split('=')
      h[k.to_sym] = v
    end
    h
  end
  # Same as the first one but used when you know there is only a single value in the parameter
  def get_aft_parameter_value(parameter_name)
    get_parameter_values('KFS-AFTEST', parameter_name)[0]
  end
  # returns a list of principal IDs for a group
  def get_group_member_principal_ids(group_id)
    group_service.getMemberPrincipalIds(group_id).getPrincipalId()
  end
  # returns a list of group member objects for a group
  def get_group_members(group_id)
    group_service.getMembersOfGroup(group_id).getMember()
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
  def get_kuali_business_objects(namespace_code, object_type, identifiers)
    # Create new mechanize agent and hit the main page
    # then login once directed to CUWA
    agent = Mechanize.new
    page = agent.get($base_url)

    #First we need to hit up the weblogin form and get our selves a cookie
    perform_university_login(page)

    #now lets backdoor
    agent.get($base_url + 'portal.do?selectedTab=main&backdoorId=' + get_first_principal_name_for_role('KFS-SYS', 'Technical Administrator'))

    #finally make the request to the data object page
    query = $base_url + 'dataobjects/' + namespace_code + '/' + object_type + '.xml?' + identifiers
    page = agent.get(query)

    #pares the XML into a hash
    XmlSimple.xml_in(page.body)
  end

  def get_kuali_business_object(namespace_code, object_type, identifiers)
    business_objects = get_kuali_business_objects(namespace_code, object_type, identifiers)
    if business_objects.values[0].nil?
      raise RuntimeError, 'get_kuali_business_objects returned no objects'
    else if business_objects.keys[0].include?'businessobject'
         business_objects.values[0].sample
      else
           business_objects
      end
    end
  end

  def perform_university_login(page)
    #do nothing - override this in the university project
  end

  def get_generic_address_1()
    "#{rand(1..9999)} Evergreen Terrace"
  end
  def get_generic_address_2()
    "Room #{rand(1..999)}"
  end
  def get_generic_address_3()
    'Attn: John Doe Faculty'
  end
  def get_generic_city()
    random_letters(10)
  end
  def get_random_state_code()
    states = state_service.findAllStatesInCountry('US')
    states.get_state.to_a.sample.get_code
  end
  def get_random_postal_code(state)
    if state.nil?
      state_to_search = 'NY'
    else
      state_to_search = state
    end
    postal_codes = postal_code_service.findAllPostalCodesInCountry('US')
    if state_to_search == '*'
      postal_codes.get_postal_code.to_a.sample.code
    else
      postal_codes.get_postal_code.to_a.find_all{ |postal_code| postal_code.state_code == state_to_search}.sample.code
    end
  end
  def get_workflow_actions_taken(document_number)
    workflow_document_service.getActionsTaken(document_number)
  end
  def get_workflow_action_requests(document_number)
    workflow_document_service.getAllActionRequests(document_number)
  end
  def get_previous_route_node_names(document_number)
    workflow_document_service.getPreviousRouteNodeNames(document_number)
  end
  def get_root_action_requests(document_number)
    workflow_document_service.getRootActionRequests(document_number)
  end
  def fetch_random_account_number
    fetch_random_acount['accountNumber']
  end
  def fetch_random_acount
    get_kuali_business_object('KFS-COA','Account','active=Y&accountExpirationDate=NULL&chartOfAccountsCode=' + get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE))
  end
end