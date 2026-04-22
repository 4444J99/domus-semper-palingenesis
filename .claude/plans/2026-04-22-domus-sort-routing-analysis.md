# domus-sort Routing Analysis

Date: 2026-04-22

## Finding

`routing-law.yaml` was not found in this repository or any direct parent directory. A repository search for `routing-law.yaml` and `*routing*law*` also returned no source file.

The source script requested as `dot_local/bin/executable_domus-sort` does not exist as a plain source file. In this chezmoi repository the sorter source is `dot_local/bin/executable_domus-sort.tmpl`; tests render that template into a runtime `domus-sort` executable.

Because the routing law file is absent, this document records the current `domus-sort` classifier and proposes how it should derive from a future `routing-law.yaml` property system.

## Current Source Of Truth

Current runtime configuration is read from:

- Runtime manifest: `~/.config/domus/manifest.yaml`
- Chezmoi source: `dot_config/domus/manifest.yaml`
- Sorter source: `dot_local/bin/executable_domus-sort.tmpl`

The sorter currently depends on `yq` for manifest parsing. Watch mode also depends on `fswatch`.

## Current Classifier Behavior

`domus-sort` is an ordered first-match classifier over the top-level files in configured directories.

Input scope:

- Reads `.sorting.directories[]` from the manifest.
- Current source manifest watches `~/Downloads` and `~/Desktop`.
- Processing is non-recursive: `find "$dir" -maxdepth 1 -type f`.

Hardcoded skips before classification:

- Non-files.
- Hidden files where basename starts with `.`.
- Partial download suffixes: `.crdownload`, `.part`, `.download`.

Per-rule match predicates:

- `match.location`: exact directory match after `~` expansion.
- `match.pattern`: Bash filename glob.
- `match.extension[]`: lowercased final filename extension compared against a generated regular expression.
- `match.age_days_min`: file mtime age in whole days.
- `match.exclude_pattern`: Bash regex against filename; a match excludes the file.

Per-rule action:

- `action.move_to`: destination directory template.
- `action.rename`: optional basename template. If present, the original extension is appended after expansion.
- Destination templates support `{year}`, `{month}`, `{day}`, `{filename}`, `{ext}`, `{basename}`, `{smart_name}`.
- `{year}`, `{month}`, and `{day}` are the current run date, not file creation date or mtime.
- `{smart_name}` uses PDF metadata title when available through `pdfinfo`, otherwise a sanitized original PDF basename.

Move behavior:

- Creates the destination directory.
- If destination exists, appends `-1`, `-2`, etc. before the extension.
- Logs to `~/.local/state/domus/sort.log`.
- Sends `domus-notify --level quiet --event sorting.file_moved` when `domus-notify` is executable.
- Exit code `1` means one or more files were moved; `0` means no moves or dry-run success; `2` is used for errors through shared `die` handling.

Watch behavior:

- Watches configured directories with `fswatch -0 --event Created --event MovedTo`.
- Uses one global debounce file with a 5 second debounce.
- Sleeps 1 second before processing the event path.

## Current Manifest Rules

The current source manifest rules are:

| Rule | Match | Destination | Notes |
| --- | --- | --- | --- |
| `screenshots` | `location: ~/Desktop`, `pattern: "Screenshot*.png"` | `~/Pictures/Screenshots/{year}/{month}/` | Runs before general image handling. |
| `pdfs` | `extension: [pdf]` | `~/Documents/PDFs/{year}/`, rename `{smart_name}` | Applies to PDFs in any watched directory. |
| `installers` | `extension: [dmg, pkg]` | `~/Downloads/_Installers/` | Applies to Desktop and Downloads because no location is specified. |
| `archives` | `extension: [zip, tar, gz, 7z, rar]` | `~/Downloads/_Archives/{year}/` | Uses only the final extension, so `tar.gz` is classified by `gz`. |
| `images` | `location: ~/Downloads`, `extension: [jpg, jpeg, png, gif, webp, heic]` | `~/Pictures/Downloads/{year}/{month}/` | Does not apply to Desktop images except screenshots. |
| `old-downloads` | `location: ~/Downloads`, `age_days_min: 30`, `exclude_pattern: "^_"` | `~/Downloads/_Archive/{year}/` | Catch-all stale download rule after all type-specific rules. |

Order matters. For example, a 30-day-old PDF in `~/Downloads` is handled by `pdfs`, not `old-downloads`. A Desktop `.dmg` is moved into `~/Downloads/_Installers/` because the installer rule is not source-limited.

## Inferred Routing-Law Property Mapping

There is no existing `routing-law.yaml` schema in the repo, so this is the proposed bridge from a property-based law into the current domus-sort classifier.

| routing-law property | Current domus-sort equivalent | Status |
| --- | --- | --- |
| `schema` / `version` | None | New law metadata only. |
| `sorter.roots[]` or `scope.inputs[]` | `.sorting.directories[]` | Direct mapping. |
| `routes[].id` | `.sorting.rules[].name` | Direct mapping. |
| `routes[].priority` | Rule list order | Sort by priority, then emit in order. |
| `routes[].when.source.path` | `.match.location` | Direct mapping for exact source directories. |
| `routes[].when.filename.glob` | `.match.pattern` | Direct mapping to Bash glob. |
| `routes[].when.file.extension[]` | `.match.extension[]` | Direct mapping, but current implementation only sees final extension. |
| `routes[].when.file.age.min_days` | `.match.age_days_min` | Direct mapping using mtime. |
| `routes[].when.filename.exclude_regex` | `.match.exclude_pattern` | Direct mapping to Bash regex. |
| `routes[].class.kind` | Rule name only | Missing explicit field today. |
| `routes[].class.subtype` | Rule name only | Missing explicit field today. |
| `routes[].class.lifecycle` | Rule name / age predicate | Missing explicit field today. |
| `routes[].route.destination` | `.action.move_to` | Direct mapping. |
| `routes[].route.rename` | `.action.rename` | Direct mapping. |
| `routes[].route.collision` | Hardcoded numeric suffix | Should become explicit, default `numeric_suffix`. |
| `routes[].route.notify.event` | Hardcoded `sorting.file_moved` | Should become explicit or a default. |
| `sorter.defaults.ignore_hidden` | Hardcoded skip | Should become explicit default. |
| `sorter.defaults.ignore_partial_downloads` | Hardcoded skip | Should become explicit default. |
| `sorter.defaults.depth` | Hardcoded `1` | Should become explicit default. |
| `sorter.watch.events[]` | Hardcoded `Created`, `MovedTo` | Should become explicit default. |
| `sorter.watch.debounce_seconds` | Hardcoded `5` | Should become explicit default. |
| `sorter.templates.clock` | Hardcoded run date | Should specify `run_date`, `mtime`, `ctime`, or metadata date. |

## Current Rules As Routing Properties

| Current rule | Inferred properties |
| --- | --- |
| `screenshots` | `kind: image`, `subtype: screenshot`, `source_role: desktop`, `extension: png`, `filename_glob: Screenshot*.png`, `destination_role: screenshots` |
| `pdfs` | `kind: document`, `format: pdf`, `source_role: watched`, `rename_strategy: pdf_title_or_basename`, `destination_role: documents/pdf` |
| `installers` | `kind: installer`, `format: dmg/pkg`, `source_role: watched`, `destination_role: downloads/installers` |
| `archives` | `kind: archive`, `format: zip/tar/gz/7z/rar`, `source_role: watched`, `destination_role: downloads/archives` |
| `images` | `kind: image`, `source_role: downloads`, `format: jpg/jpeg/png/gif/webp/heic`, `destination_role: pictures/downloads` |
| `old-downloads` | `kind: unknown`, `lifecycle: stale`, `source_role: downloads`, `min_age_days: 30`, `exclude_control_prefix: _`, `destination_role: downloads/archive` |

## Proposed `routing-law.yaml` Shape

The law should be more semantic than the generated manifest. It should describe properties first, then compile into the existing manifest shape.

```yaml
schema: routing-law/v1

sorter:
  roots:
    - ~/Downloads
    - ~/Desktop
  defaults:
    depth: 1
    ignore_hidden: true
    ignore_partial_downloads:
      - .crdownload
      - .part
      - .download
    collision: numeric_suffix
    template_time_basis: run_date
  watch:
    events: [Created, MovedTo]
    debounce_seconds: 5
    settle_seconds: 1

routes:
  - id: screenshots
    priority: 10
    when:
      source:
        path: ~/Desktop
      filename:
        glob: "Screenshot*.png"
      file:
        extension: [png]
    class:
      kind: image
      subtype: screenshot
      source_role: desktop
    route:
      destination: "~/Pictures/Screenshots/{year}/{month}/"

  - id: pdfs
    priority: 20
    when:
      file:
        extension: [pdf]
    class:
      kind: document
      format: pdf
    route:
      destination: "~/Documents/PDFs/{year}/"
      rename: "{smart_name}"

  - id: installers
    priority: 30
    when:
      file:
        extension: [dmg, pkg]
    class:
      kind: installer
    route:
      destination: "~/Downloads/_Installers/"

  - id: archives
    priority: 40
    when:
      file:
        extension: [zip, tar, gz, 7z, rar]
    class:
      kind: archive
    route:
      destination: "~/Downloads/_Archives/{year}/"

  - id: images
    priority: 50
    when:
      source:
        path: ~/Downloads
      file:
        extension: [jpg, jpeg, png, gif, webp, heic]
    class:
      kind: image
      source_role: downloads
    route:
      destination: "~/Pictures/Downloads/{year}/{month}/"

  - id: old-downloads
    priority: 90
    when:
      source:
        path: ~/Downloads
      file:
        age:
          min_days: 30
      filename:
        exclude_regex: "^_"
    class:
      kind: unknown
      lifecycle: stale
    route:
      destination: "~/Downloads/_Archive/{year}/"
```

## Derivation Plan

1. Add `routing-law.yaml` as the canonical sorter policy.
2. Add a generator or manifest rendering step that compiles `routing-law.yaml` into the existing `sorting:` block in `dot_config/domus/manifest.yaml`.
3. Keep `domus-sort` reading the manifest initially. That limits runtime churn and preserves current tests.
4. Compile `sorter.roots[]` to `.sorting.directories[]`.
5. Compile `routes[]` sorted by `priority` to `.sorting.rules[]`.
6. Map only supported predicates at first: source path, filename glob, extension, min age days, exclude regex.
7. Fail validation on unsupported law predicates instead of silently dropping them.
8. Preserve current hardcoded defaults in generated output until the script is taught to read explicit defaults.
9. Add tests with a fixture `routing-law.yaml` proving it generates the current six manifest rules exactly.
10. Add one behavior test for route precedence so semantic priority cannot drift from first-match classifier order.

## Gaps To Resolve Before Implementation

- The current classifier cannot represent explicit `kind`, `subtype`, `lifecycle`, or `destination_role`; those would exist only in `routing-law.yaml` unless `domus-sort` gains structured event logging.
- Template time basis is implicit and currently uses the run date. A routing law should state this because users often expect media or document dates.
- Extension handling is simplistic for compound extensions. If `routing-law.yaml` wants `tar.gz` as a format, the classifier needs a compound-extension predicate.
- `get_exif_date` exists in the script but is not used by template expansion. A routing law that routes photos by capture date would require implementation work.
- Current watch debounce is global, not per path. This can drop closely spaced file events in different watched directories.
- The source manifest allows broad Desktop moves for PDFs, installers, and archives. A routing law should make that breadth intentional through a `source_role: watched` or explicit source list.
