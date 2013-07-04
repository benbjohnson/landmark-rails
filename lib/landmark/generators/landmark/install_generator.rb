module Landmark
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Landmark initializer."

      def copy_config_file
        template "landmark.yml", "config/landmark.yml"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
