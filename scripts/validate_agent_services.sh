#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
repo_root="$(cd -- "${script_dir}/.." && pwd -P)"
installer="${repo_root}/scripts/install-agent-services.sh"
tmp_home=""
unmanaged_home=""
missing_home=""
percent_home=""
bash_bin="${BASH:-$(command -v bash)}"
os="$(uname -s)"

cleanup() {
  if [[ -n "${tmp_home}" ]]; then
    rm -rf -- "${tmp_home}"
  fi
  if [[ -n "${unmanaged_home}" ]]; then
    rm -rf -- "${unmanaged_home}"
  fi
  if [[ -n "${missing_home}" ]]; then
    rm -rf -- "${missing_home}"
  fi
  if [[ -n "${percent_home}" ]]; then
    rm -rf -- "${percent_home}"
  fi
}

trap cleanup EXIT

"${bash_bin}" -n "${installer}"

if command -v shellcheck >/dev/null 2>&1; then
  shellcheck "${installer}"
else
  echo "Skipping ShellCheck: shellcheck is not installed."
fi

tmp_home="$(mktemp -d "${TMPDIR:-/tmp}/agent services & test.XXXXXX")"
mkdir -p -- "${tmp_home}/.local/bin" "${tmp_home}/go/bin"
printf '#!/usr/bin/env sh\nexit 0\n' >"${tmp_home}/.local/bin/roborev"
printf '#!/usr/bin/env sh\nexit 0\n' >"${tmp_home}/go/bin/kata"
chmod +x "${tmp_home}/.local/bin/roborev" "${tmp_home}/go/bin/kata"

tmp_service_path="${tmp_home}/.local/bin:${tmp_home}/go/bin:/usr/bin:/bin:/usr/sbin:/sbin"

env HOME="${tmp_home}" AGENT_SERVICES_PATH_OVERRIDE="${tmp_service_path}" "${bash_bin}" "${installer}" --skip-binaries --no-start
second_run_output="$(env HOME="${tmp_home}" AGENT_SERVICES_PATH_OVERRIDE="${tmp_service_path}" "${bash_bin}" "${installer}" --skip-binaries --no-start)"
printf '%s\n' "${second_run_output}"

echo "Validation uses --no-start; service-manager activation paths require a real user session."

case "${os}" in
  Darwin)
    grep -Fq "Unchanged: ${tmp_home}/Library/LaunchAgents/go.kenn.kata.daemon.plist" <<<"${second_run_output}"
    grep -Fq "Unchanged: ${tmp_home}/Library/LaunchAgents/io.roborev.daemon.plist" <<<"${second_run_output}"
    plutil -lint \
      "${tmp_home}/Library/LaunchAgents/go.kenn.kata.daemon.plist" \
      "${tmp_home}/Library/LaunchAgents/io.roborev.daemon.plist"
    grep -Fq "<key>PATH</key>" "${tmp_home}/Library/LaunchAgents/io.roborev.daemon.plist"
    grep -Fq ".local/bin" "${tmp_home}/Library/LaunchAgents/io.roborev.daemon.plist"
    grep -Fq "go/bin" "${tmp_home}/Library/LaunchAgents/go.kenn.kata.daemon.plist"
    printf '%s\n%s\n' "<!-- Managed by skills/scripts/install-agent-services.sh -->" "stale kata launchagent" >"${tmp_home}/Library/LaunchAgents/go.kenn.kata.daemon.plist"
    printf '%s\n%s\n' "<!-- Managed by skills/scripts/install-agent-services.sh -->" "stale roborev launchagent" >"${tmp_home}/Library/LaunchAgents/io.roborev.daemon.plist"
    env HOME="${tmp_home}" AGENT_SERVICES_PATH_OVERRIDE="${tmp_service_path}" "${bash_bin}" "${installer}" --skip-binaries --no-start
    ! grep -qx "stale kata launchagent" "${tmp_home}/Library/LaunchAgents/go.kenn.kata.daemon.plist"
    ! grep -qx "stale roborev launchagent" "${tmp_home}/Library/LaunchAgents/io.roborev.daemon.plist"
    plutil -lint "${tmp_home}/Library/LaunchAgents/go.kenn.kata.daemon.plist"
    plutil -lint "${tmp_home}/Library/LaunchAgents/io.roborev.daemon.plist"
    ;;
  Linux)
    grep -Fq "Unchanged: ${tmp_home}/.config/systemd/user/kata.service" <<<"${second_run_output}"
    grep -Fq "Unchanged: ${tmp_home}/.config/systemd/user/roborev.service" <<<"${second_run_output}"
    test -f "${tmp_home}/.config/systemd/user/kata.service"
    test -f "${tmp_home}/.config/systemd/user/roborev.service"
    if command -v systemd-analyze >/dev/null 2>&1; then
      systemd-analyze --user verify \
        "${tmp_home}/.config/systemd/user/kata.service" \
        "${tmp_home}/.config/systemd/user/roborev.service"
    else
      echo "Skipping systemd unit verification: systemd-analyze is not installed."
    fi
    grep -Fq 'Environment="PATH=' "${tmp_home}/.config/systemd/user/roborev.service"
    grep -Fq "${tmp_home}/.local/bin" "${tmp_home}/.config/systemd/user/roborev.service"
    grep -Fq "${tmp_home}/go/bin" "${tmp_home}/.config/systemd/user/kata.service"
    printf '%s\n%s\n' "# Managed by skills/scripts/install-agent-services.sh" "stale kata service" >"${tmp_home}/.config/systemd/user/kata.service"
    printf '%s\n%s\n' "# Managed by skills/scripts/install-agent-services.sh" "stale roborev service" >"${tmp_home}/.config/systemd/user/roborev.service"
    env HOME="${tmp_home}" AGENT_SERVICES_PATH_OVERRIDE="${tmp_service_path}" "${bash_bin}" "${installer}" --skip-binaries --no-start
    ! grep -qx "stale kata service" "${tmp_home}/.config/systemd/user/kata.service"
    ! grep -qx "stale roborev service" "${tmp_home}/.config/systemd/user/roborev.service"
    if command -v systemd-analyze >/dev/null 2>&1; then
      systemd-analyze --user verify \
        "${tmp_home}/.config/systemd/user/kata.service" \
        "${tmp_home}/.config/systemd/user/roborev.service"
    fi
    ;;
  *)
    echo "Unsupported operating system for service validation: ${os}" >&2
    exit 1
    ;;
esac

missing_home="$(mktemp -d "${TMPDIR:-/tmp}/agent services missing.XXXXXX")"
mkdir -p -- "${missing_home}/missing-bin"
if env HOME="${missing_home}" PATH="${missing_home}/missing-bin" AGENT_SERVICES_PATH_OVERRIDE="${missing_home}/missing-bin" AGENT_SERVICES_OS_OVERRIDE="${os}" "${bash_bin}" "${installer}" --skip-binaries --no-start >/dev/null 2>&1; then
  echo "Expected --skip-binaries to fail when Kata and Roborev are absent from PATH." >&2
  exit 1
fi

percent_home="$(mktemp -d "${TMPDIR:-/tmp}/agent services % test.XXXXXX")"
mkdir -p -- "${percent_home}/.local/bin" "${percent_home}/go/bin"
printf '#!/usr/bin/env sh\nexit 0\n' >"${percent_home}/.local/bin/roborev"
printf '#!/usr/bin/env sh\nexit 0\n' >"${percent_home}/go/bin/kata"
chmod +x "${percent_home}/.local/bin/roborev" "${percent_home}/go/bin/kata"
percent_service_path="${percent_home}/.local/bin:${percent_home}/go/bin:/usr/bin:/bin:/usr/sbin:/sbin"
env HOME="${percent_home}" AGENT_SERVICES_PATH_OVERRIDE="${percent_service_path}" AGENT_SERVICES_OS_OVERRIDE=Linux "${bash_bin}" "${installer}" --skip-binaries --no-start
grep -Fq '%%' "${percent_home}/.config/systemd/user/kata.service"
grep -Fq '%%' "${percent_home}/.config/systemd/user/roborev.service"

unmanaged_home="$(mktemp -d "${TMPDIR:-/tmp}/agent services unmanaged.XXXXXX")"
mkdir -p -- "${unmanaged_home}/.local/bin" "${unmanaged_home}/go/bin"
printf '#!/usr/bin/env sh\nexit 0\n' >"${unmanaged_home}/.local/bin/roborev"
printf '#!/usr/bin/env sh\nexit 0\n' >"${unmanaged_home}/go/bin/kata"
chmod +x "${unmanaged_home}/.local/bin/roborev" "${unmanaged_home}/go/bin/kata"
unmanaged_service_path="${unmanaged_home}/.local/bin:${unmanaged_home}/go/bin:/usr/bin:/bin:/usr/sbin:/sbin"

case "${os}" in
  Darwin)
    mkdir -p -- "${unmanaged_home}/Library/LaunchAgents"
    printf '%s\n' "custom kata launchagent" >"${unmanaged_home}/Library/LaunchAgents/go.kenn.kata.daemon.plist"
    printf '%s\n' "custom roborev launchagent" >"${unmanaged_home}/Library/LaunchAgents/io.roborev.daemon.plist"
    env HOME="${unmanaged_home}" AGENT_SERVICES_PATH_OVERRIDE="${unmanaged_service_path}" "${bash_bin}" "${installer}" --skip-binaries --no-start
    grep -qx "custom kata launchagent" "${unmanaged_home}/Library/LaunchAgents/go.kenn.kata.daemon.plist"
    grep -qx "custom roborev launchagent" "${unmanaged_home}/Library/LaunchAgents/io.roborev.daemon.plist"
    ;;
  Linux)
    mkdir -p -- "${unmanaged_home}/.config/systemd/user"
    printf '%s\n' "custom kata service" >"${unmanaged_home}/.config/systemd/user/kata.service"
    printf '%s\n' "custom roborev service" >"${unmanaged_home}/.config/systemd/user/roborev.service"
    env HOME="${unmanaged_home}" AGENT_SERVICES_PATH_OVERRIDE="${unmanaged_service_path}" "${bash_bin}" "${installer}" --skip-binaries --no-start
    grep -qx "custom kata service" "${unmanaged_home}/.config/systemd/user/kata.service"
    grep -qx "custom roborev service" "${unmanaged_home}/.config/systemd/user/roborev.service"
    ;;
esac
