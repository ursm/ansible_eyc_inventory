lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ansible_eyc_inventory/version'

Gem::Specification.new do |spec|
  spec.name          = 'ansible_eyc_inventory'
  spec.version       = AnsibleEYCInventory::VERSION
  spec.authors       = ['Keita Urashima']
  spec.email         = ['ursm@ursm.jp']
  spec.summary       = 'Engine Yard Cloud dynamic inventory script for Ansible'
  spec.homepage      = 'https://github.com/ursm/ansible_eyc_inventory'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r(^bin/)) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r(^(test|spec|features)/))
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'engineyard-cloud-client'
  spec.add_runtime_dependency 'thor'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
