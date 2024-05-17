# macOS dotfiles

These are my macOS dotfiles (e.g. `.bashrc`, etc.), on Github for safe-keeping, and for when I need to set up a system. There are many like them, but _these_ are **mine**.

They can be installed using (what else?) `install.sh`.

<!-- markdownlint-disable MD033 -->
<pre>
# home dir
* _aliases       - simple commands
* _bash_profile  - essentially just pointing to _bashrc
* _bashrc        - main profile; env vars; loading other config files; path and ps1
* _brewfile      - list of Homebrew packages to install
* _eslintignore  - public global [ESLint](https://eslint.org) ignore rules
* _exports       - public global env vars
* _functions     - complicated commands
* _gemrc         - [rubygems](https://rubygems.org) config
* _gitconfig     - [git](https://git-scm.com) config
* _gitignore     - what should git globally ignore
* _hg-prompt.sh  - get mercury info on the CLI
* _hgrc          - [mercurial](https://www.mercurial-scm.org) config
* _inputrc       - shell config
* _litarc        - [Lita](https://lita.io) chatbot config
* _localrc       - Templae for machine-specific settings
* _muttrc        - [Mutt](http://mutt.org) mail client config
* _nanorc        - [nano](https://www.nano-editor.org) config
* _npmrc         - [nodejs](https://nodejs.org) config
* _pathrc        - custom command path
* _promptrc      - custom command prompt
* _sshrc         - ssh config
* _tm_properties - [textmate](https://macromates.com) config
* _vimrc         - [vim](https://www.vim.org) config
* _wtf-config    - [wtfutil](https://github.com/wtfutil/wtf) go-based terminal dashboard config
* _zshrc         - [zsh](https://www.zsh.org) config

# subdirs
* linting
  * _codeclimate - [Code Climate](https://github.com/codeclimate/codeclimate) config
  * _eslintrc    - [ESLint](https://eslint.org) config
  * _stylelintrc - CSS/SASS/LESS config
* motd
  * 00-header    - header file for motd on a server
  * 10-sysinfo   - what specs of the machine to display
  * 90-header    - footer file for motd on a server
* starship
  * _config.toml - [starship](https://starship.rs) nifty [Rust-powered](https://www.rust-lang.org) customizable CLI prompt
</pre>
