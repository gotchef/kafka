#
# Cookbook Name::	kafka
# Description:: Base configuration for Kafka
# Recipe:: default
#

# == Recipes
include_recipe "java"
include_recipe "runit"

runit_service "kafka" do
	action :nothing
end

user = node[:kafka][:user]
group = node[:kafka][:group]

if node[:kafka][:broker_id].nil? || node[:kafka][:broker_id].empty?
    node.override[:kafka][:broker_id] = node[:ipaddress].gsub(".","")
end

if node[:kafka][:broker_host_name].nil? || node[:kafka][:broker_host_name].empty?
    node.override[:kafka][:broker_host_name] = node[:fqdn]
end

log "Broker id: #{node[:kafka][:broker_id]}"
log "Broker name: #{node[:kafka][:broker_host_name]}"

# == Users

# setup kafka group
group group do
end

# setup kafka user
user user do
  comment "Kafka user"
  gid "kafka"
  home "/home/kafka"
  shell "/bin/noshell"
  supports :manage_home => false
end

# == Directories

include_recipe 'kafka::common'
install_dir = node[:kafka][:install_dir] 

directory "#{install_root_dir}" do
  owner "root"
  group "root"
  mode 00755
  recursive true
  action :create
end

# create the log directory
directory node[:kafka][:log_dir] do
  owner   user
  group   group
  mode    00755
  recursive true
  action :create
end

# create the data directory
directory node[:kafka][:data_dir] do
  owner   user
  group   group
  mode    00755
  recursive true
  action :create
end

# pull the remote file 
tarball = "kafka_#{full_version}.tgz"
download_file = "#{node[:kafka][:mirror]}/#{node[:kafka][:version]}/#{tarball}"

log download_file

remote_file "#{Chef::Config[:file_cache_path]}/#{tarball}" do
  source download_file
  mode "775"
  checksum node[:kafka][:checksum]
end

execute "tar" do
  user  "root"
  group "root"
  cwd install_root_dir
  command "tar zxvf #{Chef::Config[:file_cache_path]}/#{tarball}"
end

# overwrite existing file
template_file = "kafka-run-class.sh"
template "#{install_dir}/bin/#{template_file}" do
    source	"#{template_file}.erb"
    owner "root"
    group "root"
    mode  00755
    variables({
      :log_dir => node[:kafka][:log_dir],
    })
	notifies :restart, "runit_service[kafka]"
end

template_file = "kafka-server-start.sh"
template "#{install_dir}/bin/#{template_file}" do
    source	"#{template_file}.erb"
    owner "root"
    group "root"
    mode  00755
    variables({
      :log_dir => node[:kafka][:log_dir],
    })
	notifies :restart, "runit_service[kafka]"
	
end


# create collectd plugin for kafka JMX objects if collectd has been applied.
if node.attribute?("collectd")
  template "#{node[:collectd][:plugin_conf_dir]}/collectd_kafka-broker.conf" do
    source "collectd_kafka-broker.conf.erb"
    owner "root"
    group "root"
    mode 00644
    notifies :restart, resources(:service => "collectd")
  end
	notifies :restart, "runit_service[kafka]"
  
end
