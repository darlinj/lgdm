module Fog
  module BT
    class Compute < Fog::Service

      # http://docs.amazonwebservices.com/AWSEC2/2008-12-01/DeveloperGuide/
      # apparently pi also supports version 2009-04-04

      requires   :bt_access_key_id, :bt_secret_access_key
      recognizes :region, :provider

      model_path  'fog/compute/models/bt'
      model       :address
      collection  :addresses
      model       :flavor
      collection  :flavors
      model       :image
      collection  :images
      model       :key_pair
      collection  :key_pairs
      model       :security_group
      collection  :security_groups
      model       :server
      collection  :servers

      request_path 'fog/compute/requests/bt'
      request :allocate_address
      request :authorize_security_group_ingress
      request :associate_address
      request :create_key_pair
      request :create_security_group
      request :delete_key_pair
      request :delete_security_group
      request :describe_addresses
      request :describe_images
      request :describe_instances
      request :describe_key_pairs
      request :describe_security_groups
      request :disassociate_address
      request :get_console_output
      request :reboot_instances
      request :release_address
      request :revoke_security_group_ingress
      request :run_instances
      request :terminate_instances

      class Real

        def initialize(options={})
          unless options.delete(:provider)
            location = caller.first
            warning = "[yellow][WARN] Fog::BT::Compute.new is deprecated, use Fog::Compute.new(:provider => 'BT') instead[/]"
            warning << " [light_black](" << location << ")[/] "
            Formatador.display_line(warning)
          end

          @bt_access_key_id      = options[:bt_access_key_id]
          @bt_secret_access_key  = options[:bt_secret_access_key]
          @hmac                  = Fog::HMAC.new('sha256', @bt_secret_access_key)
          if @endpoint = options[:endpoint]
            endpoint  = URI.parse(@endpoint)
            @host     = endpoint.host
            @path     = endpoint.path
            @port     = endpoint.port
            @scheme   = endpoint.scheme
          else
            options[:region] ||= 'pi-lax'
            @host = options[:host] || case options[:region]
            when 'pi-lax'
              'api.fr001.lax1.cloud21cn.com'
            when 'pi-baynard-staging'
              'api.fr005.baynard.cloud21cn.com'
            when 'pi-baynard-stable'
              'api.fr002.baynard.cloud21cn.com'
            else
              raise ArgumentError, "Unknown region: #{options[:region].inspect}"
            end
            @path   = options[:path]      || '/'
            @port   = options[:port]      || 8773
            @scheme = options[:scheme]    || 'http'
          end
          @connection             = Fog::Connection.new("#{@scheme}://#{@host}:#{@port}#{@path}", options[:persistent])
        end

      private

        def request(params)
          idempotent          = params.delete(:idempotent)
          parser              = params.delete(:parser)

          query_string        = signed_params(params)
          connection_params   = { :expects    => 200,
                                  :idempotent => idempotent,
                                  :host       => @host,
                                  :method     => 'GET',
                                  :query      => signed_params(params) }

          body          = Nokogiri::XML::SAX::PushParser.new(parser)
          body.options |= Nokogiri::XML::ParseOptions::RECOVER
          block         = lambda { |chunk, remaining, length| body << chunk }

          begin
            # the block has to be passed to the connection so that Pi errors can be parsed
            # using the less restrictive parse option RECOVER.
            response = @connection.request(connection_params, &block)

            body.finish
            response.body = parser.response

            response
          rescue Excon::Errors::HTTPStatusError => error
            if errors = parser.error_response['errors']
              error_string = errors.map { |e| "#{e['Code']} => #{e['Message']}" }.join(', ')
              error_string << "\n" << error.message
              raise Fog::AWS::Compute::Error.slurp(error, error_string)
            else
              raise error
            end
          end
        end

        def signed_params(params)
          # apparently pi also supports version 2009-04-04
          params.merge!('AWSAccessKeyId'    => @bt_access_key_id,
                        'SignatureMethod'   => 'HmacSHA256',
                        'SignatureVersion'  => '2',
                        'Timestamp'         => Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ"),
                        'Version'           => '2008-12-01')

          canonical_string  = params.keys.sort.map { |key| "#{amz_escape(key)}=#{amz_escape(params[key])}" }.join('&')
          string_to_sign    = "GET\n#{@host}\n#{@path}\n#{canonical_string}"
          signature         = amz_escape(Base64.encode64(@hmac.sign(string_to_sign)).chomp!).gsub(/\+/, '%20')
          "#{canonical_string}&Signature=#{signature}"
        end

        def amz_escape(unescaped)
          unescaped.to_s.gsub(/([^a-zA-Z0-9._~-]+)/n) do
            '%' + $1.unpack('H2' * $1.size).join('%').upcase
          end
        end

        def indexed_params(key, *values)
          params = {}
          values.flatten.uniq.each_with_index do |value, index|
            params["#{key}.#{index + 1}"] = value
          end
          params
        end
      end

      class Mock

        def initialize(options={})
          unless options.delete(:provider)
            location = caller.first
            warning = "[yellow][WARN] Fog::BT::Compute.new is deprecated, use Fog::Compute.new(:provider => 'BT') instead[/]"
            warning << " [light_black](" << location << ")[/] "
            Formatador.display_line(warning)
          end

          @bt_access_key_id  = options[:bt_access_key_id]
          @region             = options[:region] || 'lax1'
          @data               = self.class.data[@region][@bt_access_key_id]
          @owner_id           = @data[:owner_id]
        end

        def self.data
          @data ||= Hash.new do |hash, region|
            owner_id = Fog::BT::Mock.owner_id
            hash[region] = Hash.new do |region_hash, key|
              region_hash[key] = {
                :addresses        => {},
                :deleted_at       => {},
                :images           => {},
                :instances        => {},
                :key_pairs        => {},
                :limits           => { :instances => 5 },
                :owner_id         => owner_id,
                :security_groups  => {
                  'default' => {
                    'groupDescription'  => 'default group',
                    'groupName'         => 'default',
                    'ipPermissions'     => [
                      {
                        'groups'      => [],
                        'fromPort'    => 22,
                        'toPort'      => 22,
                        'ipProtocol'  => 'TCP',
                        'ipRanges'    => [{"cidrIp" => "0.0.0.0/0"}]
                      },
                    ],
                    'ownerId'           => owner_id
                  }
                },
              }
            end
          end
        end

        def self.reset_data(keys=data.keys)
          for key in [*keys]
            data.delete(key)
          end
        end
      end
    end

    class Mock < Fog::AWS::Mock

      def self.availability_zone
        "lax1-a"
      end
    end
  end
end
