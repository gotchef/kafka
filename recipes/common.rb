node.default[:kafka][:full_version] = "#{node[:kafka][:version_scala]}-#{node[:kafka][:version]}"
node.default[:kafka][:install_root_dir] = "#{node[:kafka][:install_root_dir]}"
node.default[:kafka][:install_dir]  = "#{install_root_dir}/kafka_#{full_version}"



