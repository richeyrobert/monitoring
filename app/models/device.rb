class Device < ActiveRecord::Base
	# RRD is needed for the Ping capability.
  require 'rrd'

  has_many :backups


	# This will be used to ping a device to see if it is available. 
	def ping
		result = `ping -c 1 #{ip_address}`
		# Now extract the time that it took for the ping to come back
		result = result.split("time=").last.split(" ").first
		return result
	end

  def get_config(device_type)
    # This will be used to ssh into a device and force it to drop a config file into out public tftp location.
    # This method will have to work for sever different types of devices
    case device_type
      when "cisco"
        # Device specific backup instructions
      when "brocade"
        # Device specific backup instructions
      when "telco"
        # Device specific backup instructions
      when "ubnt"
        # Device specific backup instructions
      when "netonix"
        # Device specific backup instructions
      when "mikrotik"
        get_mikrotik_config
      else
        # Device specific backup instructions
    end
  end

  def get_mikrotik_config
    # Mikrotik backup procedure:
    # 1. Use the Mikrotik API to log into the mikrotik and create 
    # => a. a system backup
    # => b. a config script backup
    # 2. FTP into the mikrotik and retrieve the two files that were created above
    # 3. Attach those files to the devices configurations model
    connection = MTik::command(host: '10.8.0.10', user: 'admin', pass: 'badass', command: ["/export", "=file=expf"])
    connection = MTik::command(host: '10.8.0.10', user: 'admin', pass: 'badass', command: ["/system/backup/save", "=name=test-bckp"])


    ftp = Net::FTP.new('10.8.0.10','admin','badass')
    ftp.getbinaryfile('test-bckp.backup','public/new-backup.backup')
    ftp.gettextfile('expf.rsc','public/configscript.rsc')



  end

  def ssh_reference
    require 'net/ssh/session'

    # Initialize a new connection
    session = Net::SSH::Session.new(host, user, password)

    # Initialize connection on a different SSH port
    session = Net::SSH::Session.new(host, user, password, :port => 5000)

    # Connect to server
    session.open

    # If you want to set a connection timeout in seconds
    # it will raise Timeout::Error 
    session.open(10)

    # Execute a remote command
    result = session.run("free -m")

    # Net::SSH::SessionCommand helpers
    result.success?  # => true
    result.failure?  # => false
    result.exit_code # => 0
    result.output    # => command output text
    result.duration  # => execution time, seconds

    # Capture command output
    session.capture('cat /etc/lsb-release')

    # File helpers
    session.file_exists?('/path')
    session.directory_exists?('/path')
    session.symlink_exists?('/path')
    session.read_file('/path')

    # Process helpers
    session.process_exists?(PID)
    session.kill_process(PID) # => true
    session.kill_process(PID, 'SIGINT') # => false
    session.last_exit_code # => 1

    # Environment helpers
    session.env('RAILS_ENV') # => production
    session.export('RAILS_ENV', 'production')
    session.export_hash(
      'RAILS_ENV' => 'test',
      'RACK_ENV'  => 'test'
    )

    # Execute a batch of commands
    session.run_multiple(
      'git clone git@foobar.com:project.git',
      'cd project',
      'bundle install',
      'rake test'
    )

    # Execute by calling a method
    session.ping("-c 5", "google.com")
    session.df('-h')

    # Execute as sudo
    session.sudo("whoami")

    # Execute with time limit (10s)
    begin
      session.with_timeout(10) do
        session.run('some long job')
      end
    rescue Timeout::Error
      puts "Operation took too long :("
    end

    # Execute a long command and show ongoing process
    session.run("rake test") do |str|
      puts str
    end

    # Get history, returns an array with Net::SSH::SessionCommand objects
    session.history.each do |cmd|
      puts cmd.to_s # => I, [2012-11-08T00:10:48.229986 #51878]  INFO -- : [bundle install --path .bundle] => 10, 35 bytes
      if cmd.success?
        # do your thing
      end
    end

    # Close current session
    session.close
  end

end
