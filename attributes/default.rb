#
# Cookbook Name:: kafka
# Attributes:: default
#

# Install
default[:kafka][:version] = "0.8.1.1"
default[:kafka][:version_scala] = "2.9.2"
default[:kafka][:mirror] = "http://www.us.apache.org/dist/kafka"
default[:kafka][:checksum] = "cb141c1d50b1bd0d741d68e5e21c090341d961cd801e11e42fb693fa53e9aaed"

default[:kafka][:install_root_dir] = "/opt/kafka"
default[:kafka][:data_dir] = "/vol/kafka/data"
default[:kafka][:log_dir] = "/var/log/kafka"
default[:kafka][:conf_link_dir] = "/etc/kafka"
#default[:kafka][:chroot_suffix] = "brokers"

default[:kafka][:aws][:zookeeper_layer] = "zookeeper"

default[:kafka][:num_partitions] = 1
default[:kafka][:broker_id] = nil
default[:kafka][:broker_host_name] = nil
default[:kafka][:port] = 9092

default[:kafka][:io_threads] = 4
default[:kafka][:network_threads] = 2
default[:kafka][:log_flush_interval] = 5
default[:kafka][:log_flush_time_interval] = 500
default[:kafka][:log_flush_scheduler_time_interval] = 1000
# retain forever
default[:kafka][:log_retention_hours] = 2147483647

#default[:kafka][:controlled_shutdown_enabled] = true
default[:kafka][:autocreate_topics] = false

# == Zookeeper
default[:kafka][:zk_connectiontimeout] = 120000
default[:kafka][:zk_sync_fallbehind_by] = 60000
default[:kafka][:zk_session_timeout] = 60000


default[:kafka][:user] = "kafka"
default[:kafka][:group] = "kafka"

# == Set Me in Environment / Stack
default[:kafka][:zookeeper_nodes] = Array['localhost:2181']

default[:kafka][:log4j_logging_level] = "INFO"
default[:kafka][:jmx_port] = 9010
default[:kafka][:env_vars] = {
	"KAFKA_OPTS" => "-Xms512M -Xmx512M -server -Djava.net.preferIPv4Stack=true -Dlog4j.configuration=file:#{node[:kafka][:conf_link_dir]}/log4j.properties"
}

default[:java][:install_flavor] = "oracle"
default[:java][:jdk_version] = "7"
default[:java][:oracle]["accept_oracle_download_terms"] = true
