class BT < Fog::Bin
  class << self

    def class_for(key)
      case key
      when :compute, :ec2
        Fog::BT::Compute
      else
        # @todo Replace most instances of ArgumentError with NotImplementedError
        # @todo For a list of widely supported Exceptions, see:
        # => http://www.zenspider.com/Languages/Ruby/QuickRef.html#35
        raise ArgumentError, "Unsupported #{self} service: #{key}"
      end
    end

    def [](service)
      @@connections ||= Hash.new do |hash, key|
        hash[key] = case key
        when :compute
          Fog::Compute.new(:provider => 'BT')
        when :ec2
          location = caller.first
          warning = "[yellow][WARN] BT[:ec2] is deprecated, use BT[:compute] instead[/]"
          warning << " [light_black](" << location << ")[/] "
          Formatador.display_line(warning)
          Fog::Compute.new(:provider => 'BT')
        else
          raise ArgumentError, "Unrecognized service: #{service}"
        end
      end
      @@connections[service]
    end

    def services
      [:compute]
    end

  end
end

