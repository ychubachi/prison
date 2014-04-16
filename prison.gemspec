# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prison/version'

Gem::Specification.new do |spec|
  spec.name          = "prison"
  spec.version       = Prison::VERSION
  spec.authors       = ["kazuhide maeda"]
  spec.email         = ["kzhd15med3g@gmail.com"]
  spec.summary       = %q{FreeBSD jail wrapper.}
  spec.description   = %q{The easiest way to management FreeBSD jail.}
  spec.homepage      = "https://github.com/kzhd15med3gh/prison"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.executables   = %w(prison)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"

  #added to realize that prison can use on the shell.

  root_path      = File.dirname(__FILE__)
  all_files      = Dir.chdir(root_path) { Dir.glob("**/{*,.*}") }
  all_files.reject! { |file| [".", ".."].include?(File.basename(file)) }
  all_files.reject! { |file| file.start_with?("website/") }
  gitignore_path = File.join(root_path, ".gitignore")
  gitignore      = File.readlines(gitignore_path)
  gitignore.map!    { |line| line.chomp.strip }
  gitignore.reject! { |line| line.empty? || line =~ /^(#|!)/ }

  unignored_files = all_files.reject do |file|
    # Ignore any directories, the gemspec only cares about files
    next true if File.directory?(file)

    # Ignore any paths that match anything in the gitignore. We do
    # two tests here:
    #
    #   - First, test to see if the entire path matches the gitignore.
    #   - Second, match if the basename does, this makes it so that things
    #     like '.DS_Store' will match sub-directories too (same behavior
    #     as git).
    #
    gitignore.any? do |ignore|
      File.fnmatch(ignore, file, File::FNM_PATHNAME) ||
        File.fnmatch(ignore, File.basename(file), File::FNM_PATHNAME)
    end
  end


  spec.files         = unignored_files
  # spec.executables   = unignored_files.map { |f| f[/^bin\/(.*)/, 1] }.compact
  spec.require_path  = 'lib'
end
