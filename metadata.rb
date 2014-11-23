name			"kafka"
maintainer        "Krave-n Inc."
maintainer_email  "dev-ops@krave-n.com"
license           "Copyright 2014 Krave-n Inc."
description       "Intalls and configures a Kafka broker"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.20"

depends           "java"
depends           "runit"
depends           "zookeeper"

recipe	"kafka::default",		"Base configuration for kafka"

%w{ centos redhat amazon }.each do |os|
  supports os
end

