require 'vagrant'

class Numeric
  Alphabet = ('a'..'z').to_a
  def vdev
    s = ''
    q = self
    (q, r = (q - 1).divmod(26)) && s.prepend(Alphabet[r]) until q.zero?
    'vd' + s
  end
end

module VagrantPlugins
  module ProviderLibvirt
    class Config < Vagrant.plugin('2', :config)
      # manually specify URI
      # will supercede most other options if provided
      attr_accessor :uri

      # A hypervisor name to access via Libvirt.
      attr_accessor :driver

      # The name of the server, where Libvirtd is running.
      attr_accessor :host

      # If use ssh tunnel to connect to Libvirt.
      attr_accessor :connect_via_ssh
      # Path towards the Libvirt socket
      attr_accessor :socket

      # The username to access Libvirt.
      attr_accessor :username

      # Password for Libvirt connection.
      attr_accessor :password

      # ID SSH key file
      attr_accessor :id_ssh_key_file

      attr_accessor :proxy_command

      # Libvirt storage pool name, where box image and instance snapshots will
      # be stored.
      attr_accessor :storage_pool_name
      attr_accessor :storage_pool_path

      # Libvirt storage pool where the base image snapshot shall be stored
      attr_accessor :snapshot_pool_name

      # Turn on to prevent hostname conflicts
      attr_accessor :random_hostname

      # Libvirt default network
      attr_accessor :management_network_device
      attr_accessor :management_network_name
      attr_accessor :management_network_address
      attr_accessor :management_network_mode
      attr_accessor :management_network_mac
      attr_accessor :management_network_guest_ipv6
      attr_accessor :management_network_autostart
      attr_accessor :management_network_pci_bus
      attr_accessor :management_network_pci_slot
      attr_accessor :management_network_domain

      # System connection information
      attr_accessor :system_uri

      # Default host prefix (alternative to use project folder name)
      attr_accessor :default_prefix

      # Domain specific settings used while creating new domain.
      attr_accessor :title
      attr_accessor :description
      attr_accessor :uuid
      attr_accessor :memory
      attr_accessor :nodeset
      attr_accessor :memory_backing
      attr_accessor :channel
      attr_accessor :cpus
      attr_accessor :cpuset
      attr_accessor :cpu_mode
      attr_accessor :cpu_model
      attr_accessor :cpu_fallback
      attr_accessor :cpu_features
      attr_accessor :cpu_topology
      attr_accessor :shares
      attr_accessor :features
      attr_accessor :features_hyperv
      attr_accessor :clock_offset
      attr_accessor :clock_timers
      attr_accessor :numa_nodes
      attr_accessor :loader
      attr_accessor :nvram
      attr_accessor :boot_order
      attr_accessor :machine_type
      attr_accessor :machine_arch
      attr_accessor :machine_virtual_size
      attr_accessor :disk_bus
      attr_accessor :disk_device
      attr_accessor :disk_driver_opts
      attr_accessor :nic_model_type
      attr_accessor :nested
      attr_accessor :volume_cache # deprecated, kept for backwards compatibility; use disk_driver
      attr_accessor :kernel
      attr_accessor :cmd_line
      attr_accessor :initrd
      attr_accessor :dtb
      attr_accessor :emulator_path
      attr_accessor :graphics_type
      attr_accessor :graphics_autoport
      attr_accessor :graphics_port
      attr_accessor :graphics_passwd
      attr_accessor :graphics_ip
      attr_accessor :video_type
      attr_accessor :video_vram
      attr_accessor :keymap
      attr_accessor :kvm_hidden
      attr_accessor :sound_type

      # Sets the information for connecting to a host TPM device
      # Only supports socket-based TPMs
      attr_accessor :tpm_model
      attr_accessor :tpm_type
      attr_accessor :tpm_path
      attr_accessor :tpm_version

      # Configure the memballoon
      attr_accessor :memballoon_enabled
      attr_accessor :memballoon_model
      attr_accessor :memballoon_pci_bus
      attr_accessor :memballoon_pci_slot

      # Sets the max number of NICs that can be created
      # Default set to 8. Don't change the default unless you know
      # what are doing
      attr_accessor :nic_adapter_count

      # Storage
      attr_accessor :disks
      attr_accessor :cdroms

      # Inputs
      attr_accessor :inputs

      # Channels
      attr_accessor :channels

      # PCI device passthrough
      attr_accessor :pcis

      # Random number device passthrough
      attr_accessor :rng

      # Watchdog device
      attr_accessor :watchdog_dev

      # USB controller
      attr_accessor :usbctl_dev

      # USB device passthrough
      attr_accessor :usbs

      # Redirected devices
      attr_accessor :redirdevs
      attr_accessor :redirfilters

      # smartcard device
      attr_accessor :smartcard_dev

      # Suspend mode
      attr_accessor :suspend_mode

      # Autostart
      attr_accessor :autostart

      # Attach mgmt network
      attr_accessor :mgmt_attach

      # Additional qemuargs arguments
      attr_accessor :qemu_args

      # Additional qemuenv arguments
      attr_accessor :qemu_env

      # Use QEMU session instead of system
      attr_accessor :qemu_use_session

      def initialize
        @uri               = UNSET_VALUE
        @driver            = UNSET_VALUE
        @host              = UNSET_VALUE
        @connect_via_ssh   = UNSET_VALUE
        @username          = UNSET_VALUE
        @password          = UNSET_VALUE
        @id_ssh_key_file   = UNSET_VALUE
        @socket            = UNSET_VALUE
        @proxy_command     = UNSET_VALUE
        @storage_pool_name = UNSET_VALUE
        @snapshot_pool_name = UNSET_VALUE
        @random_hostname   = UNSET_VALUE
        @management_network_device  = UNSET_VALUE
        @management_network_name    = UNSET_VALUE
        @management_network_address = UNSET_VALUE
        @management_network_mode = UNSET_VALUE
        @management_network_mac  = UNSET_VALUE
        @management_network_guest_ipv6 = UNSET_VALUE
        @management_network_autostart = UNSET_VALUE
        @management_network_pci_slot = UNSET_VALUE
        @management_network_pci_bus = UNSET_VALUE
        @management_network_domain = UNSET_VALUE

        # System connection information
        @system_uri      = UNSET_VALUE

        # Domain specific settings.
        @title             = UNSET_VALUE
        @description       = UNSET_VALUE
        @uuid              = UNSET_VALUE
        @memory            = UNSET_VALUE
        @nodeset           = UNSET_VALUE
        @memory_backing    = UNSET_VALUE
        @cpus              = UNSET_VALUE
        @cpuset            = UNSET_VALUE
        @cpu_mode          = UNSET_VALUE
        @cpu_model         = UNSET_VALUE
        @cpu_fallback      = UNSET_VALUE
        @cpu_features      = UNSET_VALUE
        @cpu_topology      = UNSET_VALUE
        @shares            = UNSET_VALUE
        @features          = UNSET_VALUE
        @features_hyperv   = UNSET_VALUE
        @clock_offset      = UNSET_VALUE
        @clock_timers      = []
        @numa_nodes        = UNSET_VALUE
        @loader            = UNSET_VALUE
        @nvram             = UNSET_VALUE
        @machine_type      = UNSET_VALUE
        @machine_arch      = UNSET_VALUE
        @machine_virtual_size = UNSET_VALUE
        @disk_bus          = UNSET_VALUE
        @disk_device       = UNSET_VALUE
        @disk_driver_opts  = {}
        @nic_model_type    = UNSET_VALUE
        @nested            = UNSET_VALUE
        @volume_cache      = UNSET_VALUE
        @kernel            = UNSET_VALUE
        @initrd            = UNSET_VALUE
        @dtb               = UNSET_VALUE
        @cmd_line          = UNSET_VALUE
        @emulator_path     = UNSET_VALUE
        @graphics_type     = UNSET_VALUE
        @graphics_autoport = UNSET_VALUE
        @graphics_port     = UNSET_VALUE
        @graphics_ip       = UNSET_VALUE
        @graphics_passwd   = UNSET_VALUE
        @video_type        = UNSET_VALUE
        @video_vram        = UNSET_VALUE
        @sound_type        = UNSET_VALUE
        @keymap            = UNSET_VALUE
        @kvm_hidden        = UNSET_VALUE

        @tpm_model         = UNSET_VALUE
        @tpm_type          = UNSET_VALUE
        @tpm_path          = UNSET_VALUE
        @tpm_version       = UNSET_VALUE

        @memballoon_enabled = UNSET_VALUE
        @memballoon_model   = UNSET_VALUE
        @memballoon_pci_bus = UNSET_VALUE
        @memballoon_pci_slot = UNSET_VALUE

        @nic_adapter_count = UNSET_VALUE

        # Boot order
        @boot_order        = []
        # Storage
        @disks             = []
        @cdroms            = []

        # Inputs
        @inputs            = UNSET_VALUE

        # Channels
        @channels          = UNSET_VALUE

        # PCI device passthrough
        @pcis              = UNSET_VALUE

        # Random number device passthrough
        @rng = UNSET_VALUE

        # Watchdog device
        @watchdog_dev      = UNSET_VALUE

        # USB controller
        @usbctl_dev        = UNSET_VALUE

        # USB device passthrough
        @usbs              = UNSET_VALUE

        # Redirected devices
        @redirdevs         = UNSET_VALUE
        @redirfilters      = UNSET_VALUE

        # smartcard device
        @smartcard_dev     = UNSET_VALUE

        # Suspend mode
        @suspend_mode      = UNSET_VALUE

        # Autostart
        @autostart         = UNSET_VALUE

        # Attach mgmt network
        @mgmt_attach       = UNSET_VALUE

        # Additional QEMU commandline arguments
        @qemu_args         = UNSET_VALUE

        # Additional QEMU commandline environment variables
        @qemu_env          = UNSET_VALUE

        @qemu_use_session  = UNSET_VALUE
      end

      def boot(device)
        @boot_order << device # append
      end

      def _get_device(disks)
        # skip existing devices and also the first one (vda)
        exist = disks.collect { |x| x[:device] } + [1.vdev.to_s]
        skip = 1 # we're 1 based, not 0 based...
        loop do
          dev = skip.vdev # get lettered device
          return dev unless exist.include?(dev)
          skip += 1
        end
      end

      def _get_cdrom_dev(cdroms)
        exist = Hash[cdroms.collect { |x| [x[:dev], true] }]
        # hda - hdc
        curr = 'a'.ord
        while curr <= 'd'.ord
          dev = 'hd' + curr.chr
          if exist[dev]
            curr += 1
            next
          else
            return dev
          end
        end

        # is it better to raise our own error, or let Libvirt cause the exception?
        raise 'Only four cdroms may be attached at a time'
      end

      def _generate_numa
        @numa_nodes.collect { |x|
          # Perform some validation of cpu values
          unless x[:cpus] =~ /^\d+-\d+$/
            raise 'numa_nodes[:cpus] must be in format "integer-integer"'
          end

          # Convert to KiB
          x[:memory] = x[:memory].to_i * 1024
        }

        # Grab the value of the last @numa_nodes[:cpus] and verify @cpus matches
        # Note: [:cpus] is zero based and @cpus is not, so we need to +1
        last_cpu = @numa_nodes.last[:cpus]
        last_cpu = last_cpu.scan(/\d+$/)[0]
        last_cpu = last_cpu.to_i + 1

        if @cpus != last_cpu.to_i
          raise 'The total number of numa_nodes[:cpus] must equal config.cpus'
        end

        @numa_nodes
      end

      def cpu_feature(options = {})
        if options[:name].nil? || options[:policy].nil?
          raise 'CPU Feature name AND policy must be specified'
        end

        @cpu_features = [] if @cpu_features == UNSET_VALUE

        @cpu_features.push(name:   options[:name],
                           policy: options[:policy])
      end

      def hyperv_feature(options = {})
        if options[:name].nil? || options[:state].nil?
          raise 'Feature name AND state must be specified'
        end

        @features_hyperv = []  if @features_hyperv == UNSET_VALUE

        @features_hyperv.push(name: options[:name],
                              state: options[:state])
      end

      def clock_timer(options = {})
        if options[:name].nil?
          raise 'Clock timer name must be specified'
        end

        options.each do |key, value|
          case key
            when :name, :track, :tickpolicy, :frequency, :mode, :present
              if value.nil?
                raise "Value of timer option #{key} is nil"
              end
            else
              raise "Unknown clock timer option: #{key}"
          end
        end

        @clock_timers.push(options.dup)
      end

      def cputopology(options = {})
        if options[:sockets].nil? || options[:cores].nil? || options[:threads].nil?
          raise 'CPU topology must have all of sockets, cores and threads specified'
        end

        if @cpu_topology == UNSET_VALUE
          @cpu_topology = {}
        end

        @cpu_topology[:sockets] = options[:sockets]
        @cpu_topology[:cores] = options[:cores]
        @cpu_topology[:threads] = options[:threads]
      end

      def memorybacking(option, config = {})
        case option
        when :source
          raise 'Source type must be specified' if config[:type].nil?
        when :access
          raise 'Access mode must be specified' if config[:mode].nil?
        when :allocation
          raise 'Allocation mode must be specified' if config[:mode].nil?
        end

        @memory_backing = [] if @memory_backing == UNSET_VALUE
        @memory_backing.push(name: option,
                             config: config)
      end

      def input(options = {})
        if options[:type].nil? || options[:bus].nil?
          raise 'Input type AND bus must be specified'
        end

        @inputs = [] if @inputs == UNSET_VALUE

        @inputs.push(type: options[:type],
                     bus:  options[:bus])
      end

      def channel(options = {})
        if options[:type].nil?
          raise 'Channel type must be specified.'
        elsif options[:type] == 'unix' && options[:target_type] == 'guestfwd'
          # Guest forwarding requires a target (ip address) and a port
          if options[:target_address].nil? || options[:target_port].nil? ||
             options[:source_path].nil?
            raise 'guestfwd requires target_address, target_port and source_path'
          end
        end

        @channels = [] if @channels == UNSET_VALUE

        @channels.push(type: options[:type],
                       source_mode: options[:source_mode],
                       source_path: options[:source_path],
                       target_address: options[:target_address],
                       target_name: options[:target_name],
                       target_port: options[:target_port],
                       target_type: options[:target_type])
      end

      def random(options = {})
        if !options[:model].nil? && options[:model] != 'random'
          raise 'The only supported rng backend is "random".'
        end

        @rng = {} if @rng == UNSET_VALUE

        @rng[:model] = options[:model]
      end

      def pci(options = {})
        if options[:bus].nil? || options[:slot].nil? || options[:function].nil?
          raise 'Bus AND slot AND function must be specified. Check `lspci` for that numbers.'
        end

        @pcis = [] if @pcis == UNSET_VALUE

        if options[:domain].nil?
          pci_domain = '0x0000'
        else
          pci_domain = options[:domain]
        end

        @pcis.push(domain:    pci_domain,
                   bus:       options[:bus],
                   slot:      options[:slot],
                   function:  options[:function])
      end

      def watchdog(options = {})
        if options[:model].nil?
          raise 'Model must be specified.'
        end

        if @watchdog_dev == UNSET_VALUE
            @watchdog_dev = {}
        end

        @watchdog_dev[:model] = options[:model]
        @watchdog_dev[:action] = options[:action] || 'reset'
      end


      def usb_controller(options = {})
        if options[:model].nil?
          raise 'USB controller model must be specified.'
        end

        if @usbctl_dev == UNSET_VALUE
            @usbctl_dev = {}
        end

        @usbctl_dev[:model] = options[:model]
        @usbctl_dev[:ports] = options[:ports]
      end

      def usb(options = {})
        if (options[:bus].nil? || options[:device].nil?) && options[:vendor].nil? && options[:product].nil?
          raise 'Bus and device and/or vendor and/or product must be specified. Check `lsusb` for these.'
        end

        @usbs = [] if @usbs == UNSET_VALUE

        @usbs.push(bus:           options[:bus],
                   device:        options[:device],
                   vendor:        options[:vendor],
                   product:       options[:product],
                   startupPolicy: options[:startupPolicy])
      end

      def redirdev(options = {})
        raise 'Type must be specified.' if options[:type].nil?

        @redirdevs = [] if @redirdevs == UNSET_VALUE

        @redirdevs.push(type: options[:type])
      end

      def redirfilter(options = {})
        raise 'Option allow must be specified.' if options[:allow].nil?

        @redirfilters = [] if @redirfilters == UNSET_VALUE

        @redirfilters.push(class: options[:class] || -1,
                           vendor: options[:vendor] || -1,
                           product: options[:product] || -1,
                           version: options[:version] || -1,
                           allow: options[:allow])
      end

      def smartcard(options = {})
        if options[:mode].nil?
          raise 'Option mode must be specified.'
        elsif options[:mode] != 'passthrough'
          raise 'Currently only passthrough mode is supported!'
        elsif options[:type] == 'tcp' && (options[:source_mode].nil? || options[:source_host].nil? || options[:source_service].nil?)
          raise 'If using type "tcp", option "source_mode", "source_host" and "source_service" must be specified.'
        end

        if @smartcard_dev == UNSET_VALUE
          @smartcard_dev = {}
        end

        @smartcard_dev[:mode] = options[:mode]
        @smartcard_dev[:type] = options[:type] || 'spicevmc'
        @smartcard_dev[:source_mode] = options[:source_mode] if @smartcard_dev[:type] == 'tcp'
        @smartcard_dev[:source_host] = options[:source_host] if @smartcard_dev[:type] == 'tcp'
        @smartcard_dev[:source_service] = options[:source_service] if @smartcard_dev[:type] == 'tcp'
      end

      # Disk driver options for primary disk
      def disk_driver(options = {})
        supported_opts = [:cache, :io, :copy_on_read, :discard, :detect_zeroes]
        @disk_driver_opts = options.select { |k,_| supported_opts.include? k }
      end

      # NOTE: this will run twice for each time it's needed- keep it idempotent
      def storage(storage_type, options = {})
        if storage_type == :file
          if options[:device] == :cdrom
            _handle_cdrom_storage(options)
          else
            _handle_disk_storage(options)
          end
        end
      end

      def _handle_cdrom_storage(options = {})
        # <disk type="file" device="cdrom">
        #   <source file="/home/user/virtio-win-0.1-100.iso"/>
        #   <target dev="hdc"/>
        #   <readonly/>
        #   <address type='drive' controller='0' bus='1' target='0' unit='0'/>
        # </disk>
        #
        # note the target dev will need to be changed with each cdrom drive (hdc, hdd, etc),
        # as will the address unit number (unit=0, unit=1, etc)

        options = {
          bus: 'ide',
          path: nil
        }.merge(options)

        cdrom = {
          dev: options[:dev],
          bus: options[:bus],
          path: options[:path]
        }

        @cdroms << cdrom
      end

      def _handle_disk_storage(options = {})
        options = {
          type: 'qcow2',
          size: '10G', # matches the fog default
          path: nil,
          bus: 'virtio'
        }.merge(options)

        disk = {
          device: options[:device],
          type: options[:type],
          size: options[:size],
          path: options[:path],
          bus: options[:bus],
          cache: options[:cache] || 'default',
          allow_existing: options[:allow_existing],
          shareable: options[:shareable],
          serial: options[:serial],
          io: options[:io],
          copy_on_read: options[:copy_on_read],
          discard: options[:discard],
          detect_zeroes: options[:detect_zeroes],
          pool: options[:pool], # overrides storage_pool setting for additional disks
          wwn: options[:wwn],
        }

        @disks << disk # append
      end

      def qemuargs(options = {})
        @qemu_args = [] if @qemu_args == UNSET_VALUE

        @qemu_args << options if options[:value]
      end

      def qemuenv(options = {})
        @qemu_env = {} if @qemu_env == UNSET_VALUE

        @qemu_env.merge!(options)
      end

      def _default_uri
        # Determine if any settings except driver provided explicitly, if not
        # and the LIBVIRT_DEFAULT_URI var is set, use that.
        #
        # Skipping driver because that may be set on individual boxes rather
        # than by the user.
        if [
            @connect_via_ssh, @host, @username, @password,
            @id_ssh_key_file, @qemu_use_session, @socket,
        ].none?{ |v| v != UNSET_VALUE }
          if ENV.fetch('LIBVIRT_DEFAULT_URI', '') != ""
            @uri = ENV['LIBVIRT_DEFAULT_URI']
          end
        end
      end

      # code to generate URI from from either the LIBVIRT_URI environment
      # variable or a config moved out of the connect action
      def _generate_uri(qemu_use_session)
        # builds the Libvirt connection URI from the given driver config
        # Setup connection uri.
        uri = @driver.dup
        virt_path = case uri
                    when 'qemu', 'kvm'
                      qemu_use_session ? '/session' : '/system'
                    when 'openvz', 'uml', 'phyp', 'parallels'
                      '/system'
                    when '@en', 'esx'
                      '/'
                    when 'vbox', 'vmwarews', 'hyperv'
                      '/session'
                    else
                      raise "Require specify driver #{uri}"
        end
        if uri == 'kvm'
          uri = 'qemu' # use QEMU uri for KVM domain type
        end

        # turn on ssh if an ssh key file is explicitly provided
        if @connect_via_ssh == UNSET_VALUE && @id_ssh_key_file && @id_ssh_key_file != UNSET_VALUE
          @connect_via_ssh = true
        end

        params = {}

        if @connect_via_ssh == true
          finalize_id_ssh_key_file

          uri << '+ssh://'
          uri << @username + '@' if @username && @username != UNSET_VALUE

          uri << ( @host && @host != UNSET_VALUE ? @host : 'localhost' )

          params['no_verify'] = '1'
          params['keyfile'] = @id_ssh_key_file if @id_ssh_key_file
        else
          uri << '://'
          uri << @host if @host && @host != UNSET_VALUE
        end

        uri << virt_path

        # set path to Libvirt socket
        params['socket'] = @socket if @socket

        uri << "?" + params.map{|pair| pair.join('=')}.join('&') if !params.empty?
        uri
      end

      def _parse_uri(uri)
        begin
          URI.parse(uri)
        rescue
          raise "@uri set to invalid uri '#{uri}'"
        end
      end

      def finalize!
        _default_uri if @uri == UNSET_VALUE

        # settings which _generate_uri
        @driver = 'kvm' if @driver == UNSET_VALUE
        @password = nil if @password == UNSET_VALUE
        @socket = nil if @socket == UNSET_VALUE

        # If uri isn't set then let's build one from various sources.
        # Default to passing false for qemu_use_session if it's not set.
        if @uri == UNSET_VALUE
          @uri = _generate_uri(@qemu_use_session == UNSET_VALUE ? false : @qemu_use_session)
        end

        finalize_from_uri
        finalize_proxy_command

        @storage_pool_name = 'default' if @storage_pool_name == UNSET_VALUE
        @snapshot_pool_name = @storage_pool_name if @snapshot_pool_name == UNSET_VALUE
        @storage_pool_path = nil if @storage_pool_path == UNSET_VALUE
        @random_hostname = false if @random_hostname == UNSET_VALUE
        @management_network_device = 'virbr0' if @management_network_device == UNSET_VALUE
        @management_network_name = 'vagrant-libvirt' if @management_network_name == UNSET_VALUE
        @management_network_address = '192.168.121.0/24' if @management_network_address == UNSET_VALUE
        @management_network_mode = 'nat' if @management_network_mode == UNSET_VALUE
        @management_network_mac = nil if @management_network_mac == UNSET_VALUE
        @management_network_guest_ipv6 = 'yes' if @management_network_guest_ipv6 == UNSET_VALUE
        @management_network_autostart = false if @management_network_autostart == UNSET_VALUE
        @management_network_pci_bus = nil if @management_network_pci_bus == UNSET_VALUE
        @management_network_pci_slot = nil if @management_network_pci_slot == UNSET_VALUE
        @management_network_domain = nil if @management_network_domain == UNSET_VALUE
        @system_uri      = 'qemu:///system' if @system_uri == UNSET_VALUE

        # Domain specific settings.
        @title = '' if @title == UNSET_VALUE
        @description = '' if @description == UNSET_VALUE
        @uuid = '' if @uuid == UNSET_VALUE
        @memory = 512 if @memory == UNSET_VALUE
        @nodeset = nil if @nodeset == UNSET_VALUE
        @memory_backing = [] if @memory_backing == UNSET_VALUE
        @cpus = 1 if @cpus == UNSET_VALUE
        @cpuset = nil if @cpuset == UNSET_VALUE
        @cpu_mode = 'host-model' if @cpu_mode == UNSET_VALUE
        @cpu_model = if (@cpu_model == UNSET_VALUE) && (@cpu_mode == 'custom')
                       'qemu64'
                     elsif @cpu_mode != 'custom'
                       ''
                     else
                       @cpu_model
          end
        @cpu_topology = {} if @cpu_topology == UNSET_VALUE
        @cpu_fallback = 'allow' if @cpu_fallback == UNSET_VALUE
        @cpu_features = [] if @cpu_features == UNSET_VALUE
        @shares = nil if @shares == UNSET_VALUE
        @features = ['acpi','apic','pae'] if @features == UNSET_VALUE
        @features_hyperv = [] if @features_hyperv == UNSET_VALUE
        @clock_offset = 'utc' if @clock_offset == UNSET_VALUE
        @clock_timers = [] if @clock_timers == UNSET_VALUE
        @numa_nodes = @numa_nodes == UNSET_VALUE ? nil : _generate_numa
        @loader = nil if @loader == UNSET_VALUE
        @nvram = nil if @nvram == UNSET_VALUE
        @machine_type = nil if @machine_type == UNSET_VALUE
        @machine_arch = nil if @machine_arch == UNSET_VALUE
        @machine_virtual_size = nil if @machine_virtual_size == UNSET_VALUE
        @disk_bus = 'virtio' if @disk_bus == UNSET_VALUE
        @disk_device = 'vda' if @disk_device == UNSET_VALUE
        @disk_driver_opts = {} if @disk_driver_opts == UNSET_VALUE
        @nic_model_type = nil if @nic_model_type == UNSET_VALUE
        @nested = false if @nested == UNSET_VALUE
        @volume_cache = nil if @volume_cache == UNSET_VALUE
        @kernel = nil if @kernel == UNSET_VALUE
        @cmd_line = '' if @cmd_line == UNSET_VALUE
        @initrd = '' if @initrd == UNSET_VALUE
        @dtb = nil if @dtb == UNSET_VALUE
        @graphics_type = 'vnc' if @graphics_type == UNSET_VALUE
        @graphics_autoport = 'yes' if @graphics_port == UNSET_VALUE
        @graphics_autoport = 'no' if @graphics_port != UNSET_VALUE
        if (@graphics_type != 'vnc' && @graphics_type != 'spice') ||
           @graphics_passwd == UNSET_VALUE
          @graphics_passwd = nil
        end
        @graphics_port = -1 if @graphics_port == UNSET_VALUE
        @graphics_ip = '127.0.0.1' if @graphics_ip == UNSET_VALUE
        @video_type = 'cirrus' if @video_type == UNSET_VALUE
        @video_vram = 9216 if @video_vram == UNSET_VALUE
        @sound_type = nil if @sound_type == UNSET_VALUE
        @keymap = 'en-us' if @keymap == UNSET_VALUE
        @kvm_hidden = false if @kvm_hidden == UNSET_VALUE
        @tpm_model = 'tpm-tis' if @tpm_model == UNSET_VALUE
        @tpm_type = 'passthrough' if @tpm_type == UNSET_VALUE
        @tpm_path = nil if @tpm_path == UNSET_VALUE
        @tpm_version = nil if @tpm_version == UNSET_VALUE
        @memballoon_enabled = nil if @memballoon_enabled == UNSET_VALUE
        @memballoon_model = 'virtio' if @memballoon_model == UNSET_VALUE
        @memballoon_pci_bus = '0x00' if @memballoon_pci_bus == UNSET_VALUE
        @memballoon_pci_slot = '0x0f' if @memballoon_pci_slot == UNSET_VALUE
        @nic_adapter_count = 8 if @nic_adapter_count == UNSET_VALUE
        @emulator_path = nil if @emulator_path == UNSET_VALUE

        # Boot order
        @boot_order = [] if @boot_order == UNSET_VALUE

        # Storage
        @disks = [] if @disks == UNSET_VALUE
        @disks.map! do |disk|
          disk[:device] = _get_device(@disks) if disk[:device].nil?
          disk
        end
        @cdroms = [] if @cdroms == UNSET_VALUE
        @cdroms.map! do |cdrom|
          cdrom[:dev] = _get_cdrom_dev(@cdroms) if cdrom[:dev].nil?
          cdrom
        end

        # Inputs
        @inputs = [{ type: 'mouse', bus: 'ps2' }] if @inputs == UNSET_VALUE

        # Channels
        @channels = [] if @channels == UNSET_VALUE

        # PCI device passthrough
        @pcis = [] if @pcis == UNSET_VALUE

        # Random number generator passthrough
        @rng = {} if @rng == UNSET_VALUE

        # Watchdog device
        @watchdog_dev = {} if @watchdog_dev == UNSET_VALUE

        # USB controller
        @usbctl_dev = {} if @usbctl_dev == UNSET_VALUE

        # USB device passthrough
        @usbs = [] if @usbs == UNSET_VALUE

        # Redirected devices
        @redirdevs = [] if @redirdevs == UNSET_VALUE
        @redirfilters = [] if @redirfilters == UNSET_VALUE

        # smartcard device
        @smartcard_dev = {} if @smartcard_dev == UNSET_VALUE

        # Suspend mode
        @suspend_mode = 'pause' if @suspend_mode == UNSET_VALUE

        # Autostart
        @autostart = false if @autostart == UNSET_VALUE

        # Attach mgmt network
        @mgmt_attach = true if @mgmt_attach == UNSET_VALUE

        # Additional QEMU commandline arguments
        @qemu_args = [] if @qemu_args == UNSET_VALUE

        # Additional QEMU commandline environment variables
        @qemu_env = {} if @qemu_env == UNSET_VALUE
      end

      def validate(machine)
        errors = _detected_errors

        # The @uri and @qemu_use_session should not conflict
        uri = _parse_uri(@uri)
        if (uri.scheme.start_with? "qemu") && (uri.path.include? "session")
          if @qemu_use_session != true
            errors << "the URI and qemu_use_session configuration conflict: uri:'#{@uri}' qemu_use_session:'#{@qemu_use_session}'"
          end
        end

        machine.provider_config.disks.each do |disk|
          if disk[:path] && (disk[:path][0] == '/')
            errors << "absolute volume paths like '#{disk[:path]}' not yet supported"
          end
        end

        machine.config.vm.networks.each do |_type, opts|
          if opts[:mac]
            opts[:mac].downcase!
            if opts[:mac] =~ /\A([0-9a-f]{12})\z/
              opts[:mac] = opts[:mac].scan(/../).join(':')
            end
            unless opts[:mac] =~ /\A([0-9a-f]{2}:){5}([0-9a-f]{2})\z/
              errors << "Configured NIC MAC '#{opts[:mac]}' is not in 'xx:xx:xx:xx:xx:xx' or 'xxxxxxxxxxxx' format"
            end
          end
        end

        if !machine.provider_config.volume_cache.nil? and machine.provider_config.volume_cache != UNSET_VALUE
          machine.ui.warn("Libvirt Provider: volume_cache is deprecated. Use disk_driver :cache => '#{machine.provider_config.volume_cache}' instead.")

          if !machine.provider_config.disk_driver_opts.empty?
            machine.ui.warn("Libvirt Provider: volume_cache has no effect when disk_driver is defined.")
          end
        end

        { 'Libvirt Provider' => errors }
      end

      def merge(other)
        super.tap do |result|
          c = disks.dup
          c += other.disks
          result.disks = c

          c = cdroms.dup
          c += other.cdroms
          result.cdroms = c

          result.disk_driver_opts = disk_driver_opts.merge(other.disk_driver_opts)
          
          c = clock_timers.dup
          c += other.clock_timers
          result.clock_timers = c

          c = qemu_env != UNSET_VALUE ? qemu_env.dup : {}
          c.merge!(other.qemu_env) if other.qemu_env != UNSET_VALUE
          result.qemu_env = c
        end
      end

      private

      def finalize_from_uri
        # Parse uri to extract individual components
        uri = _parse_uri(@uri)

        # only set @connect_via_ssh if not explicitly to avoid overriding
        # and allow an error to occur if the @uri and @connect_via_ssh disagree
        @connect_via_ssh = uri.scheme.include? "ssh" if @connect_via_ssh == UNSET_VALUE

        # Set qemu_use_session based on the URI if it wasn't set by the user
        if @qemu_use_session == UNSET_VALUE
          if (uri.scheme.start_with? "qemu") && (uri.path.include? "session")
            @qemu_use_session = true
          else
            @qemu_use_session = false
          end
        end

        # Extract host and username values from uri if provided, otherwise nil
        @host = uri.host
        @username = uri.user

        finalize_id_ssh_key_file
      end

      def resolve_ssh_key_file(key_file)
        # set ssh key for access to Libvirt host
        # if no slash, prepend $HOME/.ssh/
        key_file.prepend("#{ENV['HOME']}/.ssh/") if key_file && key_file !~ /\A\//

        key_file
      end

      def finalize_id_ssh_key_file
        # resolve based on the following roles
        #  1) if @connect_via_ssh is set to true, and id_ssh_key_file not current set,
        #     set default if the file exists
        #  2) if supplied the key name, attempt to expand based on user home
        #  3) otherwise set to nil

        if @connect_via_ssh == true && @id_ssh_key_file == UNSET_VALUE
          # set default if using ssh while allowing a user using nil to disable this
          id_ssh_key_file = resolve_ssh_key_file('id_rsa')
          id_ssh_key_file = nil if !File.file?(id_ssh_key_file)
        elsif @id_ssh_key_file != UNSET_VALUE
          id_ssh_key_file = resolve_ssh_key_file(@id_ssh_key_file)
        else
          id_ssh_key_file = nil
        end

        @id_ssh_key_file = id_ssh_key_file
      end

      def finalize_proxy_command
        if @connect_via_ssh
          if @proxy_command == UNSET_VALUE
            proxy_command = "ssh '#{@host}' "
            proxy_command << "-l '#{@username}' " if @username
            proxy_command << "-i '#{@id_ssh_key_file}' " if @id_ssh_key_file
            proxy_command << '-W %h:%p'
          else
            inputs = { host: @host }
            inputs[:username] = @username if @username
            inputs[:id_ssh_key_file] = @id_ssh_key_file if @id_ssh_key_file

            proxy_command = @proxy_command
            # avoid needing to escape '%' symbols
            inputs.each do |key, value|
              proxy_command.gsub!("{#{key}}", value)
            end
          end

          @proxy_command = proxy_command
        else
          @proxy_command = nil
        end
      end
    end
  end
end
