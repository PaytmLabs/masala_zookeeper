# masala_zookeeper

This is a component of the [masala toolkit](https://github.com/PaytmLabs/masala).

This is a [wrapper cookbook](http://blog.vialstudios.com/the-environment-cookbook-pattern/#thewrappercookbook) for providing recipes for zookeeper server deployment. 

It allows for setting the server id, will enable datadog monitoring for zookeeper if enabled in masala_base, and sets up cleanup of zookeeper data.

## Supported Platforms

The platforms supported are:
- Centos 6.7+ / Centos 7.1+
- Ubuntu 14.04 LTS (And future LTS releases)
- Debioan 8.2+

## Attributes

Please see the documentation for the cookbooks included by masala_zookeeper. (See [metadata.rb](https://github.com/PaytmLabs/masala_zookeeper/blob/develop/metadata.rb) file)

This cookbook does not add any attributes of it's own.

## Usage

### masala_zookeeper::default

Include `masala_zookeeper` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[masala_zookeeper::default]"
  ]
}
```

## License, authors, and how to contribute

See:
- [LICENSE](https://github.com/PaytmLabs/masala_zookeeper/blob/develop/LICENSE)
- [MAINTAINERS.md](https://github.com/PaytmLabs/masala_zookeeper/blob/develop/MAINTAINERS.md)
- [CONTRIBUTING.md](https://github.com/PaytmLabs/masala_zookeeper/blob/develop/CONTRIBUTING.md)

