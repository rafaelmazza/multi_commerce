on_app_servers_and_utilities do
  node[:applications].each do |app_name, data|
    echo "sleep 20 && monit -g #{app}_sidekiq restart all" | at now 
  end
end