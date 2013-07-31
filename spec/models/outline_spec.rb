require 'spec_helper'

describe Outline do

  subject { outline }

  def outline(params = {})
    params = { title: "Title", body: "# Body", publish_date: Time.now }.merge(params)
    described_class.new(params)
  end

  describe "#publish_date" do
    it "defaults to the current date" do
      described_class.new title: "Title", body: "# Body"
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



  describe "#previous" do
    context "when a previous outline exists" do
      it "returns the previous outline" do
        expected_outline = outline(publish_date: 1.week.ago)
        expected_outline.save
        expect(subject.previous).to eq(expected_outline)
      end
    end

    context "when multiple older outlines exist" do
      it "returns the first oldest outline" do
        expected_outline = outline(title: "First Previous", publish_date: 7.days.ago)
        expected_outline.save

        outline(title: "Second Previous", publish_date: 10.days.ago).save

        outline(title: "Third Previous", publish_date: 14.days.ago).save

        expect(subject.previous).to eq(expected_outline)
      end
    end

    context "when the current outline does not have a previous outline" do
      it "returns nil" do
        expect(subject.previous).to be_nil
      end
    end
  end

  describe "#next" do
    context "when the current outline has a next outline" do
      it "returns the first newer outline" do
        expected_outline = outline(title: "First Newer", publish_date: 2.days.from_now)
        expected_outline.save

        outline(title: "Second Newer", publish_date: 10.days.from_now).save

        outline(title: "Third Newer", publish_date: 14.days.from_now).save

        expect(subject.next).to eq(expected_outline)
      end
    end

    context "when the current outline does not have a next outline" do
      it "returns nil" do
        expect(subject.previous).to be_nil
      end
    end
  end

end