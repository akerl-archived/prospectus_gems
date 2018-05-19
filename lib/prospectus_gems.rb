require 'bundler'

module ProspectusGems
  ##
  # Helper for automatically adding dependency status check
  class Gemspec < Module
    @gem_version_cache = {}

    def initialize(gemspec)
      @gemspec = gemspec || Dir.glob('*.gemspec').first
    end

    def extended(other) # rubocop:disable Metrics/MethodLength
      other.deps do
        parse_deps.each do |dep_name, current, latest|
          item do
            name dep_name

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
      bundler_deps.map do |x|
        latest = Gemspec.lookup_gem(x.name)
        current = x.match?(x.name, latest) ? x.latest : x.requirements_list
        [x.name, current, latest]
      end
    end

    def bundler_deps
      @bundler_deps ||= bundle.dependencies.reject do |x|
        x.requirements_list == ['>= 0']
      end
    end

    def bundle
      @bundle ||= Bundler.load
    end

    class << self
      def self.lookup_gem(name)
        GEM_VERSION_CACHE[name] ||= fetch_gem(name)
      end

      def self.fetch_gem(name)
        # rubocop:disable Security/Open
        body = open("#{versions_base_uri}/#{name}/latest.json").read
        # rubocop:enable Security/Open
        JSON.parse(body)['version']
      end

      def self.versions_base_uri
        @versions_base_uri ||= 'https://rubygems.org/api/v1/versions'
      end
    end
  end
end
