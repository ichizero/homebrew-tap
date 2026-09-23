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

Pull requests run Homebrew's `brew test-bot` checks and build bottle artifacts
for the configured GitHub-hosted runners. After reviewing a passing pull
request, apply the `pr-pull` label to run the publish workflow. It uses
`brew pr-pull` to upload the bottles and update the Formula's bottle metadata.

See [Homebrew's documentation](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
for the tap workflow.
