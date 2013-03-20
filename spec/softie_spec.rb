require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Softie do
  describe "with defaults" do
    before :each do
      @article = article_class.new(title: "Softie with Defaults")
    end

    it "should add a key called :deleted_at" do
      @article.keys.keys.should include("deleted_at")
    end

  end
end