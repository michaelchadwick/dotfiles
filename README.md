# macOS dotfiles

These are my macOS dotfiles (e.g. `.bashrc`, etc.), on Github for safe-keeping, and for when I need to set up a system. There are many like them, but _these_ are **mine**.

They can be installed using (what else?) `install.sh`.

<!-- markdownlint-disable MD033 -->
<pre>
# _root
  * _aliases       - simple commands
  * _bash_profile  - essentially just pointing to _bashrc
  * _bashrc        - main profile; env vars; loading other config files
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
  * _muttrc        - [Mutt](http://mutt.org) mail client config
  * _nanorc        - [nano](https://www.nano-editor.org) config
  * _npmrc         - [nodejs](https://nodejs.org) config
  * _pathrc        - custom command path
  * _promptrc      - custom command prompt
  * _sshrc         - ssh config
  * _vimrc         - [vim](https://www.vim.org) config
  * _wtf-config    - [wtfutil](https://github.com/wtfutil/wtf) go-based terminal dashboard config
  * _zprofile      - [zsh](https://www.zsh.org) login shell settings
  * _zshrc         - [zsh](https://www.zsh.org) interactive shell settings
  * _zshenv        - [zsh](https://www.zsh.org) environment variables

* _config
  * mise/config    - [mise](https://mise.jdx.dev) config
* _linting
  * _codeclimate   - [Code Climate](https://codeclimate.com) config
  * _eslintignore  - [ESLint](https://eslint.org) ignore file
  * _eslintrc      - [ESLint](https://eslint.org) config
  * _prettierrc    - [Prettier](https://prettier.io) config
  * _stylelintrc   - [Stylelint](https://stylelint.io) config
* _motd
  * 00-header      - header file for motd on a server
  * 10-sysinfo     - what specs of the machine to display
  * 90-header      - footer file for motd on a server
</pre>
