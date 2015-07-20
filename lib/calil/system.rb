module Calil
  class System

    def initialize(element)
      @element = element
    end

    def systemid
      @element.attributes["systemid"]
    end

    def reservable?
      !!(@element.elements["reserveurl"] && !@element.elements["reserveurl"].text.to_s.empty?)
    end

    def libkeys
      element_libkeys = @element.elements['libkeys']
      return nil if (element_libkeys == nil)

      hash = {}
      REXML::XPath.each(element_libkeys, "*") do |e|
          hash[e.attribute('name').value] = e.text
      end
      return hash
    end

    def method_missing(action, *args)

      if %w(status reserveurl).include? action.to_s
        @element.elements[action.to_s].text
      else
        super
      end

    end

    def inspect
      attr_body = %w(systemid status reserveurl libkeys reservable?).map do |method_name|
        eval("\"#{method_name}: '#{send(method_name)}'\"")
      end.join(", ")
      "#<System #{attr_body}>"
    end
  end

end
