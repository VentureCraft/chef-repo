name             "artisan"
maintainer       "Venture Craft"
maintainer_email "chris@venturecraft.com.au"
license          "MIT"
description      "Runs artisan tasks"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ debian ubuntu redhat centos fedora scientific amazon }.each do |os|
supports os
end

depends "php"

recipe "artisan", "Runs artisan tasks"
