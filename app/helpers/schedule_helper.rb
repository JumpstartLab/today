module ScheduleHelper

  def nav_date_format(date)
    date.strftime("%m/%d/%y")
  end

  def previous_link(outline)
    unless outline.is_a?(MissingOutline)
      # link_to nav_date_format(outline.publish_date), schedule_path(outline), class: "ss-navigateleft left schedule-previous"
      link_to "Back", schedule_path(outline), class: "ss-navigateleft left schedule-previous"
    else
      link_to "The Beginning", "#", class: "schedule-beginning"
    end
  end

  def next_link(outline)
    unless outline.is_a?(MissingOutline)
      # link_to nav_date_format(outline.publish_date), schedule_path(outline), class: "ss-navigateright right schedule-next"
      link_to "Forward", schedule_path(outline), class: "ss-navigateright right schedule-next"
    else
      link_to "The End", "#", class: "schedule-end"
    end
  end

end