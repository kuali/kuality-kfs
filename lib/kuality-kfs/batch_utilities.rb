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
  def run_auto_approve_preq(wait_for_completion = false)
    run_unscheduled_job('autoApprovePaymentRequestsJob', wait_for_completion, 120)
  end

  def run_fax_pending_doc(wait_for_completion = false)
    run_unscheduled_job('faxPendingDocumentJob', wait_for_completion)
  end

end
