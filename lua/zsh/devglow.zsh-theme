# ──────────────────────────────────────────────────────────
#  devglow — warm minimal two-line prompt
#  Matches the devglow Neovim colorscheme palette
# ──────────────────────────────────────────────────────────

# Palette (256-color, matched to devglow.lua)
local _orange="%F{173}"   # #D59572
local _yellow="%F{179}"   # #E5B567
local _green="%F{109}"    # #87AFAF
local _red="%F{131}"      # #AF5F5F
local _pink="%F{174}"     # #D68C8C
local _blue="%F{67}"      # #7590AF
local _grey="%F{243}"     # #797979
local _dim="%F{237}"      # #3A3A3A
local _fg="%F{254}"       # #E6E6E6
local _r="%f"
local _b="%B"
local _nb="%b"

# Nerd Font icons (using escape sequences for reliability)
local _icon_dir=$'\uf07b'         # nf-fa-folder
local _icon_branch=$'\ue725'      # nf-dev-git_branch
local _icon_commit=$'\uf417'      # nf-oct-git_commit
local _icon_stash=$'\uf487'       # nf-oct-package
local _icon_node=$'\ue718'        # nf-dev-nodejs_small
local _icon_python=$'\ue73c'      # nf-dev-python
local _icon_go=$'\ue724'          # nf-dev-go
local _icon_rust=$'\ue7a8'        # nf-dev-rust
local _icon_java=$'\ue738'        # nf-dev-java
local _icon_c=$'\ue61e'           # nf-custom-c
local _icon_cpp=$'\ue61d'         # nf-custom-cpp
local _icon_lua=$'\ue620'         # nf-seti-lua
local _icon_ruby=$'\ue739'        # nf-dev-ruby_rough
local _icon_php=$'\ue73d'         # nf-dev-php
local _icon_dart=$'\ue798'        # nf-dev-dart
local _icon_zig=$'\ue6a9'         # nf-seti-zig
local _icon_elixir=$'\ue62d'      # nf-seti-elixir
local _icon_bun=$'\U000f1972'     # nf-md-bun
local _icon_docker=$'\ue7b0'      # nf-dev-docker
local _icon_nix=$'\uf313'         # nf-linux-nixos
local _icon_ssh=$'\uf489'         # nf-oct-terminal
local _icon_time=$'\uf43a'        # nf-oct-clock
local _icon_tunnel=$'\uf483'      # nf-oct-key
local _icon_dirty="●"
local _icon_staged="◉"
local _icon_untracked="◌"
local _icon_up="↑"
local _icon_down="↓"
local _icon_diverged="↕"

# Timer — track command execution time
_devglow_cmd_start=0

preexec() {
  _devglow_cmd_start=$EPOCHSECONDS
}

precmd() {
  local exit_code=$?
  local now=$EPOCHSECONDS

  # ── Path (full with ~ substitution) ──
  _devglow_path="${PWD/#$HOME/~}"

  # ── Execution time ──
  _devglow_timer=""
  if [[ $_devglow_cmd_start -gt 0 ]]; then
    local elapsed=$(( now - _devglow_cmd_start ))
    if [[ $elapsed -ge 3 ]]; then
      if [[ $elapsed -ge 3600 ]]; then
        _devglow_timer=" ${_dim}│${_r} ${_grey}${_icon_time} $(( elapsed / 3600 ))h$(( (elapsed % 3600) / 60 ))m$(( elapsed % 60 ))s${_r}"
      elif [[ $elapsed -ge 60 ]]; then
        _devglow_timer=" ${_dim}│${_r} ${_grey}${_icon_time} $(( elapsed / 60 ))m$(( elapsed % 60 ))s${_r}"
      else
        _devglow_timer=" ${_dim}│${_r} ${_grey}${_icon_time} ${elapsed}s${_r}"
      fi
    fi
  fi
  _devglow_cmd_start=0

  # ── Language detection (icon before path) ──
  _devglow_lang_icon="${_orange}${_icon_dir}"
  if [[ -f "bun.lock" || -f "bun.lockb" || -f "bunfig.toml" ]]; then
    _devglow_lang_icon="${_yellow}${_icon_bun}"
  elif [[ -f "package.json" || -f ".nvmrc" || -f ".node-version" ]]; then
    _devglow_lang_icon="${_green}${_icon_node}"
  elif [[ -f "go.mod" || -f "go.sum" ]]; then
    _devglow_lang_icon="${_blue}${_icon_go}"
  elif [[ -f "Cargo.toml" ]]; then
    _devglow_lang_icon="${_orange}${_icon_rust}"
  elif [[ -f "requirements.txt" || -f "pyproject.toml" || -f "setup.py" || -f "Pipfile" || -n "$VIRTUAL_ENV" ]]; then
    _devglow_lang_icon="${_blue}${_icon_python}"
  elif [[ -f "pom.xml" || -f "build.gradle" || -f "build.gradle.kts" ]]; then
    _devglow_lang_icon="${_red}${_icon_java}"
  elif [[ -f "Makefile" || -f "CMakeLists.txt" ]]; then
    if (setopt nullglob; set -- *.cpp *.cxx *.cc *.hpp; [[ $# -gt 0 ]]); then
      _devglow_lang_icon="${_blue}${_icon_cpp}"
    else
      _devglow_lang_icon="${_blue}${_icon_c}"
    fi
  elif [[ -f "pubspec.yaml" ]]; then
    _devglow_lang_icon="${_blue}${_icon_dart}"
  elif [[ -f "Gemfile" ]]; then
    _devglow_lang_icon="${_red}${_icon_ruby}"
  elif [[ -f "composer.json" ]]; then
    _devglow_lang_icon="${_pink}${_icon_php}"
  elif [[ -f "build.zig" ]]; then
    _devglow_lang_icon="${_yellow}${_icon_zig}"
  elif [[ -f "mix.exs" ]]; then
    _devglow_lang_icon="${_pink}${_icon_elixir}"
  elif [[ -f ".luarc.json" ]] || (setopt nullglob; set -- *.lua; [[ $# -gt 0 ]]); then
    _devglow_lang_icon="${_blue}${_icon_lua}"
  elif [[ -f "flake.nix" || -f "default.nix" ]]; then
    _devglow_lang_icon="${_blue}${_icon_nix}"
  elif [[ -f "Dockerfile" || -f "docker-compose.yml" || -f "docker-compose.yaml" ]]; then
    _devglow_lang_icon="${_blue}${_icon_docker}"
  fi

  # ── Git ──
  _devglow_git=""
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  local detached=0
  if [[ -z "$branch" ]]; then
    branch=$(git describe --tags --exact-match HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && detached=1
  fi

  if [[ -n "$branch" ]]; then
    local marks=""
    local git_status=$(git status --porcelain 2>/dev/null)

    local staged=$(echo "$git_status" | grep -c '^[MADRC]' 2>/dev/null)
    local dirty=$(echo "$git_status" | grep -c '^.[MADRC]' 2>/dev/null)
    local untracked=$(echo "$git_status" | grep -c '^??' 2>/dev/null)

    [[ $staged -gt 0 ]] && marks+=" ${_green}${_icon_staged} ${staged}${_r}"
    [[ $dirty -gt 0 ]] && marks+=" ${_yellow}${_icon_dirty} ${dirty}${_r}"
    [[ $untracked -gt 0 ]] && marks+=" ${_pink}${_icon_untracked} ${untracked}${_r}"

    local arrows=""
    local ahead behind
    ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)
    behind=$(git rev-list --count HEAD..@{u} 2>/dev/null)
    [[ "$ahead" -gt 0 && "$behind" -gt 0 ]] 2>/dev/null && arrows=" ${_pink}${_icon_diverged}${_r}"
    [[ "$ahead" -gt 0 && "$behind" -eq 0 ]] 2>/dev/null && arrows=" ${_green}${_icon_up}${ahead}${_r}"
    [[ "$ahead" -eq 0 && "$behind" -gt 0 ]] 2>/dev/null && arrows=" ${_red}${_icon_down}${behind}${_r}"

    local stash_count=$(git stash list 2>/dev/null | wc -l)
    local stash_info=""
    [[ $stash_count -gt 0 ]] && stash_info=" ${_blue}${_icon_stash} ${stash_count}${_r}"

    local hash=$(git rev-parse --short HEAD 2>/dev/null)
    local hash_info=""
    [[ -n "$hash" ]] && hash_info=" ${_grey}${_icon_commit} ${hash}${_r}"

    local branch_icon="${_icon_branch}"
    [[ $detached -eq 1 ]] && branch_icon="${_icon_commit}"

    _devglow_git=" ${_dim}│${_r} ${_green}${branch_icon} ${branch} ${_r}${marks} ${arrows}${stash_info}${hash_info}"
  fi

  # ── SSH ──
  _devglow_ssh=""
  if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
    local ssh_ip=$(echo "$SSH_CLIENT" | awk '{print $1}')
    local ssh_port=$(echo "$SSH_CLIENT" | awk '{print $3}')
    local ssh_info="${_red}${_icon_ssh} %n@%m${_r} ${_grey}${ssh_ip}:${ssh_port}${_r}"

    # Detect forwarded/tunneled session
    if [[ -n "$SSH_AUTH_SOCK" && "$SSH_AUTH_SOCK" == */agent.* ]]; then
      ssh_info+=" ${_pink}${_icon_tunnel}${_r}"
    fi

    _devglow_ssh="${ssh_info} ${_dim}│${_r} "
  fi

  # ── Virtualenv ──
  _devglow_venv=""
  if [[ -n "$VIRTUAL_ENV" ]]; then
    _devglow_venv=" ${_dim}│${_r} ${_blue}${_icon_python} ${VIRTUAL_ENV:t}${_r}"
  fi

  # ── Runtime versions (only when project file detected) ──
  _devglow_runtime=""
  if [[ -f "bun.lock" || -f "bun.lockb" || -f "bunfig.toml" ]] && command -v bun &>/dev/null; then
    _devglow_runtime+=" ${_dim}│${_r} ${_yellow}${_icon_bun} $(bun --version 2>/dev/null)${_r}"
  elif [[ -f "package.json" || -f ".nvmrc" || -f ".node-version" ]] && command -v node &>/dev/null; then
    _devglow_runtime+=" ${_dim}│${_r} ${_green}${_icon_node} $(node -v 2>/dev/null)${_r}"
  fi
  if [[ -f "go.mod" ]] && command -v go &>/dev/null; then
    _devglow_runtime+=" ${_dim}│${_r} ${_blue}${_icon_go} $(go version 2>/dev/null | cut -d' ' -f3 | sed 's/go//')${_r}"
  fi
  if [[ -f "Cargo.toml" ]] && command -v rustc &>/dev/null; then
    _devglow_runtime+=" ${_dim}│${_r} ${_orange}${_icon_rust} $(rustc --version 2>/dev/null | cut -d' ' -f2)${_r}"
  fi
  if [[ -f "pom.xml" || -f "build.gradle" || -f "build.gradle.kts" ]] && command -v java &>/dev/null; then
    _devglow_runtime+=" ${_dim}│${_r} ${_red}${_icon_java} $(java -version 2>&1 | head -1 | cut -d'"' -f2)${_r}"
  fi

  # ── Exit code ──
  _devglow_exit=""
  [[ $exit_code -ne 0 ]] && _devglow_exit=" ${_dim}│${_r} ${_red}✘ ${exit_code}${_r}"
}

# Disable default virtualenv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

PROMPT='
${_devglow_ssh}${_b}${_orange}${_devglow_path}${_nb}${_r}${_devglow_git}${_devglow_venv}${_devglow_runtime}${_devglow_exit}${_devglow_timer}
%(?:${_orange}❯:${_red}❯)${_r} '

RPROMPT='${_dim}%T${_r}'
