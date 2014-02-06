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

  context "when the expected out come is a parameter with an array of values" do
    it "parses multiple input fields into an array of values for a single key" do
      form_html = <<-HTML
      <form action="not_specified" method="post">
        <input type="checkbox" name="?" value="4" checked />
        <input type="checkbox" name="??" value="5" checked />
        <input type="checkbox" name="???" value="6" checked />
      </form>
      HTML

      expect(params(form_html)).to eql({"category_ids" => ["4", "5", "6"]})
    end

    it "can be mixed with other basic field names and array field names" do
      form_html = <<-HTML
      <form action="not_specified" method="post">
        <input type="text" name="?" value="Karaoke!" />
        <input type="checkbox" name="??" value="4" checked />
        <input type="checkbox" name="???" value="5" checked />
        <input type="checkbox" name="????" value="6" checked />
        <input type="text" name="?????" value="Joe" />
        <input type="text" name="??????" value="Jane" />
      </form>
      HTML

      expect(params(form_html)).to eql({
                                        "category_ids" => ["4", "5", "6"],
                                        "party_name" => "Karaoke!",
                                        "guest_names" => ["Joe", "Jane"]
                                        })
    end
  end

  context "when the expected out come is a parameter with a nested hash value" do
    it "parses multiple input fields into an array of values for a single key" do
      form_html = <<-HTML
      <form action="not_specified" method="post">
        <input type="text" name="?" value="Eye-catching Title" />
        <textarea name="??">Shallow story...</textarea>
      </form>
      HTML

      expect(params(form_html)).to eql({"post" => {
                                                  "title" => "Eye-catching Title",
                                                  "body" => "Shallow story..."
                                                  }
                                        })
    end
  end

  context "when nesting parameters of diffent value types" do
    it "allows for nested hashes to have values that parse to arrays of values" do
      form_html = <<-HTML
      <form action="not_specified" method="post">
        <input type="text" name="?" value="Eye-catching Title" />
        <textarea name="??">Shallow story...</textarea>
        <input type="checkbox" name="???" value="87" /> Hard Hitting News
        <input type="checkbox" name="????" value="34" /> Breaking
      </form>
      HTML

      expect(params(form_html)).to eql({"post" => {
                                                  "title" => "Eye-catching Title",
                                                  "body" => "Shallow story...",
                                                  "tag_ids" => ["87", "34"]
                                                  }
                                        })
    end

    it "allows for nested hashes to be included in an array of values for a parameter" do
        form_html = <<-HTML
        <form action="not_specified" method="post">
          <input type="text" name="?" value="Joe" />
          <input type="text" name="??" value="5551212" />
          <input type="text" name="???" value="Jane" />
          <input type="text" name="????" value="5551213" />
        </form>
        HTML

        expect(params(form_html)).to eql({"guests" => [
                                                        {"name" => "Joe", "phone" => "5551212"},
                                                        {"name" => "Jane", "phone" => "5551213"}
                                                      ]
                                          })
    end
  end
end