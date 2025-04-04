
 vim-gf-for-nodejs
====================

Enhance Vim's `gf` (go to file) behavior for Node.js projects.
This plugin makes it easier to jump into modules and local files by mimicking how Node.js resolves `require()` and `import` paths.

## 🚀 Features

- Smart file jumping for:
  - `require('some-module')`
  - `import foo from './foo'`
- Handles relative paths, `node_modules`, and optional extensions like `.js`, `.json`, `.ts`, `.mjs`
- No dependencies – no Ruby, no Node.js runtime needed

## 📦 Installation

### With [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'ats4u/vim-gf-for-nodejs'
```

### Manual

```sh
mkdir -p ~/.vim/plugin
cd ~/.vim/plugin
git clone https://github.com/ats4u/vim-gf-for-nodejs
```

## 🛠️ Usage

Place your cursor over a `require()` or `import` path and hit:

```
gf
```

That’s it! Vim will jump to the resolved file, using logic similar to Node.js resolution rules.

## 🌳 Node-style Resolution

This plugin looks for:

1. Relative files like `./foo` → `./foo.js`, `./foo/index.js`
2. Modules in `node_modules`
3. Files with omitted extensions: `.js`, `.json`, `.ts`, `.mjs`

It mimics how Node.js searches for modules when paths are not exact.

## ✅ Why This Plugin?

- Vim's built-in `gf` is too literal
- You want fast navigation in modern Node/JavaScript projects
- You don’t want to depend on Ruby or heavy language servers

## 🔧 Optional: Improve Path Detection

If you often use custom module paths (e.g., `@/utils/foo.js`), you can tweak Vim’s `path` and `suffixesadd`:

```vim
:set path+=node_modules
:set suffixesadd+=.js,.ts,.json,.mjs
```

## 🙋‍♂️ Author

Created by [Atsushi Oka](https://github.com/ats4u)
Feel free to submit issues or PRs!

## 📄 License

MIT
