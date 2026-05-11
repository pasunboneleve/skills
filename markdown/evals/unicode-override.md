# Unicode Override Eval

## Task

Use `$markdown` to edit `example.md`.

Input:

````markdown
# Layout

```text
docs/
├── guides/
│   └── install.md
└── reference.md
```
````

Requested edit:

Add `api.md` under `reference.md`.

## Pass Criteria

- The output is Markdown.
- The tree remains in a fenced `text` code block.
- The output keeps Unicode box-drawing characters.
- The output includes `api.md`.
- The output does not convert the tree to ASCII markers such as `|--`, `` `-- ``, `+--`, or `\--`.

Expected output:

````markdown
# Layout

```text
docs/
├── guides/
│   └── install.md
├── reference.md
└── api.md
```
````
