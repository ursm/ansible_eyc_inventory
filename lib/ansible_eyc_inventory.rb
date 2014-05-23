require 'engineyard-cloud-client'
require 'json'
require 'pathname'
require 'yaml'

module AnsibleEYCInventory
  EYRC_PATH = Pathname.new('~/.eyrc')

  class Error < StandardError; end

  class << self
    def print_json(env_name, account_name)
      env = api.env_by_name(env_name, account_name)

      json = env.instances.group_by(&:role).each_with_object({}) {|(role, instances), memo|
        memo[role] = instances.map(&:hostname)
      }.merge(
        _meta: {
          hostvars: env.instances.each_with_object({}) {|instance, memo|
            memo[instance.hostname] = {
              ansible_ssh_user:      env.username,
              eyc_amazon_id:         instance.amazon_id,
              eyc_availability_zone: instance.availability_zone,
              eyc_status:            instance.status
            }
          }
        }
      )

      puts JSON.pretty_generate(json)
    rescue Error => e
      warn e.message

      exit 1
    end

    def api
      @api ||= EY::CloudClient.new(token: api_token)
    end

    private

    def api_token
      raise Error, "Could not find #{EYRC_PATH}. Run `ey login` and try again." unless EYRC_PATH.expand_path.exist?

      YAML.load_file(EYRC_PATH.expand_path)['api_token'].tap {|token|
        raise Error, "Could not find your API token from #{EYRC_PATH}. Run `ey login` and try again." unless token
      }
    end
  end
end
