local Container = {}
Container.__VERSION = "Container 1.0"
Container.__AUTHOR = "lettuce-magician"

local _contr = {}

local function Iter(t, i)
    i = i + 1
    local v = t[i]
    if v then
        return i, v
    end
end

--- Sets a index and a value to the container.
---
--- A string will always will be below the number indexes.
---@param Index string|number
---@param Value any
---@return any
function Container.Set(Index, Value)
    assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to Container.Set: string or number expected, got "..type(Index))

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
    assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to Container.Get: string expected, got "..type(Index))
    if _contr[Index] ~= nil then
        return _contr[Index]
    end
end

--- Calls a function in the container if exists.
---
--- Params are permitted.
---@param Index string|number
function Container.Call(Index, ...)
    assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to Container.Call: string or number expected, got "..type(Index))
    assert(type(_contr[Index]) == "function", Index.." is not a function.")

    return _contr[Index](...)
end

--- Removes a index from the container.
---
--- If ``Index`` dosent exists, rises an error.
---@param Index string|number
function Container.Remove(Index)
    assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to Container.Temp: string or number expected, got "..type(Index))
    assert(_contr[Index] ~= nil, "attempt to remove a nil index")
    _contr[Index] = nil
end

--- Checks if ``Index`` exists, if exists returns true, otherwise returns false.
---@param Index string|number
---@return boolean
function Container.Exists(Index)
    assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to Container.Exists: string or number expected, got "..type(Index))

    if _contr[Index] ~= nil then
        return true
    else
        return false
    end
end

--- A pairs-like function that can be used in a for loop.
---```lua
---for i, v in Container.Pairs() do body end
---```
function Container.Pairs()
    return next, _contr, nil
end

--- Like Containter.Pairs but it only works at number indexes and iterates over the key values.
function Container.IPairs()
    return Iter, _contr, 0
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

return setmetatable(Container, {
    __index = Container,
    __metatable = false,
})