require 'markdown'

class Outline < ActiveRecord::Base
  include PgSearch
  multisearchable against: [ :title, :body ]

  has_paper_trail on: [ :update ]

  def self.today
    find_by_publish_date(Time.now.to_date)
  end

  def to_param
    publish_date.strftime("%Y%m%d")
  end

  def date
    publish_date
  end

  validates :title, presence: true
  validates :body, presence: true
  validates :publish_date, uniqueness: true

  before_save :default_publish_date_to_today

  def body_as_html
    Markdown.render(body.to_s)
  end

  def default_publish_date_to_today
    self.publish_date = Time.now unless publish_date
  end

  def previous
    self.class.where("publish_date < ?",publish_date).order("publish_date DESC").first
  end

  def next
    self.class.where("publish_date > ?",publish_date).order("publish_date ASC").first
  end

end
