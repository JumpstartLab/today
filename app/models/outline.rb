require 'markdown'

class Outline < ActiveRecord::Base

  def self.today
    where(publish_date: Time.now.to_date).first
  end

  validates :title, presence: true
  validates :body, presence: true

  before_save :default_publish_date_to_today

  def body_as_html
    Markdown.render(body.to_s)
  end

  def default_publish_date_to_today
    self.publish_date = Time.now unless publish_date
  end

end
