# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-deis-graphite"
  spec.version       = "0.1.0"
  spec.authors       = ["Matt Knox"]
  spec.email         = ["matt.knox@sphero.com"]

  spec.summary       = %q{A Fluentd plugin that gathers response code metrics from the deis router.}
  spec.description   = %q{A Fluentd plugin that gathers response code metrics from the deis router and reports them to a graphite database.}
  spec.homepage      = "http://github.com/OrbotixInc/fluent-plugin-deis-graphite"
  spec.license       = "MIT"

  spec.files         = Dir.glob("{lib}/**/*")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fluentd"
  spec.add_runtime_dependency "metriks"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
