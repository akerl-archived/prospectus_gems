Gem::Specification.new do |s|
  s.name        = 'prospectus_gems'
  s.version     = '0.3.1'
  s.date        = Time.now.strftime('%Y-%m-%d')

  s.summary     = 'Prospectus helpers for gemspecs'
  s.description = 'Prospectus helpers for gemspecs'
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/prospectus_gems'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split

  s.add_dependency 'bundler', '~> 2.0.0'
  s.add_dependency 'prospectus', '~> 0.9.0'

  s.add_development_dependency 'codecov', '~> 0.1.1'
  s.add_development_dependency 'fuubar', '~> 2.3.0'
  s.add_development_dependency 'goodcop', '~> 0.7.0'
  s.add_development_dependency 'rake', '~> 12.3.0'
  s.add_development_dependency 'rspec', '~> 3.8.0'
  s.add_development_dependency 'rubocop', '~> 0.72.0'
end
