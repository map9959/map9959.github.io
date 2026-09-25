#!/usr/bin/env bash
set -euo pipefail

# Respect the working Gemfile.lock, including intentional dependency updates.
bundle check || bundle install --jobs 4 --retry 3

# Keep generated files inside the container rather than on the bind mount.
exec bundle exec jekyll serve \
  --host=0.0.0.0 --port=8080 --livereload --force_polling \
  --destination=/tmp/_site "$@"
