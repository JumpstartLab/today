class OutlinesController < ApplicationController

  helper_method :current_outline

  def index
    @outlines = Outline.all
  end

  def show
    @outline = Outline.find(params[:id])
  end

  def today
    @outline = current_outline
    render :show
  end

  def new
    @outline = Outline.new
  end

  def create
    @outline = Outline.new(outline_params)

    if @outline.save
      redirect_to outline_path(@outline)
    else
      render :new
    end
  end

  def edit
    @outline = Outline.find(params[:id])
  end

  def update
    @outline = Outline.find(params[:id])
    @outline.update_attributes(outline_params)

    if @outline.save
      redirect_to outline_path(@outline)
    else
      render :edit
    end
  end

  private

  def current_outline
    Outline.today || MissingOutline.new
  end

  def outline_params
    params.require(:outline).permit(:title,:body,:publish_date)
  end

end
