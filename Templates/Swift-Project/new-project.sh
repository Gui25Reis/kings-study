#!/bin/bash
set -e

# ─── Validate args ────────────────────────────────────────────────────────────

if [ -z "$1" ]; then
    echo "Usage: $0 <ProjectName>"
    echo "Example: $0 KeyboardHandler"
    exit 1
fi

PROJECT_NAME="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
DEST_DIR="$REPO_ROOT/Studies/$PROJECT_NAME"
TEMPLATE_ZIP="$SCRIPT_DIR/Template.zip"

# ─── Check if project already exists ─────────────────────────────────────────

if [ -d "$DEST_DIR" ]; then
    echo "Project already exists at Studies/$PROJECT_NAME"
    exit 1
fi

# ─── Unzip template ──────────────────────────────────────────────────────────

echo "Setting up iOS project..."
mkdir -p "$REPO_ROOT/Studies"
unzip -q "$TEMPLATE_ZIP" -d "$REPO_ROOT/Studies"
mv "$REPO_ROOT/Studies/NewProject" "$DEST_DIR"

# ─── Replace "Template" with project name in Swift files ─────────────────────

find "$DEST_DIR" -name "*.swift" -exec sed -i '' "s/Template/$PROJECT_NAME/g" {} \;

# ─── Done ────────────────────────────────────────────────────────────────────

echo ""
echo "✓ Project created at Studies/$PROJECT_NAME"
echo ""
echo "Next steps:"
echo "  cd \"$DEST_DIR\""
echo "  tuist generate --no-open"
