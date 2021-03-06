module Utilities

  include StringFactory

  def get(item)
    instance_variable_get(snakify(item))
  end

  def set(item, obj)
    instance_variable_set(snakify(item), obj)
  end

  def make_user(opts={})
    un=opts[:user]
    role=opts[:role]
    un ||= role
    $users << set(un, (make UserObject, opts))
    $users[-1]
  end

  def make_role(opts={})
    name = opts[:name]
    name ||= 'role'
    set(name, (make RoleObject, opts))
  end

  def snake_case(string)
    StringFactory.damballa(string)
  end

  def document_object_for(document)
    get(snake_case(document))
  end

  def document_object_of(klass)
    klass.to_s.gsub(/(?<=[a-z])(?=[A-Z])/, ' ').sub(/(.*) (Object)$/, '\1')
  end

  def object_class_for(document)
    Kernel.const_get("#{snake_case(document).to_s.split('_').map(&:capitalize).join('')}Object")
  end

  def page_class_for(document)
    Kernel.const_get("#{snake_case(document).to_s.sub(/[oO]bject$/, '').split('_').map(&:capitalize).join('')}Page")
  end

  def random_percentage
    random_dollar_value(100)
  end

  # @return [String] A randomly-generated tax number that should pass KFS's requirements for tax numbers. No other assurances.
  def random_tax_number
    "999#{rand(9)}#{rand(1..9)}#{rand(1..9999).to_s.rjust(4, '0')}"
  end

  # @return [String] A randomly-generated phone number that should pass KFS's requirements for phone numbers. No other assurances.
  def random_phone_number
    "#{rand(99..999)}-#{rand(99..999)}-#{rand(999..9999)}"
  end

  def fiscal_period_conversion(month)
    case month
      when 'JAN', 'Jan', 'January'
        '07'
      when 'FEB', 'Feb', 'February'
        '08'
      when 'MAR', 'Mar', 'March'
        '09'
      when 'APR', 'Apr', 'April'
        '10'
      when 'MAY', 'May'
        '11'
      when 'JUN', 'Jun', 'June'
        '12'
      when 'JUL', 'Jul', 'July'
        '01'
      when 'AUG', 'Aug', 'August'
        '02'
      when 'SEP', 'Sep', 'September'
        '03'
      when 'OCT', 'Oct', 'October'
        '04'
      when 'NOV', 'Nov', 'November'
        '05'
      when 'DEC', 'Dec', 'December'
        '06'
      else
        # We'll do a recursive conversion if we have to. On the second-time through,
        # we can be assured that the String length is 3 and will match something above
        # if the conversion is good.
        fail ArgumentError, 'Bad Fiscal Period conversion!' if month.length == 3
        fiscal_period_conversion(month[:MON]) # This may throw other errors, but that's ok.
    end
  end

  def yesno2setclear(value)
    case value.to_s.upcase
      when 'YES', 'ON', 'TRUE'
        :set
      when 'NO', 'OFF', 'FALSE'
        :clear
      else
        nil
    end
  end

  def to_standard_date(date)
    raise ArgumentError, 'The date provided is nil!' if date.nil?

    case
      when date.start_with?(/[0-9]/m)
        date_factory(date)[:date_w_slashes]
      when date == 'today'
        right_now[:date_w_slashes]
      else
        send(date.to_sym)[:date_w_slashes]
    end
  end

  # @param [String] type Named type of Account to search for with the service
  # @return [String] The Account Number of the requested type if found by the service, or nil if not found
  def get_account_of_type(type)
    case type
      when 'Unrestricted Account', 'NonGrant'
        get_kuali_business_object('KFS-COA','Account','organizationCode=01**&subFundGroupCode=GNDEPT&active=Y&accountExpirationDate=NULL')['accountNumber'].sample
      when 'Endowed NonGrant'
        get_kuali_business_object('KFS-COA','Account','accountTypeCode=EN&subFundGroupCode=GNDEPT&active=Y&accountExpirationDate=NULL')['accountNumber'].sample
      when 'Contracts & Grants with ICR'
        orgs_with_reviewers = %w(36 34 03 04 01 05) # TODO: Find a way to define this through the service or some such
        kbos = get_kuali_business_objects('KFS-COA',
                                          'Account',
                                          'fundGroupCode=CG' <<
                                          '&financialIcrSeriesIdentifier=RE1' <<
                                          '&acctIndirectCostRcvyTypeCd=22' <<
                                          '&active=Y' <<
                                          '&accountExpirationDate=NULL')['org.kuali.kfs.coa.businessobject.Account']
        kbos.reject! { |acct| acct['accountCfdaNumber'].empty? }
        kbos.reject! { |acct| !orgs_with_reviewers.any?{|org| org[0..1] == acct['organization.codeAndDescription'][0].split('-')[0][0..1] } }
        kbos.sample['accountNumber'][0]
      when 'Grant'
        get_kuali_business_object('KFS-COA','Account','organizationCode=01**&subFundGroupCode=CG*&active=Y&accountExpirationDate=NULL')['accountNumber'].sample
      when 'Endowed Grant'
        get_kuali_business_object('KFS-COA','Account','accountTypeCode=EN&organizationCode=01**&subFundGroupCode=CG*&active=Y&accountExpirationDate=NULL')['accountNumber'].sample
      else
        nil
    end
  rescue NoMethodError => nme
    # when 'Contracts & Grants with ICR' case occasionally returns no results, which causes the CFDA#-based filtering to raise a NoMethodError.
    raise ArgumentError,
          "Could not find any non-expired accounts of the supplied type (#{type})!" if nme.message == 'undefined method `reject!\' for nil:NilClass'
  rescue RuntimeError => re
    # In other cases, get_kuali_business_object will raise a RuntimeError if no results are found.
    nil
  end

  # @param [String] type Named type of Account to search for with the service
  # @return [String] The Account Number of the requested type if found by the service, or nil if not found
  def get_object_type_of_type(type, cap_asset_allowed=false)
    case type
      when 'Expenditure', 'Passes requirements for Requisition'
        object_consolidations = get_aft_parameter_values('REQS_OBJECT_CONSOLIDATIONS')
        object_levels         = get_aft_parameter_values('REQS_OBJECT_LEVELS')
        object_sub_types      = get_aft_parameter_values('REQS_OBJECT_SUB_TYPES')
        object_types          = get_aft_parameter_values('REQS_OBJECT_TYPES')
        valid_object_levels_by_object_type = get_aft_parameter_values_as_hash('REQS_VALID_OBJECT_LEVELS_BY_OBJECT_TYPE').inject({}) { |h, (k, v)| h[k.to_s] = v.split(','); h }
        current_fiscal_year   = get_aft_parameter_value('CURRENT_FISCAL_YEAR') # '2015'

        object_levels += %w(CAPA CAPC) unless cap_asset_allowed
        chart_code = get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)
        levels = get_kuali_business_objects('KFS-COA', 'ObjectLevel', "universityFiscalYear=#{current_fiscal_year}")
        object_codes = get_kuali_business_objects('KFS-COA', 'ObjectCode', "universityFiscalYear=#{current_fiscal_year}&chartOfAccountsCode=#{chart_code}")

        object_codes['org.kuali.kfs.coa.businessobject.ObjectCode'].delete_if do |oc_hash|
          !(object_levels & oc_hash['financialObjectLevelCode']).empty? ||
          !(object_sub_types & oc_hash['financialObjectSubTypeCode']).empty?
        end # D

        object_codes['org.kuali.kfs.coa.businessobject.ObjectCode'].keep_if do |oc_hash|
          !(object_types & oc_hash['financialObjectTypeCode']).empty? &&
          (if valid_object_levels_by_object_type.keys.any? { |k| oc_hash['financialObjectTypeCode'].include? k }
            valid_object_levels_by_object_type.values.any? { |valid_level|
              (valid_level & oc_hash['financialObjectLevelCode']).empty?
            }
          else
            true
          end)
        end # A

        levels['org.kuali.kfs.coa.businessobject.ObjectLevel'].delete_if { |oc_hash|
          !(object_consolidations & oc_hash['financialConsolidationObjectCode']).empty?
        } # D

        object_codes['org.kuali.kfs.coa.businessobject.ObjectCode'].keep_if { |code|
          levels['org.kuali.kfs.coa.businessobject.ObjectLevel'].any? do |level|
            !(level['financialObjectLevelCode'] & code['financialObjectLevelCode']).empty?
          end
        } # D

        object_codes['org.kuali.kfs.coa.businessobject.ObjectCode'].sample['financialObjectCode'][0]
      else
        nil
    end
  rescue RuntimeError => re
    nil
  end
  # This is simplified version of 'get_object_type_of_type'. For now, this is for PURAP.  Should re-factor to merge these 2 if possible.
  def get_object_code_of_type(type)
    current_fiscal_year   = get_aft_parameter_value('CURRENT_FISCAL_YEAR')
    chart_code = get_aft_parameter_value(ParameterConstants::DEFAULT_CHART_CODE)
    case type
      when 'Operating Expense'
        get_kuali_business_object('KFS-COA', 'ObjectCode', "universityFiscalYear=#{current_fiscal_year}&financialObjectSubTypeCode=OE&financialObjectTypeCode=EX&financialObjectLevelCode=SMAT&chartOfAccountsCode=#{chart_code}")['financialObjectCode'][0]
      when 'Capital Asset'
        fetch_random_capital_asset_object_code
      when 'Accounts Receivable Asset'
        get_kuali_business_object('KFS-COA', 'ObjectCode', "universityFiscalYear=#{current_fiscal_year}&financialObjectTypeCode=AS&financialObjectLevelCode=AROT&chartOfAccountsCode=#{chart_code}")['financialObjectCode'][0]
      when 'Income-Cash'
        get_kuali_business_object('KFS-COA', 'ObjectCode', "universityFiscalYear=#{current_fiscal_year}&financialObjectSubTypeCode=ID&financialObjectTypeCode=IN&financialObjectLevelCode=IDRV&chartOfAccountsCode=#{chart_code}")['financialObjectCode'][0]
      else
        nil
    end
  rescue RuntimeError => re
    nil
  end

  def get_commodity_of_type(type, sensitiveDataCode='ANIM')
    case type
      when 'Sensitive'
        get_kuali_business_object('KFS-VND','CommodityCode',"sensitiveDataCode=#{sensitiveDataCode}&active=true")['purchasingCommodityCode'].sample
      when 'Regular'
        get_kuali_business_object('KFS-VND','CommodityCode','sensitiveDataCode=NULL&active=true')['purchasingCommodityCode'].sample
      else
        nil
    end
  rescue RuntimeError => re
    nil
  end

  private

  def snakify(item)
    item.to_s[0]=='@' ? item : "@#{snake_case(item.to_s)}"
  end

end