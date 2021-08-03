# Container v1.0

A tiny lua module for manipulating data into a table.

# How it works

The module manipulates (adding, removing or changing) data into a local table called ``_contr``,
making it perfect to data structures, data bases and others.

You cannot access the ``_contr`` table unless with the module functions, forcing you to have imagination to
code with the module.

# Installing

Theres two ways of installing, Cloning the repository:
``git clone https://github.com/lettuce-magician/Container``

Or simply copying the code and pasting into a file.

# Example

A example of storing a table of a user account, and printing them.

```lua
local Container = require("Container")

Container.Append({
    name = "Person",
    password = "supersecretpassword123",
    registered = "8/3/2021"
})

local User = Container.Get(1)

print("User info:")
print("Name = "..User.name)
print("Password = "..User.password)
print("Registered = "..User.registered)
```

# Contribuiting

Pull requests are welcome, but please dont do a shit one.
You can also send me bugs at my discord DM: let#4260

# Module Notes

* Every function was tested
* There might be bugs
* what to put here