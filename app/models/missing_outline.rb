class MissingOutline

  def initialize(publish_date = default_publish_date)
    @publish_date = publish_date
  end

  def to_param
    publish_date.strftime("%Y%m%d")
  end

  def versions
    []
  end

  def title
    %{Missing}
  end

  def body
    %{# No Outline For This Date}
  end

  def body_as_html
    Markdown.render(body)
  end

  attr_reader :publish_date

  def default_publish_date
    Time.now.to_date
  end

  def previous
    Outline.where("publish_date < ?",publish_date).order("publish_date DESC").first
  end

  def next
    Outline.where("publish_date > ?",publish_date).order("publish_date ASC").first
  end

end