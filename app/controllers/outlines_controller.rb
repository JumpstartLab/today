class OutlinesController < ApplicationController

  def index
    @outlines = Outline.all.group_by { |outline| outline.publish_date.year }
    @outlines.each do |year,outlines|
      @outlines[year] = outlines.group_by { |outline| outline.publish_date.month }
    end
  end

  def show
    redirect_to schedule_path(current_outline)
  end

  def new
    @outline = Outline.new(default_new_params)
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

  def default_new_params
    { publish_date: Time.now.to_date }.merge(outline_params)
  end

end
