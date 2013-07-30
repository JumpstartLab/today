require 'spec_helper'

describe Outline do

  subject do
    described_class.new title: "Title", body: "# Body"
  end

  describe '#body_as_html' do

    it "returns the body as html" do
      expect(subject.body_as_html).to eq("<h1>Body</h1>\n")
    end
  end
end