# jekyll_elm

Compile Elm scripts and include them in a Jekyll site.

## Installation

1.  Add this line to your application's Gemfile `gem 'jekyll_elm'`.
2.  And then execute `bundle`.
3.  Add the following to your `_config.yml`: 
```yml
  plugins: 
    - jekyll_elm
 ```

## Usage

Simple create a new post/draft/page/whatever with the extension `.elm`. It will
be detected and compiled.


### Generating js files
You can also create the .elm file inside the `assets/elm` directory and tell the plugin to output js files.
Just add to your `_config.yml`:

```
jekyll_elm:
  output_extension: "js"
``

## Contributing

1. Fork it ( https://github.com/[my-github-username]/jekyll_elm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
