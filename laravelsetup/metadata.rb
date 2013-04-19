name             "laravelsetup"
maintainer       "VentureCraft"
maintainer_email "me@chrisduell.com"
license          "MIT"
description      "Sets up laravel to work on a new box"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ debian ubuntu redhat centos fedora scientific amazon }.each do |os|
supports os
end

depends "php"

recipe "laravelsetup", "Sets up laravel permissions and runs composer install."
