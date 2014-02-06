# Rack Params Naming/Parsing Exercises

Rack is the low-level HTTP library that powers Rails' and Sinatra's (and more)
basic HTTP Request and Response functionality. High-level Web Frameworks don't
agree on everything, but one thing they do agree on is the parsing of nested
query string params.

Rack gives us the ability to name our HTML form fields in ways that will result 
in a deterministic shape of hash from the `params` helper.

For instance, HTML form fields name as such:

```HTML
<form>
  <input type="text" name="search" value="needle" />
  <input type="text" name="haystack" value="all" />
</form>
```

when submitted, results in this `params` hash:

```ruby
{"search" => "needle", "haystack" => "all"}
```

**Your challenge**, should you choose to accept it, is to run the RSpec suite 
that accompanies this repo and fill in the HTML that will fulfill the contract 
specified in the spec.

## Running

**Prequisites**:

* Ruby 1.9.x or greater (http://ruby-lang.org)
* git (http://git-scm.org)
* Bundler (http://bundler.io/)

First, clone the repo somewhere on your computer, and navigate in your
Terminal to the cloned repo location:

```
$ git clone https://github.com/ryanbriones/params-naming-parsing-exercises.git
$ cd params-naming-parsing-exercises
```

Install the dependencies using Bundler:

```
$ bundle install
```

Run the RSpec suite:

```
$ rspec params_parsing_spec.rb
```

RSpec should stop on the first failing spec showing you the difference in the 
expected (specified by the test) and the actual (specifed in the HTML) values. 
Your job is to correct the HTML `<form>` to have form fields are named 
  appropriately to result in the expected hash when parsed.

## Questions, Comments, or Concerns

Ryan Carmelo Briones <ryan.briones@brionesandco.com>

## License

BSD-licensed. See `LICENSE` for details