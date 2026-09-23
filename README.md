# ichizero Tap

This tap provides `protoc-gen-connect-ktor`, built from the matching
`connect-ktor` source release. Homebrew uses a bottle when one is available for
the current platform and otherwise builds the Formula from source.

## Install

```sh
brew install ichizero/tap/protoc-gen-connect-ktor
```

The installed command supports `--version` and can be used as a Protocol
Buffers compiler plugin.

## Bottle publishing

Pull requests run Homebrew's `brew test-bot` checks and build bottle artifacts
for the configured GitHub-hosted runners. After reviewing a passing pull
request, apply the `pr-pull` label to run the publish workflow. It uses
`brew pr-pull` to upload the bottles and update the Formula's bottle metadata.
The current matrix covers x86_64 Linux and arm64 macOS 15/26; other CPU and OS
combinations install from source.

See [Homebrew's documentation](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
for the tap workflow.
