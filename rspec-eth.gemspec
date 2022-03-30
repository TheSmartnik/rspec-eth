require_relative 'lib/rspec/eth/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-eth"
  spec.version       = RSpec::Eth::VERSION
  spec.authors       = ["TheSmartnik"]
  spec.email         = ["misharinn@gmail.com"]

  spec.summary       = %q{RSpec extension that allows to easily test solidity smart contracts}
  spec.description   = %q{RSpec extension that spins up ganache server for tests and adds a few handy methods. Expected to be used with ethereum.rb}
  spec.homepage      = "https://github.com/TheSmartnik/rspec-eth"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/TheSmartnik/rspec-eth"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|contracts)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'ethereum.rb'
end
