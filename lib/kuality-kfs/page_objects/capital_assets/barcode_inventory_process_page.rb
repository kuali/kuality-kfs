class BarcodeInventoryProcessPage < KFSBasePage

  element(:add_csv_file) { |b| b.frm.file_field(name: 'uploadedFiles(csv)') }

  element(:file_identifier) { |b| b.frm.text_field(name: 'batchUpload.fileUserIdentifer') }

  #this is the add button
  action(:add_barcode_file) { |b| b.frm.button(title: 'Upload Batch File').click }

  element(:file_upload_description) { |b| b.frm.text_field(name: 'uploadDescription') }
end
