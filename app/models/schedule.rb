class Schedule

  attr_reader :current

  def initialize(outline)
    @current = outline
  end

  def body
    current.body_as_html.html_safe
  end

  def publish_date
    current.publish_date
  end

  def previous?
    !!current.previous
  end

  def previous
    current.previous || missing_outline
  end

  def next?
    !!current.next
  end

  def next
    current.next || missing_outline
  end

  def can_edit?
    ! current.is_a?(MissingOutline)
  end

  private

  def missing_outline
    MissingOutline.new
  end

end