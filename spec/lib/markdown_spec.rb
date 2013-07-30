require 'spec_helper'
require 'markdown'

describe Markdown do

  subject { described_class }

  describe ".render" do
    it "has a render method" do
      expect(subject).to respond_to(:render)
    end

    context "valid markdown" do

      let(:content) do
        [ "# Hello",
          "",
          "Is it me you are looking for?" ].join("\n")
      end

      let(:result) do
        [ "<h1>Hello</h1>",
          "",
          "<p>Is it me you are looking for?</p>",
          ""].join("\n")
      end

      it "renders markdown into html" do
        expect(subject.render(content)).to eq(result)
      end
    end

  end

end