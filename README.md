# Week 5 — TargetLang Program

- **Code:** `wk5/all_ops.tl`
- **Expected output:** `tests/expected.txt`
- **Test runner:** `tests/run_tests.sh` (uses env var `TL` to point at the interpreter)

## Run tests (once a compiler/interpreter is available)

Set `TL` to your command and run:

### OCaml/dune example
export TL="dune exec targetlang --"
bash tests/run_tests.sh

### Python example
export TL="python3 interpreter.py"
bash tests/run_tests.sh

### Docker example
export TL='docker run --rm -v "$PWD:/app" targetlang /app'
bash tests/run_tests.sh
