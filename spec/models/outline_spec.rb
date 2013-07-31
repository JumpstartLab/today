require 'spec_helper'

describe Outline do

  subject do
    described_class.new title: "Title", body: "# Body"
  end

  it "publish_date defaults to the current ddate " do
    # subject.date
  end

  describe "#publish_date" do
    it "defaults to the current date" do
      subject.save
      expect(subject.publish_date).to eq(Time.now.to_date)
    end

    it "does not override the existing date" do
      subject.publish_date = 2.days.ago
      subject.save
      expect(subject.publish_date).to eq(2.day.ago.to_date)
    end
  end

  describe '#body_as_html' do
    it "returns the body as html" do
      expect(subject.body_as_html).to eq("<h1>Body</h1>\n")
    end
  end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

end