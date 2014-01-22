class SchedulePage < BasePage

  tiny_buttons
  tab_buttons
  error_messages

  action(:run_job) { |b| b.frm.button(name: 'methodToCall.runJob').click }
  value(:job_status) { |p| p.job_info_table.row(text: /Job Status:/).cell(index: 1).text }

  private

  element(:job_info_table) { |b| b.frm.div(id: 'tab-JobInfo-div').table }

end