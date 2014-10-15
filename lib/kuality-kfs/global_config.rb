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
  def permission_service
    @@permission_service ||= ksb_client.getPermissionService()
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
  # returns a list of assignees for a group
  def get_permission_assignees_by_template(namespace_code, template_name, permission_details)
    key, value = permission_details.first
    perm_details_list = StringMapEntryListType.new
    perm_detail = StringMapEntryType.new
    perm_detail.key = key.to_s
    perm_detail.value = value.to_s
    perm_details_list.entry.add(perm_detail)
    permission_service.getPermissionAssigneesByTemplate(namespace_code, template_name, perm_details_list, StringMapEntryListType.new).assignee
  end
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
  def get_random_principal_id_with_phone_number_for_role(name_space, role_name)
    phone_number = nil
    pid = nil
    while phone_number.nil? || phone_number.empty?
      pid = get_random_principal_id_for_role(name_space, role_name)
      phone_number = identity_service.getEntityByPrincipalId(pid)
                                     .getEntityTypeContactInfos().getEntityTypeContactInfo().get(0)
                                     .getPhoneNumbers().getPhoneNumber().get(0)
                                     .getPhoneNumber()
    end
    pid
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
  def get_random_principal_with_phone_name_for_role(name_space, role_name)
    @@prinicpal_names ||= Hash.new{|hash, key| hash[key] = Hash.new}

    if !@@prinicpal_names[name_space][role_name].nil?
      @@prinicpal_names[name_space][role_name]
    else
      @@prinicpal_names[name_space][role_name] = get_principal_name_for_principal_id(get_random_principal_id_with_phone_number_for_role(name_space, role_name))
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
  def get_document_initiator(document_type)
    permission_details = {'documentTypeName' => document_type}
    assignees = get_permission_assignees_by_template('KR-SYS', 'Initiate Document', permission_details).to_a
    if assignees.any?
      principal_id = assignees.delete_if{ |assignee| assignee.principalId == '2'}.sample.principalId
      person = identity_service.getEntity(principal_id)
      person.principals.principal.to_a.sample.principalName
    else
      get_principal_name_for_role('KFS-SYS', 'Manager').sample
    end
  end
  def get_document_blanket_approver(document_type)
    permission_details = {'documentTypeName' => document_type}
    assignees = get_permission_assignees_by_template('KR-WKFLW', 'Blanket Approve Document', permission_details).to_a
    assignee = assignees.delete_if{ |assignee| assignee.principalId == '2'}.sample
    if assignee.nil?
      principal_name = get_principal_name_for_role('KFS-SYS', 'Manager').sample
    else
      principal_id = assignee.principalId
      person = identity_service.getEntity(principal_id)
      principal_name = person.principals.principal.to_a.sample.principalName
    end
    principal_name
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
    get_kuali_business_object('KFS-COA','Account',"active=Y&accountExpirationDate=NULL&chartOfAccountsCode=#{get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)}")
  end
  def fetch_random_capital_asset_object_code
    current_fiscal_year   = get_aft_parameter_value('CURRENT_FISCAL_YEAR')
    chart_code = get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)
    get_kuali_business_object('KFS-COA', 'ObjectCode', "universityFiscalYear=#{current_fiscal_year}&financialObjectSubTypeCode=CM&financialObjectTypeCode=EE&chartOfAccountsCode=#{chart_code}")['financialObjectCode'][0]
  end
  def fetch_random_capital_asset_number
    # TODO : it took long time for asset search, so put several criteria to speed up the lookup
    get_kuali_business_object('KFS-CAM','Asset',"active=true&capitalAssetTypeCode=A&inventoryStatusCode=A&conditionCode=E&campusCode=#{get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)}")['capitalAssetNumber'].sample
  end
  def get_principal_names_for_role(name_space, role_name)
    role_service.getRoleMemberPrincipalIds(name_space, role_name, StringMapEntryListType.new).getPrincipalNames().to_a
  end
  def fetch_random_origination_code
    get_kuali_business_object('KFS-SYS','OriginationCode','active=true')['financialSystemOriginationCode'].sample
  end
  def fetch_random_department_organization_code
    get_kuali_business_object('KFS-SYS','Organization','organizationTypeCode=D&organizationCode=01**&active=true')['organizationCode'].sample
  end

  def get_random_principal_without_favorite_account_for_role(name_space, role_name)
    @@prinicpal_names ||= Hash.new{|hash, key| hash[key] = Hash.new}

    if !@@prinicpal_names[name_space][role_name].nil?
      @@prinicpal_names[name_space][role_name]
    else
      @@prinicpal_names[name_space][role_name] = get_principal_name_for_principal_id(get_random_principal_id_without_favorite_Account_for_role(name_space, role_name))
    end
  end
  def get_random_principal_id_without_favorite_Account_for_role(name_space, role_name)
    pid = nil
    user_profile_exists = true
    i = 0
    while user_profile_exists && i < 20
      pid = get_random_principal_id_for_role(name_space, role_name)
        begin
          user_profile = get_kuali_business_object('KFS-SYS','UserProcurementProfile',"principalId=#{pid}")
        rescue
          # no user profile
          user_profile_exists = false
        end
      i += 1
    end
    pid.nil? ? get_random_principal_id_for_role(name_space, role_name) : pid
  end

  def get_current_user
    unless @logged_in_users_list.nil? || @logged_in_users_list.empty?
      return @logged_in_users_list.last
    else
      return nil
    end
  end

  def set_current_user (user)
    unless @logged_in_users_list.nil?
      @logged_in_users_list.push user
    else
      @logged_in_users_list = Array.new
      @logged_in_users_list.push user
    end
  end

  def perform_backdoor_login(user)
    visit(BackdoorLoginPage).login_as(user)
    set_current_user(user)
  end
end