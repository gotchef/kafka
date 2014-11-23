full_version = "#{node[:kafka][:version_scala]}-#{node[:kafka][:version]}"
install_root_dir= "#{node[:kafka][:install_root_dir]}"
install_dir = "#{install_root_dir}/kafka_#{full_version}"

template "#{install_dir}/bin/service-control" do
  source  "service-control.erb"
  owner "root"
  group "root"
  mode  00755
  variables({
    :install_dir => install_dir,
    :log_dir => node[:kafka][:log_dir],
    :java_home =>  node['java']['java_home'] ,
    :java_jmx_port => node[:kafka][:jmx_port],
    :java_class => "kafka.Kafka",
    :user => user
  })
end

runit_service "kafka" do
	default_logger true
	action [:enable, :start] 
end


