#!/usr/bin/env bash
set -euo pipefail

start_services=1
install_binaries=1
tmpfiles=()
managed_marker="Managed by skills/scripts/install-agent-services.sh"

cleanup() {
  if ((${#tmpfiles[@]} > 0)); then
    rm -f -- "${tmpfiles[@]}"
  fi
}

trap cleanup EXIT

usage() {
  cat <<'USAGE'
Usage: scripts/install-agent-services.sh [--no-start] [--skip-binaries]

Install Kata and Roborev for the current user and configure their daemons as
OS-managed user services.

Options:
  --no-start       Write service files but do not enable or start them.
  --skip-binaries  Do not install missing binaries; fail if they are absent.
  -h, --help       Show this help.
USAGE
}

while (($# > 0)); do
  case "$1" in
    --no-start)
      start_services=0
      ;;
    --skip-binaries)
      install_binaries=0
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

append_user_paths() {
  local service_path
  local entry
  local prefix=""
  local -a entries

  service_path="$(user_service_path)"
  IFS=: read -r -a entries <<<"${service_path}"

  for entry in "${entries[@]}"; do
    if [[ -n "${entry}" && ":${PATH:-}:" != *":${entry}:"* && ":${prefix}:" != *":${entry}:"* ]]; then
      if [[ -z "${prefix}" ]]; then
        prefix="${entry}"
      else
        prefix="${prefix}:${entry}"
      fi
    fi
  done

  if [[ -n "${prefix}" ]]; then
    PATH="${prefix}${PATH:+:${PATH}}"
    export PATH
  fi
}

go_bin_dir() {
  local gobin
  local gopath

  if command -v go >/dev/null 2>&1; then
    gobin="$(go env GOBIN 2>/dev/null || true)"
    if [[ -n "${gobin}" ]]; then
      printf '%s\n' "${gobin}"
      return
    fi

    gopath="$(go env GOPATH 2>/dev/null || true)"
    gopath="${gopath%%:*}"
    if [[ -n "${gopath}" ]]; then
      printf '%s/bin\n' "${gopath}"
      return
    fi
  fi

  printf '%s\n' "${HOME}/go/bin"
}

user_service_path() {
  local entries
  local entry
  local output=""

  if [[ -n "${AGENT_SERVICES_PATH_OVERRIDE:-}" ]]; then
    printf '%s\n' "${AGENT_SERVICES_PATH_OVERRIDE}"
    return
  fi

  entries=(
    "${HOME}/.local/bin" \
    "${HOME}/.roborev/bin" \
    "$(go_bin_dir)" \
    "${HOME}/go/bin" \
    "/opt/homebrew/bin" \
    "/usr/local/bin" \
    "/usr/bin" \
    "/bin" \
    "/usr/sbin" \
    "/sbin"
  )

  for entry in "${entries[@]}"; do
    if [[ -n "${entry}" && ":${output}:" != *":${entry}:"* ]]; then
      if [[ -z "${output}" ]]; then
        output="${entry}"
      else
        output="${output}:${entry}"
      fi
    fi
  done

  printf '%s\n' "${output}"
}

require_command() {
  local command_name="$1"
  local install_hint="$2"

  if ! command -v "${command_name}" >/dev/null 2>&1; then
    echo "Missing ${command_name}. ${install_hint}" >&2
    exit 1
  fi
}

install_kata() {
  if command -v kata >/dev/null 2>&1; then
    echo "Kata already installed: $(command -v kata)"
    return
  fi

  if [[ "${install_binaries}" -eq 0 ]]; then
    require_command kata "Install Kata or rerun without --skip-binaries."
  fi

  require_command go "Install Go before installing Kata."
  echo "Installing Kata with go install go.kenn.io/kata/cmd/kata@latest"
  go install go.kenn.io/kata/cmd/kata@latest
  append_user_paths
  require_command kata "Kata installation completed, but kata is not on PATH."
}

install_roborev() {
  local installer

  if command -v roborev >/dev/null 2>&1; then
    echo "Roborev already installed: $(command -v roborev)"
    return
  fi

  if [[ "${install_binaries}" -eq 0 ]]; then
    require_command roborev "Install Roborev or rerun without --skip-binaries."
  fi

  require_command curl "Install curl before installing Roborev."
  installer="$(mktemp)"
  tmpfiles+=("${installer}")
  echo "Installing Roborev from https://roborev.io/install.sh"
  echo "Trusting Roborev's published HTTPS installer endpoint; no checksum is provided here." >&2
  curl -fsSL https://roborev.io/install.sh -o "${installer}"
  sh "${installer}"
  append_user_paths
  require_command roborev "Roborev installation completed, but roborev is not on PATH."
}

write_if_changed() {
  local target="$1"
  local tmp

  tmp="$(mktemp)"
  tmpfiles+=("${tmp}")
  cat >"${tmp}"

  if [[ -f "${target}" ]] && ! grep -Fq "${managed_marker}" "${target}"; then
    echo "Skipping ${target}: existing file is not marked as managed by this script." >&2
    return 2
  fi

  if [[ -f "${target}" ]] && cmp -s "${tmp}" "${target}"; then
    echo "Unchanged: ${target}"
    return 3
  fi

  mkdir -p -- "$(dirname -- "${target}")"
  mv "${tmp}" "${target}"
  echo "Wrote: ${target}"
  return 0
}

xml_escape() {
  sed \
    -e 's/&/\&amp;/g' \
    -e 's/</\&lt;/g' \
    -e 's/>/\&gt;/g' \
    -e 's/"/\&quot;/g' \
    -e "s/'/\&apos;/g"
}

systemd_env_escape() {
  sed \
    -e 's/%/%%/g' \
    -e 's/\\/\\\\/g' \
    -e 's/"/\\"/g'
}

write_launchagent() {
  local label="$1"
  local binary="$2"
  local first_arg="$3"
  local second_arg="$4"
  local stdout_path="$5"
  local stderr_path="$6"
  local target="${HOME}/Library/LaunchAgents/${label}.plist"
  local binary_xml
  local first_arg_xml
  local second_arg_xml
  local stdout_path_xml
  local stderr_path_xml
  local path_xml

  binary_xml="$(printf '%s' "${binary}" | xml_escape)"
  first_arg_xml="$(printf '%s' "${first_arg}" | xml_escape)"
  second_arg_xml="$(printf '%s' "${second_arg}" | xml_escape)"
  stdout_path_xml="$(printf '%s' "${stdout_path}" | xml_escape)"
  stderr_path_xml="$(printf '%s' "${stderr_path}" | xml_escape)"
  path_xml="$(user_service_path | xml_escape)"

  write_if_changed "${target}" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<!-- ${managed_marker} -->
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${label}</string>
    <key>ProgramArguments</key>
    <array>
        <string>${binary_xml}</string>
        <string>${first_arg_xml}</string>
        <string>${second_arg_xml}</string>
    </array>
    <key>EnvironmentVariables</key>
    <dict>
        <key>PATH</key>
        <string>${path_xml}</string>
    </dict>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <dict>
        <key>SuccessfulExit</key>
        <false/>
    </dict>
    <key>ThrottleInterval</key>
    <integer>5</integer>
    <key>StandardOutPath</key>
    <string>${stdout_path_xml}</string>
    <key>StandardErrorPath</key>
    <string>${stderr_path_xml}</string>
</dict>
</plist>
PLIST
}

enable_launchagent() {
  local label="$1"
  local plist="${HOME}/Library/LaunchAgents/${label}.plist"

  if [[ "${start_services}" -eq 0 ]]; then
    echo "Not starting ${label}: --no-start was set."
    return
  fi

  launchctl bootout "gui/${UID}/${label}" 2>/dev/null || true
  if launchctl bootstrap "gui/${UID}" "${plist}" 2>/dev/null; then
    echo "Loaded LaunchAgent: ${label}"
  else
    launchctl load -w "${plist}" || {
      echo "Failed to load ${label}; check ${plist}." >&2
      exit 1
    }
    echo "Loaded LaunchAgent with fallback: ${label}"
  fi
  require_launchagent_running "${label}"
}

require_launchagent_running() {
  local label="$1"
  local status
  local attempt

  for ((attempt = 1; attempt <= 5; attempt++)); do
    status="$(launchctl print "gui/${UID}/${label}" 2>/dev/null || true)"
    if [[ "${status}" == *"state = running"* ]]; then
      echo "Running: ${label}"
      return
    fi
    sleep 1
  done

  echo "LaunchAgent ${label} was loaded but is not running; confirm its daemon command stays in the foreground and check its logs." >&2
  exit 1
}

require_systemd_user_service_active() {
  local service="$1"
  local attempt

  for ((attempt = 1; attempt <= 5; attempt++)); do
    if systemctl --user is-active --quiet "${service}"; then
      echo "Active: ${service}"
      return
    fi
    sleep 1
  done

  echo "systemd service ${service} was restarted but is not active; confirm its daemon command stays in the foreground and check its logs." >&2
  exit 1
}

ensure_launchagent() {
  local label="$1"
  local status

  if [[ "${start_services}" -eq 0 ]]; then
    echo "Not checking ${label}: --no-start was set."
    return
  fi

  status="$(launchctl print "gui/${UID}/${label}" 2>/dev/null || true)"
  if [[ "${status}" == *"state = running"* ]]; then
    echo "Already running: ${label}"
    return
  fi

  enable_launchagent "${label}"
}

write_systemd_user_unit() {
  local service="$1"
  local description="$2"
  local env_name="$3"
  local binary="$4"
  local first_arg="$5"
  local second_arg="$6"
  local target="${HOME}/.config/systemd/user/${service}"
  local binary_env
  local path_env

  binary_env="$(printf '%s' "${binary}" | systemd_env_escape)"
  path_env="$(user_service_path | systemd_env_escape)"

  # first_arg and second_arg are fixed literals owned by this script. Do not
  # pass user input here without adding shell escaping for those arguments.
  write_if_changed "${target}" <<UNIT
[Unit]
# ${managed_marker}
Description=${description}
After=default.target

[Service]
Type=simple
Environment="${env_name}=${binary_env}"
Environment="PATH=${path_env}"
ExecStart=/bin/sh -c 'exec "\$${env_name}" ${first_arg} ${second_arg}'
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
UNIT
}

enable_systemd_user_service() {
  local service="$1"

  if [[ "${start_services}" -eq 0 ]]; then
    echo "Not starting ${service}: --no-start was set."
    return
  fi

  systemctl --user reenable "${service}"
  systemctl --user restart "${service}"
  require_systemd_user_service_active "${service}"
  echo "Enabled and restarted ${service}."
}

ensure_systemd_user_service() {
  local service="$1"

  if [[ "${start_services}" -eq 0 ]]; then
    echo "Not checking ${service}: --no-start was set."
    return
  fi

  if systemctl --user is-active --quiet "${service}"; then
    echo "Already running: ${service}"
    return
  fi

  enable_systemd_user_service "${service}"
}

configure_macos_services() {
  local kata_bin="$1"
  local roborev_bin="$2"
  local log_dir="${HOME}/Library/Logs"
  local status

  if [[ "${start_services}" -eq 1 ]]; then
    require_command launchctl "launchctl is required on macOS."
  fi
  mkdir -p -- "${log_dir}"

  if write_launchagent go.kenn.kata.daemon "${kata_bin}" daemon start "${log_dir}/kata-daemon.out.log" "${log_dir}/kata-daemon.err.log"; then
    status=0
  else
    status=$?
  fi
  case "${status}" in
    0)
      enable_launchagent go.kenn.kata.daemon
      ;;
    2)
      echo "Not starting go.kenn.kata.daemon: existing LaunchAgent is hand-managed."
      ;;
    3)
      ensure_launchagent go.kenn.kata.daemon
      ;;
  esac

  if write_launchagent io.roborev.daemon "${roborev_bin}" daemon run "${log_dir}/roborev-daemon.out.log" "${log_dir}/roborev-daemon.err.log"; then
    status=0
  else
    status=$?
  fi
  case "${status}" in
    0)
      enable_launchagent io.roborev.daemon
      ;;
    2)
      echo "Not starting io.roborev.daemon: existing LaunchAgent is hand-managed."
      ;;
    3)
      ensure_launchagent io.roborev.daemon
      ;;
  esac
}

configure_linux_services() {
  local kata_bin="$1"
  local roborev_bin="$2"
  local kata_status=2
  local roborev_status=2

  if [[ "${start_services}" -eq 1 ]]; then
    require_command systemctl "systemctl is required on Linux."
  fi

  if write_systemd_user_unit kata.service "Kata issue tracker daemon" KATA_BIN "${kata_bin}" daemon start; then
    kata_status=0
  else
    kata_status=$?
  fi

  if write_systemd_user_unit roborev.service "Roborev review daemon" ROBOREV_BIN "${roborev_bin}" daemon run; then
    roborev_status=0
  else
    roborev_status=$?
  fi

  if [[ "${start_services}" -eq 1 && ("${kata_status}" -eq 0 || "${kata_status}" -eq 3 || "${roborev_status}" -eq 0 || "${roborev_status}" -eq 3) ]]; then
    systemctl --user daemon-reload
  fi

  if [[ "${kata_status}" -eq 0 ]]; then
    enable_systemd_user_service kata.service
  elif [[ "${kata_status}" -eq 2 ]]; then
    echo "Not starting kata.service: existing unit is hand-managed."
  elif [[ "${kata_status}" -eq 3 ]]; then
    ensure_systemd_user_service kata.service
  fi

  if [[ "${roborev_status}" -eq 0 ]]; then
    enable_systemd_user_service roborev.service
  elif [[ "${roborev_status}" -eq 2 ]]; then
    echo "Not starting roborev.service: existing unit is hand-managed."
  elif [[ "${roborev_status}" -eq 3 ]]; then
    ensure_systemd_user_service roborev.service
  fi
}

main() {
  local os
  local kata_bin
  local roborev_bin

  append_user_paths
  os="${AGENT_SERVICES_OS_OVERRIDE:-$(uname -s)}"
  case "${os}" in
    Darwin|Linux)
      ;;
    *)
      echo "Unsupported operating system: ${os}" >&2
      exit 1
      ;;
  esac

  install_kata
  install_roborev

  kata_bin="$(command -v kata)"
  roborev_bin="$(command -v roborev)"

  case "${os}" in
    Darwin)
      configure_macos_services "${kata_bin}" "${roborev_bin}"
      ;;
    Linux)
      configure_linux_services "${kata_bin}" "${roborev_bin}"
      ;;
  esac

  echo "Agent services are installed for ${os}."
}

main "$@"
