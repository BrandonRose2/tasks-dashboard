#!/usr/bin/env bash
# Inventory environment-variable references in a GitHub repository without printing values.
# Usage:
#   ./check_env_requirements.sh OWNER/REPOSITORY [LOCAL_REPOSITORY_DIRECTORY]
# Examples:
#   ./check_env_requirements.sh EKhelil11/website-peptide
#   ./check_env_requirements.sh EKhelil11/website-peptide /path/to/checked-out/repository

set -Eeuo pipefail

usage() {
  cat <<'USAGE'
Usage: check_env_requirements.sh OWNER/REPOSITORY [LOCAL_REPOSITORY_DIRECTORY]

The script scans source code for environment-variable names and reports only whether
those names are available to the shell running the script. It never prints values.

Without a local directory, it uses the authenticated GitHub CLI to make a temporary
read-only clone of the repository and removes that clone when finished.
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || $# -lt 1 || $# -gt 2 ]]; then
  usage
  exit $([[ $# -eq 1 && ( "${1:-}" == "-h" || "${1:-}" == "--help" ) ]] && echo 0 || echo 2)
fi

repo="$1"
source_dir="${2:-}"
temporary_dir=""

cleanup() {
  if [[ -n "$temporary_dir" && -d "$temporary_dir" ]]; then
    rm -rf "$temporary_dir"
  fi
}
trap cleanup EXIT

if [[ -z "$source_dir" ]]; then
  if ! command -v gh >/dev/null 2>&1; then
    echo "ERROR: GitHub CLI (gh) is required when no local repository directory is supplied." >&2
    exit 1
  fi
  if ! gh auth status >/dev/null 2>&1; then
    echo "ERROR: Authenticate the GitHub CLI before running this script, or pass a local repository directory." >&2
    exit 1
  fi

  temporary_dir="$(mktemp -d)"
  source_dir="$temporary_dir/repository"
  echo "Cloning $repo for a read-only configuration scan..."
  gh repo clone "$repo" "$source_dir" -- --depth 1 >/dev/null
fi

if [[ ! -d "$source_dir" ]]; then
  echo "ERROR: Repository directory does not exist: $source_dir" >&2
  exit 1
fi

if [[ ! -d "$source_dir/.git" && "$source_dir" != "$temporary_dir/repository" ]]; then
  echo "WARNING: $source_dir is not a Git working tree; scanning the directory anyway." >&2
fi

mapfile -t referenced_vars < <(
  {
    grep -RhoE \
      --exclude-dir='.git' --exclude-dir='node_modules' --exclude-dir='dist' --exclude-dir='coverage' \
      --include='*.ts' --include='*.tsx' --include='*.js' --include='*.jsx' --include='*.mjs' --include='*.cjs' \
      'process\.env\.[A-Z][A-Z0-9_]*' "$source_dir" 2>/dev/null || true
    grep -RhoE \
      --exclude-dir='.git' --exclude-dir='node_modules' --exclude-dir='dist' --exclude-dir='coverage' \
      --include='*.html' --include='*.ts' --include='*.tsx' --include='*.js' --include='*.jsx' \
      '%VITE_[A-Z0-9_]+%' "$source_dir" 2>/dev/null || true
  } | sed -E -e 's/^process\.env\.//' -e 's/^%//' -e 's/%$//' | sort -u
)

if [[ ${#referenced_vars[@]} -eq 0 ]]; then
  echo "ERROR: No environment-variable references were found in $source_dir." >&2
  exit 1
fi

category_for() {
  case "$1" in
    DATABASE_URL) echo "required: database" ;;
    JWT_SECRET) echo "required: sessions" ;;
    VITE_APP_ID|OAUTH_SERVER_URL|OWNER_OPEN_ID) echo "required: owner OAuth" ;;
    BUILT_IN_FORGE_API_URL|BUILT_IN_FORGE_API_KEY) echo "feature: Manus storage/data" ;;
    RESEND_API_KEY) echo "optional: email" ;;
    SHIPSTATION_API_KEY|SHIPSTATION_API_SECRET) echo "optional: fulfillment" ;;
    VITE_ANALYTICS_ENDPOINT|VITE_ANALYTICS_WEBSITE_ID) echo "optional: analytics" ;;
    NODE_ENV|PORT) echo "platform-managed" ;;
    *) echo "review required" ;;
  esac
}

printf '\nRepository: %s\nScan path:   %s\n\n' "$repo" "$source_dir"
printf '%-34s %-31s %s\n' "VARIABLE" "ROLE" "SHELL STATUS"
printf '%-34s %-31s %s\n' "--------" "----" "------------"

for variable in "${referenced_vars[@]}"; do
  if [[ -n "${!variable-}" ]]; then
    status="present (value hidden)"
  else
    status="not present in this shell"
  fi
  printf '%-34s %-31s %s\n' "$variable" "$(category_for "$variable")" "$status"
done

cat <<'NOTICE'

How to interpret this result:
- This is a source-code inventory, not a secret-value validator.
- “present” means only that the variable exists in the shell that ran this script;
  the value is intentionally never displayed or checked for correctness.
- “not present in this shell” does not prove it is absent from Manus deployment
  settings. Confirm production configuration securely in the new WebDev project.
- Never paste output from `printenv`, `.env`, project settings, or secret values
  into task chat, GitHub issues, source code, or screenshots.
NOTICE
