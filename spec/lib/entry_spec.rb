require 'spec_helper'
require './lib/calendar'

describe Calendar::Feed::Entry do

  def contents(file)
    File.read File.expand_path(File.join(__FILE__,'..','..','fixtures',file))
  end

  describe "Recurring Event" do

    let(:subject) do
      described_class.parse contents('recurring_event.xml')
    end

    it "title" do
      expect(subject.title).to eq('Focus Week Group Work')
    end

    it "start_time" do
      expect(subject.start_time).to eq(DateTime.parse("2013-11-21T13:00:00.000-07:00"))
    end

    it "end_time" do
      expect(subject.end_time).to eq(DateTime.parse("2013-11-21T16:00:00.000-07:00"))
    end

  end

end