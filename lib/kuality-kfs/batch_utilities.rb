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

  def run_unscheduled_job(job_name, wait_for_completion)
    @browser.goto "#{$base_url}batchModify.do?methodToCall=start&name=#{job_name}&group=unscheduled"
    on SchedulePage do |page|
      page.run_job
      if wait_for_completion == true
        x = 0
        while x < 2
          break if (page.job_status =~ /Succeeded/) == 0
          sleep 5
          page.refresh
          x += 1
        end
      end
    end
  end

end
