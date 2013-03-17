require 'ltsv'

describe Ltsv do
  let(:ltsv) { Ltsv.new}

  describe "#get" do
    before do
      ltsv.set "key", "value"
      ltsv.set "key2", "value2"
    end

    it { ltsv.get("key").should == "value" }
    it { ltsv.get("key2").should == "value2" }
  end

  describe "#set" do
    context "キーがない場合" do
      it { (ltsv.set 'key', 'value').should be_nil }
    end

    context "キーがある場合" do
      before do
        (ltsv.set 'key', 'value').should be_nil
      end

      it "置き換えられた値を返す" do
        (ltsv.set 'key', 'value2').should == 'value'
      end
    end

    context "nilキーがsetされたとき" do
      it { proc { ltsv.set(nil, 'value') }.should raise_error ArgumentError }
    end

    context "空文字キーが与えられる時" do
      it { proc { ltsv.set("", "value") }.should raise_error ArgumentError }
    end

    context "null値をsetすると" do
      it { proc { ltsv.set("key", nil) }.should raise_error ArgumentError }
    end

    context "空文字列をsetすると" do
      it { proc{ ltsv.set("key", "") }.should_not raise_error }
    end
  end

  describe "#dump" do
    subject { ltsv.dump }

    context "set 'key', 'value'" do
      before { ltsv.set 'key', 'value' }
      it { should == "key:value\n" }
    end

    context "set 'key', 'value', set 'key2', value2'" do
      before do
        ltsv.set 'key', 'value'
        ltsv.set 'key2', 'value2'
      end

      it { should == "key:value\tkey2:value2\n" }
    end

    context "空文字列をsetすると" do
      before { ltsv.set 'key', '' }
      it { should == "key:\n"}
    end

    context "コロンを含む文字列をsetすると" do
      before { ltsv.set("key", "val:ue") }
      it { should == "key:val\\:ue\n" }
    end
  end
end
