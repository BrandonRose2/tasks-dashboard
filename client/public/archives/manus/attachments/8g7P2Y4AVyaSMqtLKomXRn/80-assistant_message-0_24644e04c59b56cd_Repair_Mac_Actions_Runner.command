#!/bin/zsh
# Repairs only the GitHub Actions runner program files in ~/actions-runner.
# It does not read or alter .credentials, .credentials_rsaparams, .runner,
# .env, _work, _diag, Microsoft Edge, OneSite, Yardi, the portal, or reports.
# It does not start the runner after repair.

set -euo pipefail

RUNNER_ROOT="$HOME/actions-runner"
RELEASE_VERSION="2.337.0"
ARCHIVE_NAME="actions-runner-osx-arm64-${RELEASE_VERSION}.tar.gz"
ARCHIVE_URL="https://github.com/actions/runner/releases/download/v${RELEASE_VERSION}/${ARCHIVE_NAME}"
EXPECTED_SHA256="5a2cd92908a93d7276a194e1de6008099f3e7946f3f8e14aa7a1a7b4a31fdec2"
COMPONENTS=(bin externals run.sh run-helper.sh config.sh env.sh safe_sleep.sh svc.sh)

fail() {
  print -u2 -- "Runner repair stopped: $1"
  exit 1
}

[[ "$(uname -m)" == "arm64" ]] || fail "This package is for Apple Silicon Macs only."
[[ -d "$RUNNER_ROOT" ]] || fail "Expected runner folder not found: $RUNNER_ROOT"
[[ -f "$RUNNER_ROOT/.runner" ]] || fail "Existing runner registration metadata is missing; no change was made."
[[ -f "$RUNNER_ROOT/.credentials" && -f "$RUNNER_ROOT/.credentials_rsaparams" ]] || fail "Existing runner credentials are missing; no change was made."
[[ ! -e "$RUNNER_ROOT/bin/Runner.Listener" ]] || fail "Runner.Listener already exists; no change was made."

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/actions-runner-repair.XXXXXX")"
ARCHIVE_PATH="$WORK_DIR/$ARCHIVE_NAME"
STAGE_DIR="$WORK_DIR/stage"
BACKUP_DIR="$HOME/actions-runner-program-backup-$(date +%Y%m%d-%H%M%S)"
cleanup() { rm -rf "$WORK_DIR"; }
trap cleanup EXIT

print -- "Downloading the official GitHub Actions runner ${RELEASE_VERSION} for macOS ARM64…"
curl --fail --location --proto '=https' --tlsv1.2 --retry 2 --connect-timeout 20 "$ARCHIVE_URL" --output "$ARCHIVE_PATH" || fail "Official runner archive could not be downloaded."
ACTUAL_SHA256="$(shasum -a 256 "$ARCHIVE_PATH" | awk '{print $1}')"
[[ "$ACTUAL_SHA256" == "$EXPECTED_SHA256" ]] || fail "Downloaded archive integrity check failed."

mkdir -p "$STAGE_DIR"
tar -xzf "$ARCHIVE_PATH" -C "$STAGE_DIR"
for required in bin/Runner.Listener bin/Runner.Worker bin/Runner.PluginHost run.sh config.sh; do
  [[ -e "$STAGE_DIR/$required" ]] || fail "Verified archive lacks required file: $required"
done

mkdir -p "$BACKUP_DIR"
for component in "${COMPONENTS[@]}"; do
  if [[ -e "$RUNNER_ROOT/$component" ]]; then
    ditto "$RUNNER_ROOT/$component" "$BACKUP_DIR/$component"
  fi
done

print -- "Replacing only the incomplete runner program files; existing runner registration and work history are preserved…"
rm -rf "$RUNNER_ROOT/bin" "$RUNNER_ROOT/externals"
mv "$STAGE_DIR/bin" "$RUNNER_ROOT/bin"
mv "$STAGE_DIR/externals" "$RUNNER_ROOT/externals"
for component in run.sh run-helper.sh config.sh env.sh safe_sleep.sh svc.sh; do
  [[ -e "$STAGE_DIR/$component" ]] && ditto "$STAGE_DIR/$component" "$RUNNER_ROOT/$component"
done

[[ -x "$RUNNER_ROOT/bin/Runner.Listener" ]] || fail "Runner.Listener was not restored as an executable. Your original program files remain in $BACKUP_DIR."
[[ -f "$RUNNER_ROOT/.runner" && -f "$RUNNER_ROOT/.credentials" && -f "$RUNNER_ROOT/.credentials_rsaparams" ]] || fail "Registration preservation check failed. Stop and restore from $BACKUP_DIR."

print -- "Runner program repair completed. Backup: $BACKUP_DIR"
print -- "No runner, Edge browser, provider, portal, report, email, or file workflow was started."
print -- "Next step: return to this task and request a readiness-only runner check before starting ~/actions-runner/run.sh."
