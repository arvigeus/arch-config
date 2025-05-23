# systemd

## Utilities

### `systemd-analyze cat-config`

`systemd-analyze cat-config` is a diagnostic tool that shows the **fully resolved version** of a configuration file, assembled from all its component parts across systemd’s configuration hierarchy:

- `/etc/`
- `/run/`
- `/usr/lib/`

#### Syntax

```sh
systemd-analyze cat-config <TYPE> <NAME>
```

- `TYPE`: Subsystem directory (e.g. `udev/rules.d`, `systemd/system`, `sysctl.d`, etc.)
- `NAME`: Target configuration file or unit name.

#### Supported Types (Examples)

| Type                    | Description                  |
| ----------------------- | ---------------------------- |
| `udev/rules.d`          | Udev rules                   |
| `systemd/system`        | System unit files            |
| `systemd/user`          | User unit files              |
| `tmpfiles.d`            | Temporary file configuration |
| `sysctl.d`              | Kernel parameter settings    |
| `modules-load.d`        | Kernel modules to load       |
| `journald.conf.d`       | Journald configuration       |
| `logind.conf.d`         | Logind session handling      |
| `resolved.conf.d`       | DNS resolver                 |
| `coredump.conf.d`       | Coredump behavior            |
| `timesyncd.conf.d`      | NTP client settings          |
| `journal-upload.conf.d` | Journal upload config        |

#### Usage Examples

##### Inspect merged udev rule

```sh
systemd-analyze cat-config udev/rules.d 99-custom.rules
```

##### Show all drop-ins and overrides for SSHD

```sh
systemd-analyze cat-config systemd/system sshd.service
```

##### View kernel parameter configuration

```sh
systemd-analyze cat-config sysctl.d 99-custom.conf
```
