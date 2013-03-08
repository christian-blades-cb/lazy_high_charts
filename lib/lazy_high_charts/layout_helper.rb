# coding: utf-8
require 'json'
require 'erb'

module LazyHighCharts
  module LayoutHelper

    def high_chart(placeholder, object  , &block)
      object.html_options.merge!({:id=>placeholder})
      object.options[:chart][:renderTo] = placeholder
      high_graph(placeholder,object , &block).concat(content_tag("div","", object.html_options))
    end

    def high_stock(placeholder, object  , &block)
      object.html_options.merge!({:id=>placeholder})
      object.options[:chart][:renderTo] = placeholder
      high_graph_stock(placeholder,object , &block).concat(content_tag("div","", object.html_options))
    end

    def high_graph(placeholder, object, &block)
      build_html_output("Chart", placeholder, object, &block)
    end

    def high_graph_stock(placeholder, object, &block)
      build_html_output("StockChart", placeholder, object, &block)
    end

    def build_html_output(type, placeholder, object, &block)
      options_collection = {"series" => object.data}.merge OptionsKeyFilter.filter(object.options).deep_camelize

      core_js =<<-EOJS
        var options = #{options_collection.to_json};
        #{capture(&block) if block_given?}
        window.chart_#{placeholder} = new Highcharts.#{type}(options);
      EOJS

      if defined?(request) && request.respond_to?(:xhr?) && request.xhr?
        graph =<<-EOJS
        <script type="text/javascript">
        (function() {
          #{core_js}
        })()
        </script>
        EOJS
      elsif defined?(Turbolinks) && request.headers["X-XHR-Referer"]
        graph =<<-EOJS
        <script type="text/javascript">
        (function() {
          $(window).bind('page:load', function() {
            #{core_js}
          });
        })()
        </script>
        EOJS
      else
        graph =<<-EOJS
        <script type="text/javascript">
        (function() {
          var onload = window.onload;
          window.onload = function(){
            if (typeof onload == "function") onload();
            #{core_js}
          };
        })()
        </script>
        EOJS
      end

      if defined?(raw)
        return raw(graph) 
      else
        return graph
      end

    end

    private

    def content_tag(name, content = nil, options = nil)
      if options
        options_string = options.map { |k,v| %|#{k}="#{ERB::Util.h(v)}"| }.join(" ")
      else
        options_string = ""
      end

      "<#{name} #{options_string}>#{content}</#{name}>"
    end
    
        
  end
end
