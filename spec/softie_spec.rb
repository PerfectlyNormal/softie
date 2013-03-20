require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Softie do

  describe "with defaults" do
    before :each do
      @article = DefaultArticle.new(title: "Softie with Defaults")
    end

    it "should add a .active scope" do
      DefaultArticle.should respond_to(:active)
    end

    it "should add a key called :deleted_at" do
      @article.keys.keys.should include("deleted_at")
    end

    it "should not add a key called :deleted_by" do
      @article.keys.keys.should_not include("deleted_by")
    end

    it "should add a method for deleting" do
      @article.should respond_to(:deleted!)
    end

    it "should add a method for checking if the document is deleted" do
      @article.should respond_to(:deleted?)
    end

    it "should add a method for restoring" do
      @article.should respond_to(:restore!)
    end

  end

  describe "#deleted?" do
    before :each do
      @article = DefaultArticle.new(title: "Softie with Defaults")
    end

    it "should not be true by default" do
      @article.should_not be_deleted
    end

    it "should be true after a call to #deleted!" do
      @article.deleted!
      @article.should be_deleted
    end

    it "should be false after a call to #restore!" do
      @article.deleted!
      @article.restore!
      @article.should_not be_deleted
    end
  end

  describe "#deleted!" do
    before :each do
      @article = DefaultArticle.new(title: "Softie with Defaults")
    end

    it "should store the current time" do
      time = Time.utc(2013, 03, 20, 13, 37, 42)
      Timecop.freeze(time) do
        @article.deleted!
        @article.deleted_at.should == time
      end
    end
  end

  describe "#restore!" do
  end
end