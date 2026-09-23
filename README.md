# ichizero Tap

## Installing formulae

Install a formula directly:

```sh
brew install ichizero/tap/<formula>
```

Or add the tap first, then install a formula by name:

```sh
brew tap ichizero/tap
brew install <formula>
```

For Homebrew Bundle, add the tap and formula to a `Brewfile`:

```ruby
tap "ichizero/tap"
brew "<formula>"
```

## Bottle publishing

Pull requests run Homebrew's `brew test-bot` checks and build bottles on macOS
26, macOS 27, and Linux. Bottle archives and metadata for every runner must be
present for the checks to pass. After a Formula change is merged, the same
build runs again on `main`.
Only bottles built on `main` are published, and the workflow commits their
metadata to the Formula.

See [Homebrew's documentation](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
for the tap workflow.
