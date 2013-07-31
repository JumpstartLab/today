class ScheduleController < ApplicationController

  def show
    @schedule = Schedule.new(outline)
  end

  def outline
    Outline.find_by_publish_date(date_param) || MissingOutline.new(date_param)
  end

  def date_param

    if params[:date_string]
      DateTime.parse(params[:date_string]).to_date
    else
      DateTime.now.to_date
    end

  rescue
    nil
  end

end