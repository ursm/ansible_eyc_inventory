# ansible_eyc_inventory

Ansible dynamic inventory script generator for Engine Yard Cloud.

## Installation

```
$ gem install ansible_eyc_inventory
```

## Usage

```
$ ansible_eyc_inventory

1  ursm / foo

Choose an application: [1] 1
      create  inventory/eyc_foo_production
       chmod  inventory/eyc_foo_production
$ ansible all -i inventory/eyc_foo_production -m ping
ec2-xxx-xxx-xxx-xxx.ap-northeast-1.compute.amazonaws.com | success >> {
    "changed": false,
    "ping": "pong"
}
```

## Contributing

1. Fork it ( https://github.com/ursm/ansible_eyc_inventory/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
