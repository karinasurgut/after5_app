module DealsHelper

  def deal_duration_for(deal)
  	if deal.start_date == deal.end_date
  		if deal.durations.any?
  			dd = deal.durations.first
  			if dd.all_day?
  				deal_duration = deal.start_date.strftime("%e %b") + ", all day"
  			else 
  				deal_duration = deal.start_date.strftime("%e %b") + " from " + dd.from_time.strftime("%l:%M %p").to_s.downcase! + " till " + dd.till_time.strftime("%l:%M %p").to_s.downcase! 
  			end
  		else
  			deal_duration = deal.start_date.strftime("%e %b")
  		end
  	else
	  if deal.end_date.nil?	|| (deal.end_date.to_date - Time.now.to_date).to_i > 0
	  	if (deal.start_date.to_date - Time.now.to_date).to_i > 0
	  		deal_duration = "Starts in " + pluralize((deal.start_date.to_date - Time.now.to_date).to_i, "day")
	  	else  
		  if deal.durations.any?
		    dd = deal.durations.first
		    weekdays = []
		    deal.durations.each do |d|
		      weekdays << Date::DAYNAMES[d.week_day][0..2]
		    end
		    if dd.all_day? && dd.from_time.nil?
		      deal_duration = "Every " + weekdays.join(", ") + ", all day"
		    else
		      deal_duration = "Every " + weekdays.join(", ") + " from " + dd.from_time.strftime("%l:%M %p").to_s.downcase! + " till " + dd.till_time.strftime("%l:%M %p").to_s.downcase! 
		    end
		  else
		  	deal_duration = "Ongoing"
		  end
		end
	  else
	  	if (deal.end_date.to_date - Time.now.to_date).to_i == 0
	  		deal_duration = "Ends today"
	  	else
	  		deal_duration = "This deal has passed"
	  	end
	  end
  	end
  	content_tag("h4", "#{deal_duration}", class: "deal-duration")
  end

end