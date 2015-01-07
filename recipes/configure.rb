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

#hostname = node['hostname']
# kafka-01, get the 01 part
#hostNumber = hostname.split('-')[1].strip.to_i
#node.default[:kafka][:broker_id] = hostNumber

if node[:kafka][:broker_id].nil? || node[:kafka][:broker_id].empty?
	node.default[:kafka][:broker_id] = node[:ipaddress].gsub(".","")
end


%w[server.properties consumer.properties producer.properties log4j.properties].each do |template_file|
template "#{install_dir}/config/#{template_file}" do
	source "#{template_file}.erb"
	owner user
    group group
    mode  00755
    variables({
      :kafka => node[:kafka],
      :zookeeper_pairs => zookeeper_pairs,
    })
	notifies :restart, "runit_service[kafka]"
  end
end

#create sym link
link  "#{node[:kafka][:conf_link_dir]}" do
	to  "#{install_dir}/config/"	
end
