module Jasmine
  class Config

    # Add your overrides or custom config code here
    Rails.application.config.assets.paths << Rails.root.join("spec", "javascripts") << Rails.root.join("spec", "stylesheets")

  end
end


# Note - this is necessary for rspec2, which has removed the backtrace
module Jasmine
  class SpecBuilder
    def declare_spec(parent, spec)
      me = self
      example_name = spec["name"]
      @spec_ids << spec["id"]
      backtrace = @example_locations[parent.description + " " + example_name]
      parent.it example_name, {} do
        me.report_spec(spec["id"])
      end
    end
  end
end

require 'sprockets'
require 'haml_coffee_assets'

Jasmine::Headless.register_engine '.hamlc', HamlCoffeeAssets::HamlCoffeeTemplate

# this routine compiles and runs the hamlcoffee.js.coffee.erb and makes
# the result available to JHW
def add_haml_coffee_compiled_asset_path(asset_paths)

  # find the gem asset path that contains the hamlcoffee.js.coffee.erb
  haml_coffee_gem_asset_path = asset_paths.find { |path| path =~ /haml_coffee_assets/ }

  # compile the erb file into hamlcoffee.js.coffee
  compiled_haml_coffee_template = ERB.new(
    File.read(File.join(haml_coffee_gem_asset_path, "hamlcoffee.js.coffee.erb"))).result(binding)

  # create a tmp directory to put the compiled code in
  # this assumes you are running out of your project root!
  FileUtils.mkdir_p (tmp_haml_coffee_assets_path = File.join(Dir.pwd, "tmp/haml_coffee_assets/javascripts"))
  File.open(File.join(tmp_haml_coffee_assets_path, "hamlcoffee.js.coffee"), 'w') do |f|
    f.write compiled_haml_coffee_template
  end

  # add the new asset path containing the compiled file
  asset_paths << tmp_haml_coffee_assets_path

  # remove the original asset path from the gem, let you get the 'Skipping File' warning for the erb
  asset_paths.reject! { |path| path == haml_coffee_gem_asset_path }

end

# load any haml coffee configuration settings
require File.expand_path("../../../../config/initializers/haml_coffee_assets.rb", __FILE__)

# now update the files list class to use these paths instead of the original
updated_asset_paths = add_haml_coffee_compiled_asset_path(Sprockets.find_gem_vendor_paths(:for => 'javascripts'))
Jasmine::Headless::FilesList.instance_variable_set(:"@asset_paths", updated_asset_paths)
