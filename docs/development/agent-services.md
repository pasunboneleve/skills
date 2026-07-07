# Agent Services

This repository can install Kata and Roborev as user-level operating-system
services. The setup is intentionally independent of chezmoi so team members can
run it from this repository alone.

## Install

From the repository root:

```bash
bash scripts/install-agent-services.sh
```

The script is idempotent. It installs missing binaries, writes service files, and
enables or restarts the services for the current user.

Use `--skip-binaries` when Kata and Roborev are already installed and the script
should only manage service files. Use `--no-start` when preparing files without
starting the services.

## What It Installs

Kata is installed with:

```bash
go install go.kenn.io/kata/cmd/kata@latest
```

Roborev is installed from:

```bash
https://roborev.io/install.sh
```

The script downloads that installer over HTTPS and executes it as the current
user. Roborev does not provide a checksum in this repository, so this step trusts
the published installer endpoint. The installer is executed with `sh`, matching
Roborev's published `curl | sh` installation path.

After installation, the script expects `roborev` to be available on `PATH`.
It prepends `~/.local/bin` and `~/.roborev/bin`, which are the supported
user-local locations for this repository's setup.

The script configures:

- macOS LaunchAgents:
  - `go.kenn.kata.daemon`
  - `io.roborev.daemon`
- Linux user systemd units:
  - `kata.service`
  - `roborev.service`

The services run:

```bash
kata daemon start
roborev daemon run
```

The generated services expect Kata and Roborev daemon commands to keep running
in the foreground so launchd and systemd can supervise those processes directly.
Kata's `daemon start` help describes the command as foreground execution.
Roborev's `daemon run` help also describes foreground execution. If these
commands change, verify them with a short timeout before updating the service
definitions; a foreground daemon should keep running until the timeout sends a
termination signal.
When the installer starts services, it checks that launchd reports the
LaunchAgent as running or systemd reports the unit as active after restart.
Both platforms restart the services on failure. A clean daemon exit is treated as
intentional and is not restarted automatically.

Generated service files include a `Managed by
skills/scripts/install-agent-services.sh` marker. If a service file already
exists without that marker and differs from the generated file, the installer
leaves it in place and prints a warning instead of replacing, loading, or
restarting a hand-managed unit.

On macOS, daemon stdout and stderr logs are written separately under
`~/Library/Logs/` so multiple users do not share predictable `/tmp` log paths.
Generated services set an explicit `PATH` that includes `~/.local/bin`,
`~/.roborev/bin`, the Go bin directory, Homebrew locations, and the standard
system paths.

## Requirements

- Go must be installed before Kata can be installed.
- `curl` must be installed before Roborev can be installed.
- Linux hosts must support `systemctl --user`.
- macOS hosts must support `launchctl`.

On Linux, user services normally run while the user has a login session. If a
machine needs these services before login, an administrator can enable lingering
for that user outside this script.

## Check Status

On macOS:

```bash
launchctl print "gui/$UID/go.kenn.kata.daemon"
launchctl print "gui/$UID/io.roborev.daemon"
```

On Linux:

```bash
systemctl --user status kata.service roborev.service
```

## Agent Expectations

Agents should treat Kata and Roborev as managed daemons after this installer has
run. These services run outside the command sandbox, so sandbox-local status
checks can be false negatives. During normal repository work, do not start
`kata daemon start` or `roborev daemon run` as ad hoc foreground processes. If
either tool appears unavailable, check the managed service status outside the
sandbox and rerun this installer when the service files need repair. Existing
Kata or Roborev binaries are reused unless they are absent.
