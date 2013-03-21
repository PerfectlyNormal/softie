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

    it "saves the document" do
      @article.should_receive(:save).and_return(true)
      @article.deleted!
    end

    describe "with deleted_by functionality" do
      it "should store the user" do
        article = ArticleWithDeletedBy.new(title: "deleted_by is a User")
        user    = User.new(name: "Dummy User")

        article.deleted!(by: user)
        article.deleted_by.should eq(user)
      end
    end
  end

  describe "#restore!" do
    before :each do
      @article = DefaultArticle.new(title: "Softie with Defaults")
      @article.deleted!
    end

    it "should not be deleted any more" do
      @article.restore!
      @article.should_not be_deleted
    end

    it "saves the document" do
      @article.should_receive(:save).and_return(true)
      @article.restore!
    end

    describe "with deleted_by functionality" do
      it "should clear the user" do
        article = ArticleWithDeletedBy.new(title: "deleted_by is a User")
        user    = User.new(name: "Dummy User")
        article.deleted!(by: user)

        article.restore!
        article.deleted_by.should be_nil
      end
    end
  end

  describe "#deleted_by" do
    describe "when enabled" do
      it "should add a key called deleted_by" do
        ArticleWithDeletedBy.new(
          title: "deleted_by is a User"
        ).keys.keys.should include("deleted_by")
      end
    end

    describe "when not enabled" do
      it "should not add the deleted_by key" do
        @article = NonDefaultArticle.new(title: "Not tracking user")
        @article.keys.keys.should_not include("deleted_by")
      end
    end

    describe "enabled with a different key name" do
      before :each do
        @article = ArticleWithWasDeletedBy.new(title: "deleted_by key is was_deleted_by")
      end

      it "should add a key called was_deleted_by" do
        @article.keys.keys.should include("was_deleted_by")
      end

      it "should not add the default key" do
        @article.keys.keys.should_not include("deleted_by")
      end
    end
  end

  describe "with a different key name" do
    before :each do
      @article = NonDefaultArticle.new(title: "Different key names")
    end

    it "should add a key called was_deleted" do
      @article.keys.keys.should include("was_deleted")
    end

    it "should not add a key called deleted_at" do
      @article.keys.keys.should_not include("deleted_at")
    end

    it "should look at the right key in the scope" do
      NonDefaultArticle.active.to_hash.should include(was_deleted: nil)
    end
  end

  describe "with the scope disabled" do
    it "should not generate the method" do
      ArticleWithoutScope.should_not respond_to(:active)
    end
  end
end