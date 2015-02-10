name				"kafka"
maintainer        "Krave-n Inc."
maintainer_email  "dev-ops@krave-n.com"
license           "Copyright 2014 Krave-n Inc."
description       "Intalls and configures a Kafka broker"
version           "0.1"

depends           "java"
depends           "runit"

%w{ centos redhat amazon }.each do |os|
  supports os
end

