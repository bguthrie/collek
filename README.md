# Collek

This is the world's dumbest gem.

Look. Maybe you've got a CSV full of seed data, or you're integrating with some external
system. There's a pretty good chance that you wrote your code for that as a one-off, and now
it's a shitty mess. Am I right? Of course I am.

Or maybe you're writing a JSON API in Rails, and you're using #as_json, and you need canonical
route representations of your entities, and shoving them into your model feels ridiculous.

Friend, there is a better way, and it uses methods. Collek is a pattern to map a set of inputs to
a set of outputs, and maybe perform some nice transformations along the way. That's it.

    class UserMapping < Collek::Mapping
      output :birthdate
      output :display_name, input: :name

      def age
        (Time.now - self.birthdate).years
      end

      def fave_color
        "blue"
      end
    end

    irb> UserMapping.new(name: "Guybrush").display_name
    => "Guybrush"
    irb> UserMapping.new(birthdate: 19.years.ago).birthdate
    => 19.years.ago
    irb> UserMapping.new(birthdate: 19.years.ago).age
    => 19
    irb> UserMapping.new(name: "Guybrush Threepwood", birthdate: 19.years.ago).to_h
    => { display_name: "Guybrush Threepwood", birthdate: 19.years.ago, age: 19, fave_color: "blue" }


Collek is a simple DSL for building classes that use plain old methods to define
transformations. This is handy because methods are simple, easy to test independently of
each other, and can rely on other methods. It's common to see people testing their transforms
by shoving entire hashes through the method in question only to assert against a single field.
This avoids that.

The resulting classes can be extended in a variety of ways to support more specialized kinds
of input and output. For example, you can integrate it with Rails' view helpers to build JSON
representations that exist independent of your models and includes helpful things like view paths.
But I'm getting ahead of myself.

## Installation

Add this line to your application's Gemfile:

    gem 'collek'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install collek

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The MIT License (MIT)

Copyright (c) 2013 Brian Guthrie

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
