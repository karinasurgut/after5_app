module DealsHelper

  def deal_duration_for(deal)
	if deal.durations.any?
	  dd = deal.durations.first
	  weekdays = []
	  deal.durations.each do |d|
	  	weekdays << Date::DAYNAMES[d.week_day][0..2]
	  end
	  if dd.all_day? && dd.from_time.nil?
	    deal_duration = "Every " + weekdays.join(", ")
	  else
	    deal_duration = "Every " + weekdays.join(", ") + " from " + dd.from_time.strftime("%l:%M %p").to_s.downcase! + " till " + dd.till_time.strftime("%l:%M %p").to_s.downcase! 
	  end
	else
	  deal_duration = distance_in_time(deal.start_date, deal.end_date)
	end
    content_tag("h4", "#{deal_duration}", class: "deal-duration")
  end

  def distance_in_time(time1,time2)
  	dif = (time1.to_date - Time.now.to_date).to_i
  	if dif > 0
  	  "Starts in " + pluralize(dif, "day")
  	elsif dif == 0
  	  "Happening now"
  	else
  	  "Ends in " + pluralize((time2.to_date - Time.now.to_date).to_i, "day")
  	end
  end	
end