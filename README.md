# Ansible STNS Collection

# Requirements

## Python

Using the ansible filter plugin to generate stns config with toml from ansible vars.

```sh
pip install toml
```
# Limitations

## Supported OS

Ubuntu only. We want to support another OS in the future.

## STNS server/client config generator

`/etc/stns/*/stns.conf` is the following implementation

```
{{ stns_client_config_default | combine(stns_client_config, recursive=True) | to_toml }}
```

This is because the hash of Ansible vars is not automatically merged.

caution: `stns_client_config` and `stns_server_config` cannot be configured in multiple locations.

# Install

```
ansible-galaxy collection install takumakume.stns
```

or

```yaml
# requirements.yml
---
collections:
  - name: takumakume.stns
```

```sh
ansible-galaxy collection install -r requirements.yml
```

# Roles description

## STNS client

Install and configure STNS client.

vars:

| Name | Description |
| ---- | --- |
| stns_client_config | Generate to `/etc/stns/client/stns.conf` with TOML filter plugin (default: see `stns_client_config_default` variable)|
| stns_client_state | latest/present/absent (default: latest) |
| libnss_stns_version | libnss-stns-v2 package version (default: '') |
| cache_stnsd_version | cache-stnsd package version (default: '') |

example:

```yaml
- name: converge STNS client
  hosts: all

  tasks:
  - name: include client role
    ansible.builtin.include_role:
      name: takumakume.stns.client
    vars:
      stns_client_config:
        ...
```

## STNS server

Install and configure STNS server.

vars:

| Name | Description |
| ---- | --- |
| stns_server_config | Generate to `/etc/stns/server/stns.conf` with TOML filter plugin (default: see `stns_server_config_default` variable)|
| stns_server_state | latest/present/absent (default: latest) |
| stns_version | stns-v2 package version (default: '') |

example:

```yaml
- name: converge STNS server
  hosts: all

  tasks:
  - name: include server role
    ansible.builtin.include_role:
      name: takumakume.stns.server
    vars:
      stns_server_config:
        ...
```
