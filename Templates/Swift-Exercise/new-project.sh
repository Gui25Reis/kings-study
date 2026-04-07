#!/bin/bash
set -e

# ─── Validate args ────────────────────────────────────────────────────────────

if [ -z "$1" ]; then
    echo "Usage: $0 <SiteName>"
    echo "Example: $0 HackerRank"
    exit 1
fi

SITE_NAME="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SITE_DIR="$REPO_ROOT/Exercises/$SITE_NAME"
SWIFT_DIR="$SITE_DIR/Swift"
TEMPLATE_ZIP="$SCRIPT_DIR/Template.zip"

# ─── Check if Swift project already exists ───────────────────────────────────

if [ -d "$SWIFT_DIR" ]; then
    echo "Swift project already exists at Exercises/$SITE_NAME/Swift"
    exit 1
fi

# ─── Create site folder if needed ────────────────────────────────────────────

if [ ! -d "$SITE_DIR" ]; then
    echo "Creating Exercises/$SITE_NAME..."
    mkdir -p "$SITE_DIR"
fi

# ─── Unzip template ──────────────────────────────────────────────────────────

echo "Setting up Swift project..."
unzip -q "$TEMPLATE_ZIP" -d "$SITE_DIR"
mv "$SITE_DIR/NewProject" "$SWIFT_DIR"

# ─── Replace "Template" with site name in Swift files ────────────────────────

find "$SWIFT_DIR" -name "*.swift" -exec sed -i '' "s/Template/$SITE_NAME/g" {} \;

# ─── Done ────────────────────────────────────────────────────────────────────

echo ""
echo "✓ Project created at Exercises/$SITE_NAME/Swift"
echo ""
echo "Next steps:"
echo "  cd \"$SWIFT_DIR\""
echo "  tuist generate"
