#
# kafka::config_files
#
include_recipe "runit"
include_recipe "kafka::opsworks_hosts"

runit_service "kafka" do
	action :nothing
end


install_root_dir = node[:kafka][:install_root_dir]
version_dir = "kafka_#{node[:kafka][:version_scala]}-#{node[:kafka][:version]}"
install_dir = "#{install_root_dir}/#{version_dir}"

zookeeper_pairs = node[:kafka][:zookeeper_nodes]

directory "#{node[:kafka][:conf_link_dir]}" do
  owner "root"
  group "root"
  mode '00755'
  recursive true
  action :create
end

hostname = node['hostname']
# kafka-01, get the 01 part
hostNumber = hostname.split('-')[1].strip.to_i
node.default[:kafka][:broker_id] = hostNumber

%w[server.properties log4j.properties].each do |template_file|
template "#{install_dir}/config/#{template_file}" do
	source "#{template_file}.erb"
	owner user
    group group
    mode  00755
    variables({
      :kafka => node[:kafka],
      :zookeeper_pairs => zookeeper_pairs,
      :client_port => node[:zookeeper][:client_port]
    })
	notifies :restart, "runit_service[kafka]"
  end
end

config = "server.properties"
configPath =  "#{install_dir}/config/#{config}" 

#create sym link
link  "#{node[:kafka][:conf_link_dir]}/#{config}" do
	to configPath	
end

logConfig = "log4j.properties"
logPath = "#{install_dir}/config/#{logConfig}"

link  "#{node[:kafka][:conf_link_dir]}/#{logConfig}" do
	to logPath	
end
