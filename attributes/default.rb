#
# Cookbook Name:: kafka
# Attributes:: default
#

# Install
default[:kafka][:version] = "0.8.2-beta"
default[:kafka][:version_scala] = "2.9.2"
default[:kafka][:mirror] = "http://www.us.apache.org/dist/kafka"
default[:kafka][:checksum] = "0e9e08bd8cec6d0720b13077f16eef1f3ddaa3cddce28f6b738b16780821db8b"

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
default[:kafka][:zk_sync_fallbehind_by] = 10000
default[:kafka][:zk_session_timeout] = 10000


default[:kafka][:user] = "kafka"
default[:kafka][:group] = "kafka"

# == Set Me in Environment / Stack
default[:kafka][:zookeeper_nodes] = Array['localhost:2181']

default[:kafka][:log4j_logging_level] = "INFO"
default[:kafka][:jmx_port] = 9010
