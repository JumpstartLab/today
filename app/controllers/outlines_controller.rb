class OutlinesController < ApplicationController

  before_action :require_login, except: [ :index, :show ]

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

  def destroy
    outline_param = current_outline.to_param
    current_outline.delete
    redirect_to schedule_path(outline_param)
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
    require './lib/calendar'

    outline_date = DateTime.parse(outline_params[:publish_date]).to_date

    feed = Calendar.new.get
    entries = feed.entries(start_date: outline_date).sort_by { |e| e.start_date }
    body = entries.map {|entry| "## #{entry} "}.join("\n")

    {
      title: outline_date.strftime("%y%m%d"),
      publish_date: outline_date,
      body: body
    }.merge(outline_params)
  end

end
