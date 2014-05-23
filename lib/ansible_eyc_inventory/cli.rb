require 'ansible_eyc_inventory'
require 'thor'

module AnsibleEYCInventory
  class CLI < Thor
    include Thor::Actions

    default_command :generate

    add_runtime_options!
    source_root File.expand_path('../../../templates', __FILE__)

    desc 'generate', 'Generate inventory script'
    option :destdir, aliases: %w(-d), default: './inventory'
    def generate
      choose_app.environments.each do |env|
        dest = "#{options[:destdir]}/eyc_#{env.name}"

        template 'inventory', dest, env_name: env.name, account_name: env.account.name
        chmod dest, 0755
      end
    rescue Error => e
      error e.message

      exit 1
    end

    private

    def choose_app
      apps = AnsibleEYCInventory.api.apps.sort_by(&:hierarchy_name)

      say

      print_table apps.map.with_index(1) {|app, i|
        [i, app.hierarchy_name, app.app_type_id]
      }.unshift([nil, 'Name', 'Type'])

      say

      index = ask('Choose an application:', limited_to: 1.upto(apps.size).map(&:to_s))

      apps[index.to_i.pred]
    end
  end
end
