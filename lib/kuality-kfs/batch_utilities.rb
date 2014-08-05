module BatchUtilities

  def run_nightly_out(wait_for_completion = false)
    run_unscheduled_job('nightlyOutJob', wait_for_completion)
  end

  def run_poster(wait_for_completion = false)
    run_unscheduled_job('posterJob', wait_for_completion)
  end

  def run_scrubber(wait_for_completion = false)
    run_unscheduled_job('scrubberJob', wait_for_completion)
  end

  def run_unscheduled_job(job_name, wait_for_completion, max_retries=12)
    @browser.goto "#{$base_url}batchModify.do?methodToCall=start&name=#{job_name}&group=unscheduled"
    on SchedulePage do |page|
      page.run_job
      if wait_for_completion == true
        x = 0
        while x < max_retries # Hell, let's give it a whole minute if it needs it.
          break if (page.job_status =~ /Succeeded/) == 0
          sleep 5
          page.refresh
          x += 1
        end
      end
    end
  end

  def run_unscheduled_job_until(job_name, seconds, refresh_rate=2)
    refresh_attempts = (seconds.to_i/refresh_rate.to_i).ceil
    @browser.goto "#{$base_url}batchModify.do?methodToCall=start&name=#{job_name}&group=unscheduled"
    on SchedulePage do |page|
      page.run_job
      x = 0
      while x < refresh_attempts
        break if (page.job_status =~ /Succeeded/) == 0
        sleep refresh_rate.to_i
        page.refresh
        x += 1
      end
    end
  end

  # TODO : Following batch jobs are commented out for testing
  # FIXME: Why? This seems wrong for the master branch...

  def run_auto_approve_preq(wait_for_completion = false)
    run_unscheduled_job('autoApprovePaymentRequestsJob', wait_for_completion, 120)
  end

  def run_electronic_invoice_extract(wait_for_completion = false)
    warn 'Would have run #run_electronic_invoice_extract'
    #run_unscheduled_job('electronicInvoiceExtractJob', wait_for_completion)
  end

  def run_pur_pre_disburse_extract(wait_for_completion = false)
    warn 'Would have run #run_pur_pre_disburse_extract'
    #run_unscheduled_job('purchasingPreDisbursementExtractJob', wait_for_completion)
  end

  def run_pur_pre_disburse_immediate_extract(wait_for_completion = false)
    warn 'Would have run #run_pur_pre_disburse_immediate_extract'
    #run_unscheduled_job('purchasingPreDisbursementImmediatesExtractJob', wait_for_completion)
  end

  def run_auto_close_recurring_order(wait_for_completion = false)
    warn 'Would have run #run_auto_close_recurring_order'
    #run_unscheduled_job('autoCloseRecurringOrdersJob', wait_for_completion)
  end

  def run_pdp_load_payment(wait_for_completion = false)
    warn 'Would have run #run_pdp_load_payment'
    #run_unscheduled_job('pdpLoadPaymentsJob', wait_for_completion)
  end

  def run_pdp_extract_ach_payment(wait_for_completion = false)
    warn 'Would have run #run_pdp_extract_ach_payment'
    #run_unscheduled_job('pdpExtractAchPaymentsJob', wait_for_completion)
  end

  def run_pdp_extract_check(wait_for_completion = false)
    warn 'Would have run #run_pdp_extract_check'
    #run_unscheduled_job('pdpExtractChecksJob', wait_for_completion)
  end

  def run_pdp_extract_canceled_check(wait_for_completion = false)
    warn 'Would have run #run_pdp_extract_canceled_check'
    #run_unscheduled_job('pdpExtractCanceledChecksJob', wait_for_completion)
  end

  def run_pdp_send_ach_advice_notification(wait_for_completion = false)
    warn 'Would have run #run_pdp_send_ach_advice_notification'
    #run_unscheduled_job('pdpSendAchAdviceNotificationsJob', wait_for_completion)
  end

  def run_pdp_cancel_and_paid(wait_for_completion = false)
    warn 'Would have run #run_pdp_cancel_and_paid'
    #run_unscheduled_job('processPdpCancelsAndPaidJob', wait_for_completion)
  end

  def run_pdp_extract_gl_transaction(wait_for_completion = false)
    warn 'Would have run #run_pdp_extract_gl_transaction'
    #run_unscheduled_job('pdpExtractGlTransactionsStepJob', wait_for_completion)
  end

  def run_pdp_load_fed_reserve_bank_data(wait_for_completion = false)
    warn 'Would have run #run_pdp_load_fed_reserve_bank_data'
    #run_unscheduled_job('pdpLoadFederalReserveBankDataJob', wait_for_completion)
  end

  def run_pdp_clear_pending_transaction(wait_for_completion = false)
    warn 'Would have run #run_pdp_clear_pending_transaction'
    #run_unscheduled_job('pdpClearPendingTransactionsJob', wait_for_completion)
  end

  def run_labor_enterprise_feed(wait_for_completion = false)
    run_unscheduled_job('laborEnterpriseFeedJob', wait_for_completion)
  end

  def run_labor_nightly_out(wait_for_completion = false)
    run_unscheduled_job('laborNightlyOutJob', wait_for_completion)
  end

  def run_labor_scrubber(wait_for_completion = false)
    run_unscheduled_job('laborScrubberJob', wait_for_completion)
  end

  def run_labor_poster(wait_for_completion = false)
    run_unscheduled_job('laborPosterJob', wait_for_completion)
  end

  def run_labor_balance(wait_for_completion = false)
    run_unscheduled_job('laborBalancingJob', wait_for_completion)
  end

  def run_labor_feed(wait_for_completion = false)
    run_unscheduled_job('laborFeedJob', wait_for_completion)
  end

  def run_labor_clear_pending_entries(wait_for_completion = false)
    run_unscheduled_job('clearLaborPendingEntriesJob', wait_for_completion)
  end

  def run_nightly_out(wait_for_completion = false)
    run_unscheduled_job('nightlyOutJob', wait_for_completion)
  end

  def run_poster(wait_for_completion = false)
    run_unscheduled_job('posterJob', wait_for_completion)
  end

  def run_clear_pending_entries(wait_for_completion = false)
    run_unscheduled_job('clearPendingEntriesJob', wait_for_completion)
  end

  def run_cab_extract(wait_for_completion = false)
    run_unscheduled_job('cabExtractJob', wait_for_completion)
  end


end
