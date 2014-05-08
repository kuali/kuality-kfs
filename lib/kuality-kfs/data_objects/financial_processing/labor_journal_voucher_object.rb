class LaborJournalVoucherObject < JournalVoucherObject

  def build
    visit(MainPage).labor_journal_voucher
    on LaborJournalVoucherPage do |page|
      page.expand_all
      page.description.focus
      page.alert.ok if page.alert.exists? # Because, y'know, sometimes it doesn't actually come up...
      fill_out page, :description, :organization_document_number, :explanation
    end
  end

end