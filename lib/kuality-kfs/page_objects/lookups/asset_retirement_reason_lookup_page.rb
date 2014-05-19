class AssetRetirementReasonLookupPage < Lookups

  active_radios

 element(:retirement_reason_code) { |b| b.frm.text_field(name: 'retirementReasonCode') }
 element(:retirement_reason_name) { |b| b.frm.text_field(name: 'retirementReasonName') }

 element(:retirement_indicator_yes) { |b| b.frm.radio(id: 'retirementReasonRestrictionIndicatorYes') }
 element(:retirement_indicator_no) { |b| b.frm.radio(name: 'retirementReasonRestrictionIndicatorNo') }
 element(:retirement_indicator_both) { |b| b.frm.radio(name: 'retirementReasonRestrictionIndicatorBoth') }

end