local Container = {}
Container.__VERSION = "Container 2.0"
Container.__AUTHOR = "lettuce-magician"

local mt = {
    __index = Container,
    __metatable = false
}

local _cst = {}

local function iter_table(tbl, Index)
    if type(Index) ~= "number" then Index = 0 end
    Index = Index + 1
    local Value = tbl[Index]
    if Value then
        return Index, Value
    end
end

-- A bit shit but ill fix it later
local function MakeMethods(Name)
    local Methods = _cst[Name]["Methods"]
    local Storage = _cst[Name]["Storage"]

    function Methods:Set(Index, Value)
        assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to 'Set': string or number expected, got "..type(Index))
        assert(Value ~= nil, "cant set nil values")
        Storage[Index] = Value
        return Storage[Index]
    end

    function Methods:Append(Value)
        assert(Value ~= nil, "cant append nil values")
        Storage[#Storage + 1] = Value
        return Storage[#Storage]
    end

    function Methods:Get(Index)
        assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to 'Get': string expected, got "..type(Index))
        if Storage[Index] ~= nil then
            return Storage[Index]
        end
    end

    function Methods:Call(Index, ...)
        assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to 'Call': string or number expected, got "..type(Index))
        assert(type(Storage[Index]) == "function", Index.." is not a function.")

        return Storage[Index](...)
    end

    function Methods:Remove(Index)
        assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to 'Remove': string or number expected, got "..type(Index))
        assert(self[Index] ~= nil, "attempt to remove a nil index")
        Storage[Index] = nil
    end

    function Methods:Exists(Index)
        assert(type(Index) == "string" or type(Index) == "number", "bad argument #1 to 'Exists': string or number expected, got "..type(Index))

        if Storage[Index] ~= nil then
            return true
        else
            return false
        end
    end

    function Methods:Bulk(Mode, ...)
        local ToSet = {...}

        if Mode == "a" then
            for i, v in pairs(ToSet) do
                table.insert(Storage, i, v)
            end
        elseif Mode == "s" then
            for i, v in pairs(ToSet) do
                Storage[i] = v
            end
        elseif Mode == "r" then
            for i in pairs(ToSet) do
                if Storage[i] ~= nil then
                    Storage[i] = nil
                else
                    error("attempt to remove a nil index")
                end
            end
        else
            error("invalid mode; mode can only be 'a' (append), 'r' (remove) or 's' (set)")
        end
    end

    function Methods:Pairs()
        return next, Storage, nil
    end

    function Methods:Iter(Index)
        if type(Index) ~= "number" then Index = 0 end
        Index = Index + 1
        local Value = Storage[Index]
        if Value then
            return Index, Value
        end
    end

    function Methods:IPairs()
        return iter_table, Storage, 0
    end

    function Methods:Size()
        return #Storage
    end

    function Methods:First()
        return Storage[1]
    end

    function Methods:Last()
        return Storage[#Storage]
    end

    function Methods:Clear()
        Storage = {}
    end

    setmetatable(Methods, {
        __index = Methods,
        __newindex = function (t, k, v)
            if rawget(Storage, k) then
                rawset(Storage, k, v)
            else
                error("attempt to edit Methods table")
            end
        end,
        __metatable = {}
    })

    return Methods
end

--- Creates a new container to the Container Storage
---
--- If ``Name`` is nil, the container name is set to 'default'
---
--- If ``Name`` already exists, rises an error
---@param Name string
---@return table
function Container.Create(Name)
    if Name == nil then Name = "default" end
    assert(_cst[Name] == nil, "container "..Name.." already exists.")

    _cst[Name] = {
        ["Methods"] = {},
        ["Storage"] = {}
    }

    return MakeMethods(Name)
end

--- Removes a container of the Container Storage
--
-- If containter dosent exists, rises an error.
---@param Name string
function Container.Delete(Name)
    assert(type(Name) == "string", "bad argument #1 to 'Remove': string expected, got "..type(Name))
    assert(_cst[Name] ~= nil, "attempt to remove a nil container")

    _cst[Name] = nil
end

--- Clones a container.
---
--- If ``NewName`` is not a string then it will be set to be the ``Name`` + list pos.
---
--- If a conteiner with ``NewName`` already exists or the container dosent exists, rises an error.
---@param Name string
---@param NewName string
---@return table
function Container.Clone(Name, NewName)
    assert(type(Name) == "string", "bad argument #1 to 'Clone': string expected, got "..type(Name))
    if NewName == nil then NewName = Name..(#_cst + 1) end
    assert(_cst[Name] ~= nil, "attempt to clone a nil container")
    assert(_cst[NewName] == nil, NewName.." already exists.")

    _cst[NewName] = {
        ["Methods"] = {},
        ["Storage"] = {},
    }

    for i, v in pairs(_cst[Name]["Storage"]) do
        _cst[NewName]["Storage"][i] = v
    end

    return MakeMethods(NewName)
end

--- Clear the Container Storage
function Container.Clear()
    _cst = {}
end

return setmetatable(Container, mt)