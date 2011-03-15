set :application_name, "Flat 10C" 
set :iphone_hostname, "nathans-iphone" 
set :user, "root" 
set :escaped_name, application_name.gsub(" ", '\ ')
set :build_dir, "/Users/ndbroadbent/src/#{application_name}/build/Release-iphoneos"

desc "Package your iPhone application" 
task :package do
  puts "== Packaging application."
  %x[cd "#{build_dir}" && \
    tar -czpvf #{escaped_name}.tar.gz #{escaped_name}.app]
  puts "== Transferring to iPhone (#{iphone_hostname}).."
  %x[cd "#{build_dir}" && \
     scp #{escaped_name}.tar.gz #{user}@#{iphone_hostname}:/Applications]
  puts "===== Transferred."
end

desc "Install the application on your iPhone" 
task :install, :hosts => "#{iphone_hostname}" do
  run <<-CMD
    cd /Applications/;
    tar -xzpvf #{escaped_name}.tar.gz;
    rm #{escaped_name}.tar.gz;
    killall SpringBoard;                  # OS 4.x
  CMD
end

desc "Package and install the application on your iPhone" 
task :deploy, :hosts => "#{iphone_hostname}" do
  package
  install
end
