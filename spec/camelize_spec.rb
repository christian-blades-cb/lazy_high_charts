require File.join(File.dirname(__FILE__), "spec_helper")

describe HighChartsHelper do
  
  context "string helper" do
    describe "camelize" do
      include LazyHighCharts::LayoutHelper
      
      it "should camelcase with a lower first letter" do
        "alpha_beta_charlie".camelize(false).should eq "alphaBetaCharlie"
      end

      it "should camelcase with an upper first letter" do
        "hotel_indigo_java".camelize.should eq "HotelIndigoJava"
      end
    end
  end

end

