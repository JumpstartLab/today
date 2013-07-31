require 'spec_helper'

describe MissingOutline do

  it "has a default title" do
    expect(subject.title).to eq "Missing"
  end

  it "has a default body" do
    expect(subject.body).to eq "# No Outline For This Date"
  end

  it "has an html body" do
    expect(subject.body_as_html).to eq "<h1>No Outline For This Date</h1>\n"
  end

  it "has a default publish date of today" do
    expect(subject.publish_date).to eq Time.now.to_date
  end

  it "returns the correct #to_param" do
    expected_to_param = Time.now.to_date.strftime("%Y%m%d")
    expect(subject.to_param).to eq expected_to_param
  end

  context "when created with a publish date" do
    subject { described_class.new 2.days.ago.to_date }
    it "has the specified publish date" do
      expect(subject.publish_date).to eq 2.days.ago.to_date
    end

    it "returns that value as the #to_param" do
      expected_to_param = 2.days.ago.to_date.strftime("%Y%m%d")
      expect(subject.to_param).to eq expected_to_param
    end
  end

  describe "#previous" do
    context "when there is at least one earlier outline" do
      it "will be returned" do
        outline = Outline.create title: "Title", body: "Body", publish_date: 2.days.ago.to_date
        expect(subject.previous).to eq outline
      end
    end

    context "when there are no outlines" do
      it "returns nil" do
        expect(subject.previous).to be_nil
      end
    end
  end

  describe "#next" do
    context "when there is at least one newer outline" do
      it "will be returned" do
        outline = Outline.create title: "Title", body: "Body", publish_date: 2.days.from_now.to_date
        expect(subject.next).to eq outline
      end
    end

    context "when there are no newer outlines" do
      it "returns nil" do
        expect(subject.next).to be_nil
      end
    end
  end

end