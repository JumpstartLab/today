class Schedule

  #
  # @param [Outline] outline this is the outline that the schedule is
  #   based around.
  # @param [Hash] options contains the additional options for the
  #   schedule. `:revision` is previous version value to view of the
  #   outline being provided.
  #
  def initialize(outline,options = {})
    @current = outline
    @options = options
  end

  def has_revisions?
    ! @current.versions.empty?
  end

  def revisions
    @current.versions.reverse
  end

  def current
    if has_revisions? and @options[:revision]
      @current.versions[@options[:revision].to_i].reify
    else
      @current
    end
  end

  def body
    current.body_as_html.html_safe
  end

  def publish_date
    @current.publish_date
  end

  def previous?
    !!@current.previous
  end

  def previous
    @current.previous || missing_outline
  end

  def next?
    !!@current.next
  end

  def next
    @current.next || missing_outline
  end

  def can_edit?
    ! current.is_a?(MissingOutline)
  end

  private

  def missing_outline
    MissingOutline.new
  end

end