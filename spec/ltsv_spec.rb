require 'ltsv'

describe Ltsv do
  before do
    @ltsv = Ltsv.new
  end

  context "set 'key', 'value'" do
    before do
      @ltsv.set "key", "value"
    end

    it "get 'key'が'value'を返す" do
      @ltsv.get("key").should == "value"
    end
  end

  it "get 'key2'が'value2'を返す" do
    @ltsv.set "key2", "value2"
    @ltsv.get("key2").should == "value2"
  end

  it "set 'key', 'value'がnilを返す" do
    (@ltsv.set 'key', 'value').should be_nil
    @ltsv.get('key').should == 'value'
  end

  context "キーがある場合" do
    it "は、置き換えられた値を返す" do
      (@ltsv.set 'key', 'value').should be_nil
      (@ltsv.set 'key', 'value2').should == 'value'
    end
  end

  context "キーがない場合" do
    it "は、nilを返す" do
      @ltsv.get('key').should be_nil
    end
  end

  describe "#dump" do
    context "set 'key', 'value'" do
      it "shold return 'key:value\n'" do
        @ltsv.set 'key', 'value'
        @ltsv.dump.should == "key:value\n"
      end
    end

    context "set 'key2', 'value2'" do
      it "shold return 'key2:value2\n'" do
        @ltsv.set 'key2', 'value2'
        @ltsv.dump.should == "key2:value2\n"
      end
    end

    context "set 'key', 'value', set 'key2', value2'" do
      it "should return 'key:value\tkey2:value2\n" do
        @ltsv.set 'key', 'value'
        @ltsv.set 'key2', 'value2'
        @ltsv.dump.should == "key:value\tkey2:value2\n"
      end
    end
  end

  describe "nilキーがsetされたとき" do
    it "例外を発生させること" do
      proc {
        @ltsv.set(nil, 'value')
      }.should raise_error ArgumentError, "key should not be nil"
    end
  end

  describe "空文字キーが与えられる時" do
    it "例外を発生させる" do
      proc {
        @ltsv.set("", "value")
      }.should raise_error ArgumentError, "key should not be empty"
    end
  end

  describe "null値をsetすると" do
    it "例外を発生させる" do
      proc {
        @ltsv.set("key", nil)
      }.should raise_error ArgumentError, "value should not be nil"
    end
  end

  describe "空文字列をsetすると" do
    it "正常にsetできる" do
      proc{
        @ltsv.set("key", "")
      }.should_not raise_error
    end

    it "dumpはkey:\n" do
      @ltsv.set("key", "")
      @ltsv.dump.should == "key:\n"
    end
  end

  describe "コロンを含む文字列をsetすると" do
    it "バックスラッシュでエスケープする" do
      @ltsv.set("key", "val:ue")
      @ltsv.dump.should == "key:val\\:ue\n"
    end
  end
end
