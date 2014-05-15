class LedgerBalanceLookupPage < Lookups
  fiscal_year_facets
  element(:monthly_boxes) { |b| b.frm.checkboxes(name: /^selectedObjId/m) }
  element(:month_box) { |month="#{Date::MONTHNAMES[Date.today.month]}", b| b.frm.checkbox(name: /^selectedObjId/m, title: "#{month}") }

  element(:check_first_month) do |b|
    b.monthly_boxes.each do |cb|
      # check box for $0 will be disabled
      if cb.enabled?
        cb.set
        break
      end
    end
  end

end
