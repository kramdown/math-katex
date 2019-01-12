# -*- ruby -*-

require 'rubygems/package_task'
require 'fileutils'
require 'rake/clean'
require 'rake/testtask'
require_relative 'lib/kramdown/converter/math_engine/katex'

task :default => :test
Rake::TestTask.new do |test|
  test.warning = false
  test.libs << 'test'
  test.test_files = FileList['test/test_*.rb']
end

desc "Update kramdown KaTeX test reference outputs"
task :update_katex_tests do
  # Not framed in terms of rake file tasks to prevent accidental overwrites.
  Dir['test/testcases/*.text'].each do |f|
    stem = f[0..-6] # Remove .text
    ruby "-Ilib -S kramdown --config-file #{stem}.options #{f} >#{stem}.html"
  end
end


SUMMARY = 'kramdown-math-katex uses KaTeX to convert math elements to HTML on the server side'

PKG_FILES = FileList.new(['COPYING', 'VERSION', 'CONTRIBUTERS', 'lib/**/*.rb', 'test/**/*'])

CLOBBER << "VERSION"
file 'VERSION' do
  puts "Generating VERSION file"
  File.open('VERSION', 'w+') {|file| file.write(Kramdown::Converter::MathEngine::Katex::VERSION + "\n")}
end

CLOBBER << 'CONTRIBUTERS'
file 'CONTRIBUTERS' do
  puts "Generating CONTRIBUTERS file"
  `echo "  Count Name" > CONTRIBUTERS`
  `echo "======= ====" >> CONTRIBUTERS`
  `git log | grep ^Author: | sed 's/^Author: //' | sort | uniq -c | sort -nr >> CONTRIBUTERS`
end

spec = Gem::Specification.new do |s|
  s.name = 'kramdown-math-katex'
  s.version = Kramdown::Converter::MathEngine::Katex::VERSION
  s.summary = SUMMARY
  s.license = 'MIT'

  s.files = PKG_FILES.to_a

  s.require_path = 'lib'
  s.required_ruby_version = '>= 2.3'
  s.add_dependency 'kramdown', '~> 2.0'
  s.add_dependency 'katex', '~> 0.4.3'

  s.has_rdoc = true

  s.author = 'Thomas Leitner'
  s.email = 't_leitner@gmx.at'
  s.homepage = "https://github.com/kramdown/math-katex"
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

task :gemspec => ['CONTRIBUTERS', 'VERSION'] do
  print "Generating Gemspec\n"
  contents = spec.to_ruby
  File.write("kramdown-math-katex.gemspec", contents, mode: 'w+')
end
CLOBBER << 'kramdown-math-katex.gemspec'

desc 'Release version ' + Kramdown::Converter::MathEngine::Katex::VERSION
task :release => [:clobber, :package, :publish_files]

desc "Upload the release to Rubygems"
task :publish_files => [:package] do
  sh "gem push pkg/kramdown-math-katex-#{Kramdown::Converter::MathEngine::Katex::VERSION}.gem"
  puts 'done'
end
