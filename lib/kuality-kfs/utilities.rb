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
    klass.to_s.gsub(/(?<=[a-z])(?=[A-Z])/, ' ').gsub(/Object$/, '')
  end

  def object_class_for(document)
    Kernel.const_get("#{snake_case(document).to_s.split('_').map(&:capitalize).join('')}Object")
  end

  def page_class_for(document)
    Kernel.const_get("#{snake_case(document).to_s.split('_').map(&:capitalize).join('')}Page")
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
      when 'YES', 'ON'
        :set
      when 'NO', 'OFF'
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

  private

  def snakify(item)
    item.to_s[0]=='@' ? item : "@#{snake_case(item.to_s)}"
  end

end