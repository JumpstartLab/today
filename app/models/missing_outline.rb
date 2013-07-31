class MissingOutline

  def title
    %{Missing}
  end

  def body
    %{# No Outline For This Date}
  end

  def body_as_html
    Markdown.render(body)
  end

  def publish_date
    Time.now.to_date
  end

end