#!/usr/bin/env bash
set -euo pipefail

# Set TL to the command that runs your TargetLang source.
# Examples:
#   export TL="dune exec targetlang --"        # OCaml/dune compiler
#   export TL="python3 interpreter.py"         # Python interpreter
#   export TL='docker run --rm -v "$PWD:/app" targetlang /app'   # Docker image
: "${TL:?Set TL to your interpreter command, e.g. export TL='dune exec targetlang --'}"

# Run program, capture output
$TL wk5/all_ops.tl | tee tests/actual.txt

# Compare with expected
if diff -u tests/expected.txt tests/actual.txt; then
  echo "✅ Tests passed"
else
  echo "❌ Output differed from expected" >&2
  exit 1
fi
