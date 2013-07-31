require 'spec_helper'

describe Schedule do

  def schedule(params = {})
    described_class.new(params[:outline])
  end

  describe "#current" do
    let(:outline) { "expected outline" }
    subject { schedule(outline: outline) }
    it "returns the outline provided" do
      expect(subject.current).to eq(outline)
    end
  end

  describe "#body" do
    let(:expected_body) { "<h1>BODY</h1>" }
    subject { schedule(outline: double('Outline',body_as_html: expected_body)) }
    it "returns the current outlines body as html" do
      expect(subject.body).to eq(expected_body)
    end
  end

  describe "#publish_date" do
    let(:expected_publish_date) { "publish me" }
    subject { schedule(outline: double('Outline',publish_date: expected_publish_date)) }
    it "returns the current outlines publish date" do
      expect(subject.publish_date).to eq(expected_publish_date)
    end
  end


  describe "#previous?" do
    context "when the current outline has a previous outline" do
      subject { schedule(outline: double('Outline',previous: "present")) }
      it "is true" do
        expect(subject.previous?).to be_true
      end
    end
    context "when the current outline does not have a previous outline" do
      subject { schedule(outline: double('Outline',previous: nil)) }
      it "is false" do
        expect(subject.previous?).not_to be_true
      end
    end
  end

  describe "#previous" do
    context "when the current outline has a previous outline" do
      let(:previous) { "present" }
      subject { schedule(outline: double('Outline',previous: previous)) }
      it "returns the outline" do
        expect(subject.previous).to eq(previous)
      end
    end

    context "when the current outline does not have a previous outline" do
      subject { schedule(outline: double('Outline',previous: nil)) }
      it "returns a missing outline" do
        expect(subject.previous).to be_kind_of(MissingOutline)
      end
    end
  end

  describe "#next?" do
    context "when the current outline has a next outline" do
      subject { schedule(outline: double('Outline',next: "present")) }
      it "is true" do
        expect(subject.next?).to be_true
      end
    end

    context "when the current outline does not have a next outline" do
      subject { schedule(outline: double('Outline',next: nil)) }
      it "is false" do
        expect(subject.next?).not_to be_true
      end
    end
  end

  describe "#next" do
    context "when the current outline has a next outline" do
      let(:next_outline) { "present" }
      subject { schedule(outline: double('Outline',next: next_outline)) }
      it "returns the outline" do
        expect(subject.next).to eq(next_outline)
      end
    end

    context "when the current outline does not have a next outline" do
      subject { schedule(outline: double('Outline',next: nil)) }
      it "returns a missing outline" do
        expect(subject.next).to be_kind_of(MissingOutline)
      end
    end
  end

  describe "#can_edit?" do
    context "when the current outline is valid" do
      subject { schedule(outline: Outline.new) }
      it "is true" do
        expect(subject.can_edit?).to be_true
      end
    end

    context "when created with a missing outline" do
      subject { schedule(outline: MissingOutline.new)}
      it "is false" do
        expect(subject.can_edit?).to_not be_true
      end
    end
  end
end