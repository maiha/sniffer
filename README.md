# sniffer [![Build Status](https://travis-ci.org/maiha/sniffer.svg?branch=master)](https://travis-ci.org/maiha/sniffer)

sniffer dog

## Usage

```shell
sniffer config.toml
```

### monitor payload size for redis 3 args command

```toml
[tcp]
device     = "lo"
ports      = [6379]

[input]
type = "tcp_redis_size"
commands = ["SET"]
interval = 1
```

This reports max payload size on each seconds.

```shell

```


## Development

crystal-0.34.0

- develop and test

```shell
shards update  # first time only
make
```

- build binary (bin/sniffer)

```shell
make release
```

## Contributing

1. Fork it ( https://github.com/maiha/sniffer/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) maiha - creator, maintainer
