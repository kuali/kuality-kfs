class PersonLookup < Lookups

  element(:kcperson_id) { |b| b.frm.text_field(name:'personId') }

  element(:principal_name) { |b| b.frm.text_field(id: 'principalName') }
  element(:principal_id) { |b| b.frm.text_field(id: 'principalId') }
  element(:employee_id) { |b| b.frm.text_field(id: 'employeeId') }

  alias_method :select_person, :check_item

  value(:returned_full_names) { |b|
    names=[]
    b.results_table.tbody.trs.each { |row|
                                      names << row[2].text.strip
                                   }
    names.delete_if { |name| name=='' }
    names
  }

    value(:returned_first_employee_id) { |b|
      employee_ids = []
      b.results_table.tbody.trs.each { |row| employee_ids << row[7].text.strip }
      employee_ids.delete_if { |employee_id| employee_id==''}
      employee_ids.first
    }

end