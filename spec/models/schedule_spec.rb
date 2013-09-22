require 'spec_helper'

describe Schedule do

  def schedule(params = {})
    described_class.new(params[:outline],params.except(:outline))
  end

  describe "#current" do
    let(:outline) { double("Outline",versions: []) }
    subject { schedule(outline: outline) }
    it "returns the outline provided" do
      expect(subject.current).to eq(outline)
    end


    context "when the document has revisions" do
      context "when a revision is not provided" do

        let(:outline) { double("Outline", body_as_html: "Current Text", versions: [ first_revision ]) }
        let(:first_revision) { double("First Revision",body_as_html: "Original Text") }

        subject { schedule(outline: outline) }

        it "returns the very first revision for the outline" do
          expect(subject.body).to eq(outline.body_as_html)
        end

      end

      context "when a revision is provided" do

        let(:outline) { double("Outline", body_as_html: "Current Text", versions: [ first_revision ]) }
        let(:first_revision) { double("First Revision", body_as_html: "Original Text") }

        subject { schedule(outline: outline,revision: 0) }

        it "returns the very first revision for the outline" do
          expect(subject.body).to eq(first_revision.body_as_html)
        end
      end
    end
  end

  describe "#body" do
    let(:expected_body) { "<h1>BODY</h1>" }
    subject { schedule(outline: double('Outline',versions: [],body_as_html: expected_body)) }
    it "returns the current outlines body as html" do
      expect(subject.body).to eq(expected_body)
    end
  end

  describe "#publish_date" do
    let(:expected_publish_date) { "publish me" }
    subject { schedule(outline: double('Outline',versions: [],publish_date: expected_publish_date)) }
    it "returns the current outlines publish date" do
      expect(subject.publish_date).to eq(expected_publish_date)
    end
  end


  describe "#previous?" do
    context "when the current outline has a previous outline" do
      subject { schedule(outline: double('Outline',versions: [],previous: "present")) }
      it "is true" do
        expect(subject.previous?).to be_true
      end
    end
    context "when the current outline does not have a previous outline" do
      subject { schedule(outline: double('Outline',versions: [],previous: nil)) }
      it "is false" do
        expect(subject.previous?).not_to be_true
      end
    end
  end

  describe "#previous" do
    context "when the current outline has a previous outline" do
      let(:previous) { "present" }
      subject { schedule(outline: double('Outline',versions: [],previous: previous)) }
      it "returns the outline" do
        expect(subject.previous).to eq(previous)
      end
    end

    context "when the current outline does not have a previous outline" do
      subject { schedule(outline: double('Outline',versions: [],previous: nil)) }
      it "returns a missing outline" do
        expect(subject.previous).to be_kind_of(MissingOutline)
      end
    end
  end

  describe "#next?" do
    context "when the current outline has a next outline" do
      subject { schedule(outline: double('Outline',versions: [],next: "present")) }
      it "is true" do
        expect(subject.next?).to be_true
      end
    end

    context "when the current outline does not have a next outline" do
      subject { schedule(outline: double('Outline',versions: [],next: nil)) }
      it "is false" do
        expect(subject.next?).not_to be_true
      end
    end
  end

  describe "#next" do
    context "when the current outline has a next outline" do
      let(:next_outline) { "present" }
      subject { schedule(outline: double('Outline',versions: [],next: next_outline)) }
      it "returns the outline" do
        expect(subject.next).to eq(next_outline)
      end
    end

    context "when the current outline does not have a next outline" do
      subject { schedule(outline: double('Outline',versions: [],next: nil)) }
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