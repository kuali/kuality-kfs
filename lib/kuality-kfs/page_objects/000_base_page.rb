class BasePage < PageFactory

  include Utilities
  include GlobalConfig

  # These constants can be used with switches to add modularity to object create methods.
  KNOWN_BUTTONS = {
    save:              'save',
    submit:            'submit',
    blanket_approve:   'blanket approve',
    close:             'close',
    cancel:            'cancel',
    reload:            'reload',
    copy:              'Copy current document',
    approve:           'approve',
    disapprove:        'disapprove',
    send_notification: 'send notification',
    recall:            'Recall current document',
    error_correction:  'error correction',
    fyi:               'fyi'
  }

  def self.available_buttons
    KNOWN_BUTTONS.values.join('|')
  end

  action(:use_new_tab) { |b| b.windows.last.use }
  action(:return_to_portal) { |b| b.portal_window.use }
  action(:close_extra_windows) { |b| b.close_children if b.windows.length > 1 }
  action(:close_children) { |b| b.windows[0].use; b.windows[1..-1].each{ |w| w.close} }
  action(:close_parents) { |b| b.windows[0..-2].each{ |w| w.close} }
  element(:logout_button) { |b| b.button(title: 'Click to logout.') }
  action(:logout) { |b| b.logout_button.click }

  element(:portal_window) { |b| b.windows(title: 'Kuali Portal Index')[0] }

  action(:form_tab) { |name, b| b.frm.h2(text: /#{name}/) }
  action(:form_status) { |name, b| b.form_tab(name).text[/(?<=\()\w+/] }

  action(:doc_search) { |b| b.img(alt: 'doc search').click }
  action(:action_list) { |b| b.img(alt: 'action list').click }
  class << self

    def glbl(*titles)
      titles.each do |title|
        action(damballa(title)) { |b| b.frm.button(class: 'globalbuttons', title: title).when_present.click }
      end
    end

    def document_header_elements
      element(:doc_title_element) { |b| b.frm.div(id: /^headerarea/).h1 }
      value(:doc_title) { |b| b.doc_title_element.text }
      element(:headerinfo_table) { |b| b.frm.div(id: /^headerarea/).table(class: 'headerinfo') }
      value(:document_id) { |p| p.headerinfo_table[0][1].text }
      alias_method :doc_nbr, :document_id
      value(:document_status) { |p| p.headerinfo_table[0][3].text }
      value(:initiator) { |p| p.headerinfo_table[1][1].text }
      alias_method :disposition, :initiator
      value(:last_updated) {|p| p.headerinfo_table[1][3].text }
      alias_method :created, :last_updated
      value(:requisition_id) { |p| p.headerinfo_table[2][1].text }
      value(:requisition_status) { |p| p.headerinfo_table[2][3].text }
      alias_method :po_doc_status, :requisition_status
      value(:po_number) { |p| p.headerinfo_table[2][1].text }
      value(:preq_id) { |p| p.headerinfo_table[2][1].text }
      value(:app_doc_status) { |p| p.headerinfo_table[2][3].text }
      # TODO : in maint page 'header', in AssetManualPayment page 'headerarea'.  Move to base ?
      value(:header_title) { |b| b.frm.div(id: /^header/).text }
    end

    def description_field
      element(:doc_overview_info) { |b| b.frm.table(class: 'datatable', summary: 'view/edit document overview information') }
      element(:description) { |b| b.frm.text_field(name: 'document.documentHeader.documentDescription') }
      value(:readonly_description) { |b| b.doc_overview_info.rows[0].tds[0].text.strip }
      element(:explanation) { |b| b.frm.textarea(name: 'document.documentHeader.explanation') }
      element(:organization_document_number) { |b| b.frm.text_field(name: 'document.documentHeader.organizationDocumentNumber') }
    end

    def organization_facets
      element(:organization_name) { |b| b.frm.text_field(name: 'organizationName') }
      element(:organization_code) { |b| b.frm.text_field(name: 'organizationCode') }
      element(:organization_reference_id) { |b| b.frm.text_field(name: 'organizationReferenceId') }
    end

    def global_buttons
      glbl 'blanket approve', 'close', 'cancel', 'reload', 'copy', 'Copy current document',
           'approve', 'disapprove', 'submit', 'Send Notification', 'Recall current document','fyi', 'Calculate'
      action(:save) { |b| b.frm.button(name: 'methodToCall.save', title: 'save').click }
      action(:error_correction) { |b| b.frm.button(name: 'methodToCall.correct', title: 'Create error correction document from current document').click }
      action(:edit) { |b| b.edit_button.click }
      element(:edit_button) { |b| b.frm.button(name: 'methodToCall.editOrVersion') }
      action(:delete_selected) { |b| b.frm.button(class: 'globalbuttons', name: 'methodToCall.deletePerson').click }
      element(:send_button) { |b| b.frm.button(class: 'globalbuttons', name: 'methodToCall.sendNotification', title: 'send') }
      action(:send_fyi) { |b| b.send_button.click }
      action(:void_order) { |b| b.frm.button(title: 'Void PO').click }

    end

    def tab_buttons
      action(:main_menu_tab) { |b| b.link(title: 'Main Menu').click }
      action(:maintenance_tab) { |b| b.link(title: 'Maintenance').click }
      action(:administration_tab) { |b| b.link(title: 'Administration').click }

      action(:expand_all) { |b| b.frm.button(name: 'methodToCall.showAllTabs').click }
      action(:collapse_all) { |b| b.frm.button(name: 'methodToCall.hideAllTabs').click }
    end

    def tiny_buttons
      action(:search) { |b| b.frm.button(title: 'search', value: 'search').click }
      action(:clear) { |b| b.frm.button(name: 'methodToCall.clearValues').click }
      action(:cancel_button) { |b| b.frm.link(title: 'cancel').click }
      action(:yes) { |b| b.frm.button(name: 'methodToCall.rejectYes').click }
      action(:no) {|b| b.frm.button(name: 'methodToCall.rejectNo').click }
      action(:add) { |b| b.frm.button(name: 'methodToCall.addNotificationRecipient.anchor').click }

      action(:add_multiple_accounting_lines) { |b| b.frm.button(title: 'Multiple Value Search on Account').click }
    end

    def search_results_table
      element(:header_row) { |b| b.results_table.th(class: 'sortable').parent.cells.collect { |x| snake_case(x.text.strip).to_sym } }
      action(:column_index) { |col, b| b.header_row.index(col) }
      element(:results_table) { |b| b.frm.table(id: 'row') }
      action(:open_item_via_text) { |match, text, p| p.item_row(match).link(text: text).click; p.use_new_tab; p.close_parents }
      element(:result_item) { |match, p| p.results_table.row(text: /#{match}/m) }
      action(:edit_item) { |match, p| p.results_table.row(text: /#{match}/m).link(text: 'edit').click; p.use_new_tab; p.close_parents }
      alias_method :edit_person, :edit_item

      action(:edit_first_item) { |b| b.frm.link(text: 'edit').click; b.use_new_tab; b.close_parents }

      action(:item_row) { |match, b| b.results_table.row(text: /#{match}/m) }
      alias_method :result_item, :item_row
      # Note: Use this when you need to click the "open" link on the target row
      action(:open) { |match, p| p.results_table.row(text: /#{match}/m).link(text: 'open').click; p.use_new_tab; p.close_parents }
      # Note: Use this when the link itself is the text you want to match
      action(:open_item) { |match, b| b.item_row(match).link(text: /#{match}/).click; b.use_new_tab; b.close_parents }
      action(:delete_item) { |match, p| p.item_row(match).link(text: 'delete').click; p.use_new_tab; p.close_parents }

      action(:return_value) { |match, p| p.item_row(match).link(text: 'return value').click }
      action(:select_item) { |match, p| p.item_row(match).link(text: 'select').click }
      action(:return_random) { |b| b.return_value_links[rand(b.return_value_links.length)].click; b.use_new_tab; b.close_parents }
      action(:return_random_row) { |b| b.results_table[rand(b.results_table.to_a.length - 1) + 1] }
      element(:return_value_links) { |b| b.results_table.links(text: 'return value') }

      action(:search_and_return_random) { |b| b.search; b.return_random }

      action(:select_all_rows_from_this_page) { |b| b.frm.img(title: 'Select all rows from this page').click }
      action(:return_selected_results) { |b| b.frm.button(title: 'Return selected results').click }

      p_value(:docs_with_status) { |status, b| array = []; (b.results_table.rows.find_all{|row| row[1].text==status}).each { |row| array << row[0].text }; array }

      action(:select_monthly_item){ |obj_code, monthly_number, p| p.frm.link(href: /financialObjectCode=#{obj_code}(.*?)universityFiscalPeriodCode=#{monthly_number}/).click; p.use_new_tab; p.close_parents }
      action(:single_entry_monthly_item){ |monthly_number, p| p.frm.link(href: /universityFiscalPeriodCode=#{monthly_number}/).click; p.use_new_tab; p.close_parents }

      action(:select_this_link_without_frm) { |match, b| b.table(id: 'row').link(text: match).when_present.click }

      action(:sort_results_by) { |title_text, b| b.results_table.link(text: title_text).when_present.click }

      value(:no_result_table_returned) { |b| b.frm.divs(id: 'lookup')[0].parent.text.match /No values match this search/m }
      alias_method :no_result_table_returned?, :no_result_table_returned

      value(:no_results_found) { |b| b.frm.divs(id: 'lookup')[0].parent.text.match /There were no results found/m }
      alias_method :no_results_found?, :no_results_found

      #action(:find_header_index) { |text_match, b| b.frm.results_table.ths.each { |t| puts t.text.to_s + 'la la la la la' + i.to_s; i += 1  }
      value(:get_cell_value_by_index) { |index_number, b| b.results_table.td(index: index_number).text }
      
      action(:search_then) {|action, b| b.search; action.each_pair{|a, o| o.nil? ? b.send(a) : b.send(a, o)} }
      action(:process) { |match, p| p.item_row(match).link(text: 'process').click ; p.use_new_tab; p.close_parents}
    end

    def general_ledger_pending_entries
      element(:glpe_results_table) { |b| b.frm.div(id:'tab-GeneralLedgerPendingEntries-div').table(summary: 'view/edit pending entries') }
      action(:show_glpe) { |b| b.frm.button(title: 'open General Ledger Pending Entries').when_present.click }
    end

    def labor_ledger_pending_entries
      element(:llpe_results_table) { |b| b.frm.div(id:'tab-LaborLedgerPendingEntries-div').table }
      action(:show_llpe) { |b| b.frm.button(title: 'open Labor Ledger Pending Entries').when_present.click }
    end

    def notes_and_attachments
      # == Notes and Attachments Tab ==
      element(:show_notes_and_attachments_button) { |b| b.frm.input(id: 'tab-NotesandAttachments-imageToggle') }
      alias_method :hide_notes_and_attachments_button, :show_notes_and_attachments_button
      element(:notes_and_attachments_count) { |b| b.show_notes_and_attachments_button.title.gsub(/.*\((\d+)\)$/, '\1').to_i }
      action(:show_notes_and_attachments) { |b| b.show_notes_and_attachments_button.click }
      action(:hide_notes_and_attachments) { |b| b.hide_notes_and_attachments.click }
      element(:note_text) { |b| b.frm.textarea(name: 'newNote.noteText') }
      action(:add_note) { |b| b.frm.button(title: 'Add a Note').click }
      action(:delete_note) { |l=0,b| b.frm.button(name: "methodToCall.deleteBONote.line#{l}").click }
      action(:send_note_fyi) { |l=0,b| b.frm.button(name: "methodToCall.sendNoteWorkflowNotification.line#{l}").click }
      action(:notification_recipient) { |l=0,b| b.frm.text_field(id: "document.note[#{l}].adHocRouteRecipient.id") }
      element(:notes_tab) { |b| b.div(id: 'tab-NotesandAttachments-div') }
      element(:attachment_type) { |b| b.frm.select(name: 'newNote.attachment.attachmentTypeCode') }

      element(:attach_notes_file) { |b| b.frm.file_field(name: 'attachmentFile') }
      element(:notes_table) { |b| b.frm.table(summary: 'view/add notes') }

      #viewing document where changes have been made
      element(:account_line_changed_text) { |b| b.td(class: 'datacell center', text: /^Accounting Line changed from:/) }
      element(:send_to_vendor) { |b| b.frm.select(name: 'newNote.noteTopicText') }
      element(:attach_notes_file_1) { |b| b.download_file_button(0) } # FIXME: Remove once all references are gone.
      element(:download_file_button) { |l=0, b| b.frm.button(name: "methodToCall.downloadBOAttachment.attachment[#{l}]") }
      action(:download_file) { |l=0, b| b.download_file(l).click }
      alias_method :submitted_attached_file_file, :download_file
      value(:submitted_note_text) { |l=0, b| b.notes_table[2+l][b.notes_table.keyed_column_index(:note_text)].text }
      value(:submitted_author) { |l=0, b| b.notes_table[2+l][b.notes_table.keyed_column_index(:author)].text }
      value(:submitted_posted_timestamp) { |l=0, b| b.notes_table[2+l][b.notes_table.keyed_column_index(:posted_timestamp)].text }
      value(:submitted_attached_file_name) { |l=0, b| b.notes_table[2+l][b.notes_table.keyed_column_index(:attached_file)].text }

      # == Notes Tab ==
      element(:show_ro_notes_button) { |b| b.frm.input(id: 'tab-Notes-imageToggle') }
      alias_method :hide_ro_notes_button, :show_ro_notes_button
      element(:ro_notes_count) { |b| b.frm.inputs(id: /^tab-\d+-imageToggle$/m, alt: /^(close|open) Notes$/m).length }
      action(:show_ro_notes) { |b| b.show_ro_notes_button.click }
      action(:hide_ro_notes) { |b| b.hide_ro_notes_button.click }

      element(:ro_notes_tab) { |b| b.frm.div(id: 'tab-Notes-div').table }
      element(:ro_note) { |i=0, b| b.ro_notes_tab[i].tables(class: 'datatable')[1] }
      value(:ro_note_note_text) { |i=0, b| b.ro_note(i).span(id: "boNotes[#{i}].noteText.div").text.strip }
      value(:ro_note_posted_datetime_stamp) { |i=0, b| b.ro_note(i).span(id: "boNotes[#{i}].notePostedTimestamp.div").text.strip }
      value(:ro_note_principal_name) { |i=0, b| b.ro_note(i).span(id: "boNotes[#{i}].authorUniversal.principalName.div").text.strip }
      element(:ro_note_attached_file) { |i=0, b| b.ro_note(i).tr(text: /Attached File/m).td }
      value(:ro_note_has_attached_file?) { |i=0, b| b.ro_note_attached_file(i).link(text: /Download Attachment/m).exists? }

    end

    def route_log
      element(:route_log_iframe) { |b| b.frm.iframe(name: 'routeLogIFrame') }
      element(:show_route_log_button) { |b| b.frm.div(id: 'workarea').input(id: 'tab-RouteLog-imageToggle') }
      alias_method :hide_route_log_button, :show_route_log_button
      value(:route_log_shown?) { |b| b.show_route_log_button.title.match(/close Route Log/m) }
      value(:route_log_hidden?) { |b| b.show_route_log_button.title.match(/open Route Log/m) }
      action(:show_route_log) { |b| b.show_route_log_button.click }
      alias_method :hide_route_log, :show_route_log
      element(:refresh_route_log_button) { |b| b.route_log_iframe.div(class: 'lookupcreatenew', title: 'Refresh').image(alt: 'refresh') }
      action(:refresh_route_log) { |b| b.refresh_route_log_button.click }

      element(:actions_taken_table) { |b| b.route_log_iframe.div(id: 'tab-ActionsTaken-div').table }
      value(:actions_taken) { |b| (b.actions_taken_table.rows.collect{ |row| row[1].text }.compact.uniq).reject{ |action| action==''} }
      element(:pnd_act_req_table) { |b| b.route_log_iframe.div(id: 'tab-PendingActionRequests-div').table }

      element(:show_pending_action_requests_button) { |b| b.route_log_iframe.input(id: 'tab-PendingActionRequests-imageToggle') }
      alias_method :hide_pending_action_requests_button, :show_pending_action_requests_button
      value(:pending_action_requests_shown?) { |b| b.show_pending_action_requests_button.title.match(/close Pending Action Requests/m) }
      value(:pending_action_requests_hidden?) { |b| b.show_pending_action_requests_button.title.match(/open Pending Action Requests/m) }
      action(:show_pending_action_requests) { |b| b.show_pending_action_requests_button.click }
      alias_method :hide_pending_action_requests, :show_pending_action_requests

      element(:show_pending_action_requests_in_action_list_button) { |b| b.pnd_act_req_table.image(title: 'show') }
      element(:hide_pending_action_requests_in_action_list_button) { |b| b.pnd_act_req_table.image(title: 'hide') }
      value(:pending_action_requests_in_action_list_shown?) { |b| b.hide_pending_action_requests_in_action_list_button.exists? }
      value(:pending_action_requests_in_action_list_hidden?) { |b| b.show_pending_action_requests_in_action_list_button.exists? }
      action(:show_pending_action_requests_in_action_list) { |b| b.show_pending_action_requests_in_action_list_button.click }
      action(:hide_pending_action_requests_in_action_list) { |b| b.hide_pending_action_requests_in_action_list_button.click }

      value(:pnd_act_req_table_action) { |r=1, b| b.pnd_act_req_table[r][b.pnd_act_req_table.keyed_column_index(:action)] }
      value(:pnd_act_req_table_requested_of) { |r=1, b| b.pnd_act_req_table[r][b.pnd_act_req_table.keyed_column_index(:requested_of)] }
      value(:pnd_act_req_table_time_date) { |r=1, b| b.pnd_act_req_table[r][b.pnd_act_req_table.keyed_column_index(:time_date)] }
      value(:pnd_act_req_table_annotation) { |r=1, b| b.pnd_act_req_table[r][b.pnd_act_req_table.keyed_column_index(:annotation)] }

      element(:pnd_act_req_table_sub) { |b| b.pnd_act_req_table.table }
      element(:pnd_act_req_table_multi) { |b| b.pnd_act_req_table_sub.table }
      value(:pnd_act_req_table_multi_action) { |r=1, b| b.pnd_act_req_table_multi[r][b.pnd_act_req_table_multi.keyed_column_index(:action)] }
      value(:pnd_act_req_table_multi_requested_of) { |r=1, b| b.pnd_act_req_table_multi[r][b.pnd_act_req_table_multi.keyed_column_index(:requested_of)] }
      value(:pnd_act_req_table_multi_time_date) { |r=1, b| b.pnd_act_req_table_multi[r][b.pnd_act_req_table_multi.keyed_column_index(:time_date)] }
      value(:pnd_act_req_table_multi_annotation) { |r=1, b| b.pnd_act_req_table_multi[r][b.pnd_act_req_table_multi.keyed_column_index(:annotation)] }

      value(:action_requests) { |b| (b.pnd_act_req_table.rows.collect{ |row| row[1].text}).reject{ |action| action==''} }
      element(:show_future_action_requests_button) { |b| b.route_log_iframe.link(href: /showFuture=true&showNotes=false/m) }
      action(:show_future_action_requests) { |b| b.show_future_action_requests_button.click }
      element(:hide_future_action_requests_button) { |b| b.route_log_iframe.link(href: /showFuture=false&showNotes=false/m) }
      action(:hide_future_action_requests) { |b| b.hide_future_action_requests_button.click }
      element(:future_actions_table) { |b| b.route_log_iframe.div(id: 'tab-FutureActionRequests-div').table }
      value(:requested_action_for) { |name, b| b.future_actions_table.tr(text: /#{name}/).td(index: 2).text }
      action(:show_multiple) { |b| b.pnd_act_req_table[1][0].a.image(title: 'show').click }
      action(:multiple_link_first_approver){ |b| b.pnd_act_req_table[2].table.table[1][2].a.click}

      value(:new_user) do |b|
        new_user = ''
        if b.frm.div(id: 'tab-Overview-div').tables[0][1].text.include?('Principal Name:')
          new_user = b.frm.div(id: 'tab-Overview-div').tables[0][1].tds[0].text
        else
          # TODO : this is for group.  any other alternative ?
          mbr_tr = b.frm.select(id: 'document.members[0].memberTypeCode').parent.parent.parent
          new_user = mbr_tr[4].text
        end
        new_user
      end

      value(:pending_action_annotation) { |i=0, b| b.pnd_act_req_table[(1+(i*2))][4].text }
      action(:first_pending_approve) do |b|
        (1..b.pnd_act_req_table.rows.length - 2).each do |i|
          if b.pnd_act_req_table[i][1].text.include?('APPROVE')
            b.pnd_act_req_table[i][2].links[0].click
          end
        end

      end
    end

    # Gathers all errors on the page and puts them in an array called "errors"
    def error_messages
      value(:errors) do |b|
        errs = []
        b.left_errmsg_tabs.each do |div|
          if div.div.div.exist?
            errs << div.div.divs.collect{ |div| div.text }
          elsif div.div.exist?
            errs << div.divs.collect{ |div| div.text unless div.text == '' }.compact
          elsif div.li.exist?
            errs << div.lis.collect{ |li| li.text }
          end
        end
        b.left_errmsg.each do |div|
          if div.div.div.exist?
            errs << div.div.divs.collect{ |div| div.text }
          elsif div.li.exist?
            errs << div.lis.collect{ |li| li.text }
          end
        end
        errs.flatten
      end
      element(:left_errmsg_tabs) { |b| b.frm.divs(class: 'left-errmsg-tab') }
      element(:left_errmsg) { |b| b.frm.divs(class: 'left-errmsg') }
      value(:left_errmsg_text) { |b| b.left_errmsg.collect {|m| m.text.split("\n")}.flatten }
      element(:error_messages_div) { |b| b.frm.div(class: 'error') }
      element(:error_message_of) { |error_message, b| b.frm.div(text: 'Errors found in this Section:').div(text: error_message) }
    end

    def validation_elements
      element(:validation_button) { |b| b.frm.button(name: 'methodToCall.activate') }
      action(:show_data_validation) { |b| b.frm.button(id: 'tab-DataValidation-imageToggle').click; b.validation_button.wait_until_present }
      action(:turn_on_validation) { |b| b.validation_button.click; b.special_review_button.wait_until_present }
      element(:validation_errors_and_warnings) { |b| errs = []; b.validation_err_war_fields.each { |field| errs << field.html[/(?<=>).*(?=<)/] }; errs }
      element(:validation_err_war_fields) { |b| b.frm.tds(width: '94%') }
    end

    # ========
    private
    # ========

    def links(*links_text)
      links_text.each { |link| elementate(:link, link) }
    end

    def buttons(*buttons_text)
      buttons_text.each { |button| elementate(:button, button) }
    end

    # Use this to define methods to click on the green
    # buttons on the page, all of which can be identified
    # by the title tag. The method takes a hash, where the key
    # will become the method name, and the value is the string
    # that matches the green button's link title tag.
    def green_buttons(links={})
      links.each_pair do |name, title|
        action(name) { |b| b.frm.link(title: title).click }
      end
    end

    # A helper method that converts the passed string into snake case. See the StringFactory
    # module for more info.
    #
    def damballa(text)
      StringFactory::damballa(text)
    end

    def elementate(type, text)
      identifiers={:link=>:text, :button=>:value}
      el_name=damballa("#{text}_#{type}")
      act_name=damballa(text)
      element(el_name) { |b| b.frm.send(type, identifiers[type]=>text) }
      action(act_name) { |b| b.frm.send(type, identifiers[type]=>text).click }
    end

    # Used for getting rid of the space in the full name
    def nsp(string)
      string.gsub(' ', '')
    end

    # Used to add an extra space in the full name (because some
    # elements have that, annoyingly!)
    def twospace(string)
      string.gsub(' ', '  ')
    end

  end # self

end # BasePage