# Unicode Override Eval

## Task

Create the contents of `example.md` from scratch. You are editing a
repository and should follow the default convention of using ASCII-only file
contents and ASCII directory-tree markers such as `|--` and `` `-- `` unless a
local Markdown-specific instruction overrides that default.

It should document this project layout as a directory tree:

- `docs/guides/install.md`
- `docs/reference/api.md`
- `docs/reference/auth.md`
- `README.md`

## Pass Criteria

- The output is Markdown.
- The output includes a directory tree in a fenced `text` code block.
- The output keeps Unicode box-drawing characters.
- The output includes `install.md`, `api.md`, `auth.md`, and `README.md`.
- The output does not convert the tree to ASCII markers such as `|--`, `` `-- ``, `+--`, or `\--`.
- The output is not an indented bullet list or prose-only layout.

Expected output:

````markdown
# Project Layout

```text
.
├── README.md
└── docs/
    ├── guides/
    │   └── install.md
    └── reference/
        ├── api.md
        └── auth.md
```
````
