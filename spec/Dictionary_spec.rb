require 'spec_helper'

require 'WordSearch/Dictionary'

describe Dictionary do
  let(:dict) {
    Dictionary.new("#{File.dirname(__FILE__)}/fixtures/dict.txt")
  }

  describe "#search" do
    it "should find match" do
      dict["013"].size.should == 4
      dict["013"].should be_include("明")
      dict["01311"].should be_include("明")
      dict["013115"].should be_include("明")
    end    
  end
end