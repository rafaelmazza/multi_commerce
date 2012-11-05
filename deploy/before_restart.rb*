on_app_servers_and_utilities do
  node[:applications].each do |app_name, data|
    run "sudo monit restart all -g redis"
    run "sudo monit restart all -g sidekiq_multi_commerce_0"
  end
end