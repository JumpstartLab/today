class Outline < ActiveRecord::Base

  def body_as_html
    Markdown.render(body.to_s)
  end
end
