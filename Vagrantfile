# frozen_string_literal: true

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker' # otherwise 'virtualbox', no good for wsl
Vagrant.configure('2') do |config|
  config.ssh.insert_key = false
  config.ssh.username   = 'root'
  config.ssh.password   = 'root'

  config.hostmanager.enabled      = true
  config.hostmanager.manage_guest = true

  # cannot use in WSL
  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.provider 'docker' do |d|
    d.build_dir       = '.'
    d.has_ssh         = true
    d.remains_running = true
  end

  config.vm.hostname = 'collectionspace.local'
  # we use port 80 to avoid cspace-ui CORS complications
  config.vm.network 'forwarded_port', guest: 80, host: 80, host_ip: '127.0.0.1', auto_correct: true
  config.vm.provision :hostmanager
  config.vm.provision :ansible do |ansible|
    ansible.become = true
    ansible.extra_vars = { ansible_user: 'root', ansible_password: 'root', collectionspace_vagrant: true }
    ansible.playbook = 'collectionspace.yml'
    ansible.raw_arguments = ['-e', '@vars/deploy.yml']
  end
end
