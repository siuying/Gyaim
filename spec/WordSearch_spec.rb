require 'spec_helper'

require 'WordSearch/WordSearch'

describe WordSearch do
  let(:searcher) {
    WordSearch.new("#{File.dirname(__FILE__)}/fixtures/dict.txt", "#{File.dirname(__FILE__)}/fixtures/local.txt", "#{File.dirname(__FILE__)}/fixtures/study.txt")
  }

  describe "#search" do
    it "should find word from dictionary" do
      searcher.search("013115").should be_include("昀")
    end

    it "should find word from local dictionary" do
      searcher.search("986").should be_include("咁")
    end

    it "should find word from study dictionary" do
      searcher.search("746").should be_include("前")
    end

    it "should find word from all of the dictionary" do
      searcher.search("013").should be_include("同")
      searcher.search("013").should be_include("明")
      searcher.search("013").should be_include("我")
    end
  end
end