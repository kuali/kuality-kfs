class ContractManagerAssignmentPage < KFSBasePage

      element(:organization_document_number) { |b| b.frm.text_field(name: 'document.documentHeader.organizationDocumentNumber') }
      element(:contract_manager) { |l=0, b| b.frm.text_field(name: "document.contractManagerAssignmentDetail[#{l}].contractManagerCode") }
      #tr where the requisition number exists is where the cm to fill in should be one td up/left

end