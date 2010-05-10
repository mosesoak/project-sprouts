
module Sprout

  class Executable

    attr_reader :name
    attr_reader :path

    def initialize options=nil
      options ||= {}
      @name        = options[:name]
      @path        = options[:path]
      @file_target = Sprout::FileTarget.new
      
      # You can provide a file_target OR all optional params.
      # kind of smelly...
      @file_target = options[:file_target] unless !options.has_key? :file_target
      # Optional params:
      @pkg_name    = options[:pkg_name] unless !options.has_key? :pkg_name
      @pkg_version = options[:pkg_version] unless !options.has_key? :pkg_version
      @platform    = options[:platform] unless !options.has_key? :platform
    end

    def pkg_name
      @pkg_name || file_target.pkg_name
    end

    def pkg_version
      @pkg_version || file_target.pkg_version
    end

    def platform
      @platform || file_target.platform
    end

    def resolve
      file_target.resolve unless file_target.nil?
    end

    def satisfies_requirement? version_requirement
        return true if version_requirement.nil?
        exe_version = Gem::Version.create pkg_version
        req_version = Gem::Requirement.create version_requirement
        req_version.satisfied_by?(exe_version)
    end
  end

end

