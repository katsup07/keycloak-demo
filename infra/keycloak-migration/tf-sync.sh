#!/usr/bin/env bash
set -euo pipefail

echo "tf-sync.sh has been removed. Use one of the split flows instead:" >&2
echo "  - make tf-sync-console-to-code  # Console → Code" >&2
echo "  - make tf-sync-code-to-console  # Code → Console" >&2
exit 1
