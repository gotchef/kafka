full_version = "#{node[:kafka][:version_scala]}-#{node[:kafka][:version]}"
install_root_dir= "#{node[:kafka][:install_root_dir]}"
install_dir = "#{install_root_dir}/kafka_#{full_version}"

node.default[:kafka][:install_dir] =  install_dir
node.default[:kafka][:install_root_dir] = install_root_dir
node.default[:kafka][:full_version] =full_version




