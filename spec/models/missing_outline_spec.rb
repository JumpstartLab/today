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

  describe "#previous" do
    context "when there is at least one outline" do
      it "will be returned" do
        outline = Outline.create title: "Title", body: "Body"
        expect(subject.previous).to eq outline
      end
    end

    context "when there are no outlines" do
      it "returns nil" do
        expect(subject.previous).to be_nil
      end
    end
  end

  it "there is no 'next' outline" do
    expect(subject.next).to be_nil
  end


end