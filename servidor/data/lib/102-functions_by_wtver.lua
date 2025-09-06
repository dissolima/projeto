local _doCreateMonster_ = doCreatureMonster
function doCreatureMonster(name, pos, extend, force, displayError)
    return _doCreateMonster_(name, pos, extend, force)
end