include_recipe 'kafka::common'
install_dir = node.default[:kafka][:install_dir] 

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


