require 'faraday'
require 'happymapper'

class Calendar

  def host
    "http://www.google.com"
  end

  def max_results
    250
  end

  def default_url
    "/calendar/feeds/casimircreative.com_lq2r68d0ovv782bmis46oo4dpk%40group.calendar.google.com/public/full?max-results=#{max_results}"
  end

  def connection
    @connection ||= Faraday.new(url: host)
  end

  def get(url = default_url)
    Feed.parse(connection.get(url).body, single: true)
  end

  class Feed
    include HappyMapper

    element :id, String
    element :updated, String
    element :title, String

    def next?
      links.find {|link| link.next? }
    end

    def next_url
      next_link = links.find {|link| link.next? }
      next_link.href if next_link
    end

    class Link
      include HappyMapper

      attribute :rel, String
      attribute :type, String
      attribute :href, String

      def next?
        rel == "next"
      end
    end

    has_many :links, Link, tag: 'link', xpath: '.'

    class Entry
      include HappyMapper

      element :id, String
      element :published, DateTime
      element :updated, DateTime

      element :title, String
      element :content, String

      has_many :links, Link, tag: 'link'

      class When
        include HappyMapper

        attribute :raw_end_time, DateTime, tag: "endTime"
        attribute :raw_start_time, DateTime, tag: "startTime"

        def end_time
          raw_end_time || DateTime.new
        end

        def start_time
          raw_start_time || DateTime.new
        end
      end

      # Ensure that we capture the gd:when node only
      element :when_specified, When, tag: 'when', namespace: 'gd', xpath: '.'

      def time_range
        # if when_specified.nil?
        #   puts "Event nil Time Range: #{id}
        #   #{title}"
        # end
        when_specified || When.new
      end

      def start_date
        start_time.to_date
      end

      def start_time
        time_range.start_time
      end

      def end_date
        end_time.to_date
      end

      def end_time
        time_range.end_time
      end

      def to_s
        "#{title} #{start_time.strftime("%I:%M %p")} to #{end_time.strftime("%I:%M %p")}"
      end
    end

    has_many :some_entries, Entry, tag: 'entry'

    def entries(options = {})

      total_entries = some_entries

      if next?
        current_entries = Calendar.new.get(next_url).entries

        total_entries += current_entries
      end

      if options[:start_date]
        total_entries = total_entries.find_all do |entry|
          entry.start_date == options[:start_date]
        end
      end

      total_entries.each do |entry|
        yield entry if block_given?
      end

      total_entries
    end


  end

end
