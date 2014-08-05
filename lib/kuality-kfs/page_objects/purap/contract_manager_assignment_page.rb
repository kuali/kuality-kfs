class ContractManagerAssignmentPage < KFSBasePage

  # element(:organization_document_number) { |b| b.frm.text_field(name: 'document.documentHeader.organizationDocumentNumber') }
  action(:contract_manager) { |l=0, b| b.frm.text_field(name: "document.contractManagerAssignmentDetail[#{l}].contractManagerCode") }
  #tr where the requisition number exists is where the cm to fill in should be one td up/left
  element(:search_contract_manager_links) { | b| b.frm.buttons(name: /^methodToCall.performLookup.\(!!org.kuali.kfs.vnd.businessobject.ContractManager!!\)/m) }
  element(:contract_manager_table) { |b| b.frm.table(summary: 'Assign A Contract Manager') }

  # the index-1 is needed because it was filling in the wrong/next row
  action(:set_contract_manager) do |req_number, cm_number='10', b|
    catch :cm_set do
      b.frm.table(summary: 'Assign A Contract Manager')
           .rows
           .each_with_index do |row, index|
              if row.a(text: req_number).exists?
                b.contract_manager(index-1).set cm_number
                throw :cm_set
              end
           end
    end
  end
  #NEEDS TO 'BREAK' loop after finding value,

end