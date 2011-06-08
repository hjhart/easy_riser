require 'spec_helper'

describe Route do
  before do
    @valid_attributes = {
        :name => "Shipoopi"
    }
    @route = Route.new(@valid_attributes)
  end

  context "validations" do
    it "should be valid" do
      @route.should be_valid
    end

    it "should require a name" do
      @route.name = nil
      @route.save
      @route.should have(1).error_on(:name)
    end
  end

  context "retrieve_stops" do
    context "when the bus stop is invalid" do
      before do
        @stops = Route.get_stops('VI')
      end
      it "should return an empty hash" do
        @stops.should == {}
      end
    end

    context "when it is a valid bus stop" do
      before do
        @stops = Route.get_stops(45)
      end

      it "should be a hash" do
        @stops.class.should == Hash
      end

      it "should have numbers for a key" do
        @stops.should_not be_empty
        @stops.each do |key, value|
          key.should match /\d{4,5}/
          value.should_not be_empty
        end
      end
    end
  end

  context "#get_times" do
    it "should return an array of minutes" do
      @times = Route.get_times(45, 6771)
      @times.class.should == Array
      @times.should_not be_empty
      puts @times
    end
  end
end
