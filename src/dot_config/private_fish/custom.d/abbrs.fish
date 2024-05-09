# The Fuck
if type -q thefuck
  abbr fu 'fuck'
end

# Git
if type -q git
  abbr g 'git'
  abbr ga 'git add .'
  abbr gaa 'git add --all'
  abbr gc 'git commit'
  abbr gcm 'git commit -m'
  abbr gs 'git status'
  abbr gp 'git push'
  abbr gpl 'git pull'
  abbr gl 'git log'
  abbr gd 'git diff'
  abbr gds 'git diff --staged'
  abbr gr 'git restore .'
  abbr grs 'git restore --staged .'
  abbr gap 'git commit --amend --no-edit && git push  --force'
end
