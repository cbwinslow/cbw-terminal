# ==============================
# 🚀 Hacker-Themed Bash Config by CBW
# ~/.bashrc
# ==============================

# 🟢 Hacker Neon Prompt
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1='\[\e[1;32m\]\u@\h:\w \$\[\e[0m\] '

# 🟢 ASCII Banner
echo -e "\e[32m"
cat << "EOF"
███████╗███╗   ██╗ ██████╗  █████╗ ██████╗ ███████╗
██╔════╝████╗  ██║██╔════╝ ██╔══██╗██╔══██╗██╔════╝
███████╗██╔██╗ ██║██║  ███╗███████║██████╔╝█████╗  
╚════██║██║╚██╗██║██║   ██║██╔══██║██╔═══╝ ██╔══╝  
███████║██║ ╚████║╚██████╔╝██║  ██║██║     ███████╗
╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚══════╝
EOF
echo -e "\e[0m"

# 🧠 Bash Completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# 🧠 Command Typo Fixer
if command -v thefuck &> /dev/null; then
    eval "$(thefuck --alias)"
fi

# 🧠 Autojump
if command -v autojump &> /dev/null; then
    . /usr/share/autojump/autojump.sh
fi

# 📁 Enhanced 'cd' with suggestions
cd() {
    if [ -d "$1" ]; then
        builtin cd "$1"
    else
        echo -e "\e[1;31m[ERROR] Directory not found:\e[0m $1"
        echo "Did you mean?"
        find . -type d -iname "*$1*" 2>/dev/null | head -n 5
    fi
}

# ❌ Smart Command Not Found
command_not_found_handle() {
    echo -e "\e[1;31m[ERROR] Command not found:\e[0m $1"
    echo "Searching for similar commands..."
    compgen -c | grep -i "^$1" | head -n 5
}

# 🧪 Matrix Effect (requires cmatrix)
alias matrix="cmatrix -C green"

# 📂 File Explorer (fzf + bat)
explorer() {
    fzf --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {} 2>/dev/null || tree -C {} 2>/dev/null'
}

# 📚 Google with Autocomplete
google() {
    local query
    query=$(echo "" | fzf --print-query --preview 'curl -s "https://suggestqueries.google.com/complete/search?client=firefox&q={q}" | jq -r .[1][]' --preview-window=down:10:wrap)
    if [ -n "$query" ]; then
        xdg-open "https://www.google.com/search?q=$(echo "$query" | sed 's/ /+/g')"
    fi
}

# 📚 Wikipedia Search
wiki() {
    xdg-open "https://en.wikipedia.org/wiki/$(echo "$*" | sed 's/ /_/g')"
}

# 💬 ChatGPT Terminal Prompt (simulated)
chatgpt() {
    echo -e "\e[32m[ChatGPT Query]\e[0m $*"
    echo "This is a placeholder. Real ChatGPT integration requires OpenAI API + script."
}

# 🧠 Restart Shell
restart_shell() {
    exec bash
}

# 🧪 Useful Aliases
alias ls='ls --color=auto -lah'
alias ll='ls -lh'
alias la='ls -A'

# 📜 Save command history immediately
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# ✅ Enable Directory Spellcheck
shopt -s cdspell

# ==============================
# 🔥 END OF .bashrc — CBW Edition
# ==============================
