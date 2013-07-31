module ScheduleHelper

  def previous_link(outline)
    unless outline.is_a?(MissingOutline)
      link_to outline.publish_date, schedule_path(outline), class: "ss-navigateleft left"
    else
      link_to "The Beginning", "#"
    end
  end

  def next_link(outline)
    unless outline.is_a?(MissingOutline)
      link_to outline.publish_date, schedule_path(outline), class: "ss-navigateright right"
    else
      link_to "The End", "#"
    end
  end

end