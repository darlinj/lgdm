module Fog
  module Parsers
    module BT
      module Compute

        class ErrorResponse < StandardError; end

        class Base < Fog::Parsers::Base

          attr_reader :error_response

          def reset
            super
            @error = {}
            @error_response = { 'errors' => [] }
          end

          def start_element(name, attrs = [])
            #puts "********: " + name
            super
            case name
            when'Errors'
              @in_errors = true
            end
          end

          def end_element(name)
            case name
            when 'Code', 'Message'
              if @in_errors
                @error[name] = @value
              end
            when 'Error'
              if @in_errors
                @error_response['errors'] << @error
                @error = {}
              end
            end
          end
        end

      end
    end
  end
end
