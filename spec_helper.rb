require "nokogiri"
require "rack/utils"

module HTMLToRackParamsHelper
  def params(html)
    # Parse the HTML into Nokogiri-searchable nodes
    html_nodes = Nokogiri::HTML(html)
    name_value_pairs = []
    # Find the first form element in the page
    html_nodes.search("form").first.tap do |form|
      # Search that form element for form fields
      form.search("input, select, textarea").each do |form_field|
        name = form_field.attributes["name"].to_s
        # Different form fields store their value in different ways...
        value = case form_field.name
                when "input" then form_field.attributes["value"].to_s
                when "textarea" then form_field.text.to_s
                when "select"
                  selected_option_fields = form_field.search("option[selected]")
                  unless selected_option_fields.size > 0
                    raise "No option 'selected' for field '#{name}'"
                  end
                  
                  selected_option_fields.last.attributes["value"].to_s
                end
        name_value_pairs << [name, URI.encode(value)]
      end
    end

    # Build up a URI query string of name/value pairs
    # param1=someValue&param2=someOtherValue
    query = name_value_pairs.map { |pair| pair.join("=") }.join("&")
    
    # Parse this query string with Rack to turn it into a params hash
    Rack::Utils.parse_nested_query(query)
  end
end

RSpec.configure do |c|
  c.fail_fast = true
  c.color = true
  c.add_formatter("documentation")
  
  c.include HTMLToRackParamsHelper
end