class ScheduleController < ApplicationController

  def show
    @schedule = Schedule.new(outline)
  end

  def outline
    Outline.find_by_id(params[:id]) || Outline.today || MissingOutline.new
  end

end