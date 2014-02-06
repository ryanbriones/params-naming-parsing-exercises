require_relative "spec_helper"

describe "Rack Parameter Naming/Parsing" do
  context "when specifying basic names for input fields" do
    it "parses input fields into a hash where name is the key, and value is the value" do
      form_html = <<-HTML
      <form action="not_specified" method="post">
        <input type="text" name="??" value="zerocool" />
        <input type="password" name="???" value="1337" />
      </form>
      HTML

      expect(params(form_html)).to eql({"username" => "zerocool", "password" => "1337"})
    end    
  end
end