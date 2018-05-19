require 'open-uri'

module ProspectusGems
  ##
  # Helper for automatically adding dependency status check
  class Gemspec < Module
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
  end
end
