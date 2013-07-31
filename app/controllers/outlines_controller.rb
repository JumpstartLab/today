class OutlinesController < ApplicationController

  def index
    @outlines = Outline.all
  end

  def show
    @outline = current_outline
  end

  def new
    @outline = Outline.new
  end

  def create
    @outline = Outline.new(outline_params)

    if @outline.save
      redirect_to schedule_path(@outline)
    else
      render :new
    end
  end

  def edit
    @outline = current_outline
  end

  def update
    @outline = current_outline
    @outline.update_attributes(outline_params)

    if @outline.save
      redirect_to schedule_path(@outline)
    else
      render :edit
    end
  end

  private

  def current_outline
    Outline.find_by_publish_date(date_param)
  end

  def date_param
    DateTime.parse(params[:id]).to_date
  rescue
    nil
  end

  def outline_params
    params.require(:outline).permit(:title,:body,:publish_date)
  end

end
