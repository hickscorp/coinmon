Gem::Specification.new do |s|
  s.name        = 'coinmon'
  s.version     = '0.1.1'
  s.date        = '2017-12-23'
  s.summary     = 'Coin monitoring made easy.'
  s.description = 'Coin monitoring made easy.'
  s.authors     = ['Pierre Martin']
  s.email       = 'hickscorp@gmail.com'
  s.files       = %w(bin/coinmon lib/coinmon.rb lib/coinmon/tablifier.rb)
  s.homepage    = 'http://github.com/hickscorp/coinmon'
  s.license     = 'MIT'
  s.executables << 'coinmon'
end
