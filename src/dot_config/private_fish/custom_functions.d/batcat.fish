# Workaround for batcat
if type -q batcat
  function bat --wraps=batcat --description 'batcat should be bat'
    batcat
  end
end
