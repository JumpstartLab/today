class ScheduleController < ApplicationController

  def show
    @schedule = Schedule.new(outline)
  end

  def outline
    Outline.find_by_publish_date(date_param) || Outline.today || MissingOutline.new
  end

  def date_param
    DateTime.parse(params[:date_string]).to_date
  rescue
    nil
  end

end