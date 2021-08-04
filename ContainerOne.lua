-- Fixed version of Container 1.0 and one container based.

local Container = {}
Container.__VERSION = "Container One 1.0"
Container.__AUTHOR = "lettuce-magician"

local function iter_table(tbl, Index)
    if type(Index) ~= "number" then Index = 0 end
    Index = Index + 1
    local Value = tbl[Index]
    if Value then
        return Index, Value
    end
end

local mt = {
    __index = Container,
    __metatable = false
}

local _contr = {}

--- Sets a index and a value to the container.
---
--- A string will always will be below the number indexes.
---@param Index string|number
---@param Value any
---@return any
function Container.Set(Index, Value)
    assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to 'Set': string or number expected, got "..type(Index))

    _contr[Index] = Value

    return _contr[Index]
end

--- Appends a value to the container.
---
--- The index becomes always on the top of string indexes.
---@param Value any
---@return any
function Container.Append(Value)
    _contr[#_contr + 1] = Value
    return _contr[#_contr]
end

--- Finds a table by the index.
---@param Index string|number
---@return string|number
function Container.Get(Index)
    assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to 'Get': string expected, got "..type(Index))
    if _contr[Index] ~= nil then
        return _contr[Index]
    end
end

--- Calls a function in the container if exists.
---
--- Params are permitted.
---@param Index string|number
function Container.Call(Index, ...)
    assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to 'Call': string or number expected, got "..type(Index))
    assert(type(_contr[Index]) == "function", Index.." is not a function.")

    return _contr[Index](...)
end

--- Removes a index from the container.
---
--- If ``Index`` dosent exists, rises an error.
---@param Index string|number
function Container.Remove(Index)
    assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to 'Remove': string or number expected, got "..type(Index))
    assert(_contr[Index] ~= nil, "attempt to remove a nil index")
    _contr[Index] = nil
end

--- Checks if ``Index`` exists, if exists returns true, otherwise returns false.
---@param Index string|number
---@return boolean
function Container.Exists(Index)
    assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to 'Exists': string or number expected, got "..type(Index))

    if _contr[Index] ~= nil then
        return true
    else
        return false
    end
end

--- Does a action multiple times
---
--- ``a`` Appends, ``s`` Sets and ``r`` Removes.
---@param Mode "a"|"s"|"r"
function Container.Bulk(Mode, ...)
    local ToSet = {...}

    if Mode == "a" then
        for i, v in pairs(ToSet) do
            table.insert(_contr, i, v)
        end
    elseif Mode == "s" then
        for i, v in pairs(ToSet) do
            _contr[i] = v
        end
    elseif Mode == "r" then
        for i in pairs(ToSet) do
            if _contr[i] ~= nil then
                _contr[i] = nil
            else
                error("attempt to remove a nil index")
            end
        end
    else
        error("invalid mode, mode can only be 'a' (append), r (remove) or 's' (set)")
    end
end

--- A pairs-like function that can be used in a for loop.
---```lua
---for i, v in Container.Pairs() do body end
---```
---@return function
---@return table
---@return nil
function Container.Pairs()
    return next, _contr, nil
end

--- Iterates over the container.
---@param Index number
---@return number
---@return any
function Container.Iter(Index)
    if type(Index) ~= "number" then Index = 0 end
    Index = Index + 1
    local Value = _contr[Index]
    if Value then
        return Index, Value
    end
end

--- Like Containter.Pairs iterates over the key values.
---@return function
---@return table
---@return integer
function Container.IPairs()
    return ipairs(_contr)
end

--- Returns the size of the container
---@return integer
function Container.Size()
    return #_contr
end

--- Returns the first index in the container.
---@return any
function Container.First()
    return _contr[1]
end

--- Returns the last index in the container.
---@return any
function Container.Last()
    return _contr[#_contr]
end

--- Clears the container.
function Container.Clear()
    _contr = {}
end

return setmetatable(Container, mt)