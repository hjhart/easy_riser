require 'spec_helper'

describe 'MuniHelper' do

  context "#get_times" do
    context "when it is an invalid stop/bus combo" do
      before do
        xml_file = File.join(Rails.root, 'db', 'fixtures', 'invalid_bus_times.xml')
        @times = MuniHelper.get_times(xml_file)
      end

      it "should return an empty array" do
        @times.should == []
      end
    end

    context "when there is a valid bus/stop combo" do
      before do
        xml_file = File.join(Rails.root, 'db', 'fixtures', 'valid_bus_times.xml')
        @times = MuniHelper.get_times(xml_file)
      end

      it "should return an array of numbers" do
        @times.should_not be_empty
        @times.each do |number|
          number.should =~ /\d{1,2}/
        end
      end
    end
  end
end
