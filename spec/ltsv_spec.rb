require 'ltsv'

describe Ltsv do
  subject { ltsv.get(key) }
  let(:ltsv) { Ltsv.new }

  let(:key) { "key" }

  context "set 'key', 'value'" do
    before do
      ltsv.set "key", "value"
    end

    it{should == "value"}
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
end
