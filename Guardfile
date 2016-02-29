# Guardfile from http://www.cyrusstoller.com/2014/06/17/using-rspec-without-rails
guard 'rspec', cmd: "bundle exec rspec", :all_after_pass => false, 
  :failed_mode => :none do
  watch(%r{^spec/(.+)_spec\.rb$}) do |m|
  	"spec/#{m[1]}_spec.rb"
  end
  watch(%r{^lib/(.+)\.rb$}) do |m|
    "spec/lib/#{m[1]}_spec.rb"
  end
  watch('spec/spec_helper.rb')  { "spec" }
end