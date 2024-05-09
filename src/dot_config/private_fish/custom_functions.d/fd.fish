# Workaround for fdfind
if type -q fdfind
  function fd --wraps=fdfind --description 'fdfind should be fd'
    fdfind $argv
  end
end
