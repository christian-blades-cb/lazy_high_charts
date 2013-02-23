require File.dirname(__FILE__) + '/spec_helper'

describe LazyHighCharts::OptionsKeyFilter do
  it "should filter :pointInterval from seconds to milliseconds" do
    hash = LazyHighCharts::OptionsKeyFilter.filter(pointInterval: 1)
    hash[:pointInterval].should == 1000
  end

  describe "filters :pointStart from a Date to a JavaScript compatible string" do
    before(:each) do
      hash = LazyHighCharts::OptionsKeyFilter.filter(pointStart: Date.new(2012, 9, 13))
      @value = hash[:pointStart]
    end

    it "should be the correct string" do
      @value.should == "Date.UTC(2012, 8, 13)"
    end
    
    it "should be a more precise JavaScript Date if more precision in provided date is available" do
      hash = LazyHighCharts::OptionsKeyFilter.filter(pointStart: DateTime.new(2013, 2, 23, 14))
      @value = hash[:pointStart]
      @value.should == "Date.UTC(2013, 1, 23, 14)"
    end
    
    it "should be an even more precise JavaScript Date if more precision in provided date is available" do
      hash = LazyHighCharts::OptionsKeyFilter.filter(pointStart: DateTime.new(2013, 2, 23, 14, 33))
      @value = hash[:pointStart]
      @value.should == "Date.UTC(2013, 1, 23, 14, 33)"
    end

    it "should be js_code" do
      @value.js_code?.should be_true
    end
  end

  it "should filter keys recursively" do
    hash = LazyHighCharts::OptionsKeyFilter.filter({something: {another_thing: {pointInterval: 2}}})
    hash[:something][:another_thing][:pointInterval].should == 2000
  end
end
