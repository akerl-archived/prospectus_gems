require 'bundler'
require 'open-uri'

module ProspectusGems
  ##
  # Helper for automatically adding dependency status check
  class Gemspec < Module
    @gem_version_cache = {}

    def initialize(gemfile = nil, lockfile = nil)
      @gemfile = gemfile
      @lockfile = lockfile
    end

    def extended(other) # rubocop:disable Metrics/MethodLength
      gem_deps = parse_deps
      other.deps do
        gem_deps.each do |dep_name, current, latest|
          item do
            name 'gems::' + dep_name

            expected do
              static
              set latest
            end

            actual do
              static
              set current
            end
          end
        end
      end
    end

    private

    def parse_deps
      dependencies.map do |x|
        latest = Gemspec.lookup_gem(x.name)
        current = x.match?(x.name, latest) ? latest : x.requirements_list
        [x.name, current, latest]
      end
    end

    def dependencies
      @dependencies ||= dep_obj.dependencies
    end

    def dep_obj
      @dep_obj ||= if gemfile.read =~ /^gemspec$/
                     bundle.specs[bundle.dependencies.first.name].first
                   else
                     bundle
                   end
    end

    def bundle
      return @bundle if @bundle
      @bundle = Bundler::Definition.build(gemfile, lockfile, nil)
      @bundle.resolve_remotely!
      @bundle
    end

    def gemfile
      @gemfile ||= Bundler::SharedHelpers.default_gemfile
    end

    def lockfile
      @lockfile ||= Bundler::SharedHelpers.default_lockfile
    end

    class << self
      def lookup_gem(name)
        @gem_version_cache[name] ||= fetch_gem(name)
      end

      def fetch_gem(name)
        # rubocop:disable Security/Open
        body = open("#{versions_base_uri}/#{name}/latest.json").read
        # rubocop:enable Security/Open
        JSON.parse(body)['version']
      end

      def versions_base_uri
        @versions_base_uri ||= 'https://rubygems.org/api/v1/versions'
      end
    end
  end
end
