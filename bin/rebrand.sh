#!/usr/bin/env bash
cd "$(dirname "$0")/.."
# This script rebrands the Go module from tgk to a new name.
set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <old-module-name> <new-module-name>"
  exit 1
fi


REAL_MODULE_NAME=$(go list -m)
OLD_MODULE_NAME="${1}"
NEW_MODULE_NAME="${2}"

if [ "${REAL_MODULE_NAME}" != "${OLD_MODULE_NAME}" ]; then
  echo "Current module name (${REAL_MODULE_NAME}) does not match the old module name (${OLD_MODULE_NAME})."
  exit 1
fi

if [ ! -f main.go ]; then
  echo "main.go not found in the current directory."
  exit 1
fi
mv main.go main.go.old
sed -e "s ${OLD_MODULE_NAME} ${NEW_MODULE_NAME} g" main.go.old > main.go
rm -rf go.mod go.sum
go mod init "${NEW_MODULE_NAME}"
go mod tidy

## Ensure the frontend/dist directory exists
mkdir -p frontend/dist
touch frontend/dist/temporary

# Run tests to ensure the new module name works correctly
if ! go test; then
    echo "Tests failed after rebranding. Restoring original main.go."
    # Restore the original main.go if tests fail
    mv main.go.old main.go
    rm -rf go.mod go.sum
    go mod init "${OLD_MODULE_NAME}"
    go mod tidy
    exit 1
fi


# Clean up the old main.go file
rm main.go.old
# Create a new README.md file
cat <<-'EOF' > README.md
# ${NEW_MODULE_NAME}
This is the rebranded module ${NEW_MODULE_NAME}.
EOF

rm -rf .git bin

echo "Rebranding completed successfully from ${OLD_MODULE_NAME} to ${NEW_MODULE_NAME}."
