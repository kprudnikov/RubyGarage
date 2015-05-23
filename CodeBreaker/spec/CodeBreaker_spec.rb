require 'spec_helper'

describe CodeBreaker::Game do

  before :all do
    @game = CodeBreaker::Game.new
  end

  it 'has a version number' do
    expect(CodeBreaker::VERSION).not_to be nil
  end

  describe "#start" do
    before do
      @code = @game.start
    end

    it "returns 4 digits code, 1-6 only" do
      expect(@code).to match(/[1-6]{4}/)
    end

    it "generates new code with each launch" do
      new_code = CodeBreaker::Game.new.start
      expect(@code).not_to eq(new_code)
    end
  end

  describe "#hint" do
    before do
      @game.start
      @hint = @game.hint
    end

    it "returns 1 digit" do
      expect(@hint.to_s).to match(/[1-6]/)
    end
    it "can be called only once" do
      game = CodeBreaker::Game.new
      game.start

      expect(game.hint).to be_truthy
      expect(game.hint).to be_falsy
    end
  end

  describe "#check" do

    context "basic" do

      before :all do
        @game.start
        @game.send(:set_code, "1234")
      end

      it "returns a string" do
        expect(@game.check('1234')).to be_an_instance_of(String)
      end

      it "contains only '+', '-' or an empty string"  do
        expect(@game.check("1234")).to match(/[+-]*/)
      end

      it "is not longer than 4 symbols" do
        expect(@game.check("1234").length).to be <= 4
      end

      it "should raise error when input has invalid length" do
        expect{@game.check("11111")}.to raise_error(ArgumentError)
        expect{@game.check("111")}.to raise_error(ArgumentError)
      end

      it "should not raise error when input is valid" do
        expect{@game.check("1111")}.to_not raise_error
      end
    end

    context "input validation", focus: true do
      it "should return valid results" do
        @game.start
        @game.send(:set_code, "1234")

        expect(@game.check("1111")).to eq("+")
        expect(@game.check("5651")).to eq("-")
        expect(@game.check("5631")).to eq("+-")
        expect(@game.check("4321")).to eq("----")
        expect(@game.check("3346")).to eq("--")
        expect(@game.check("6666")).to eq("")

        @game.send(:set_code, "5555")
        expect(@game.check("6566")).to eq("+")

        @game.send(:set_code, "5455")
        expect(@game.check("6564")).to eq("--")
        expect(@game.check("5555")).to eq("+++")
        expect(@game.check("4555")).to eq("++--")
        expect(@game.check("5455")).to eq("++++")
      end
    end
  end
end