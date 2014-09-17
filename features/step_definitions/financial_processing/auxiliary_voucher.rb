When /^I start an empty Auxiliary Voucher document$/ do
  @auxiliary_voucher = create AuxiliaryVoucherObject, initial_lines: []
end
