# Container v2.0

Two lua modules for manipulating data into a table (aka Container).

# How it works

## ContainerOne

The module manipulates (adding, removing or changing) data into a local table called ``_contr``,
making it perfect to data structures, data bases and others.

You cannot access the ``_contr`` table unless with the module functions, forcing you to have imagination to
code with the module.

## Container

The module allows you to create more than 1 container, perfect to big databases.

# Installing

Theres two ways of installing, Cloning the repository:
``git clone https://github.com/lettuce-magician/Container``

Or simply copying the code and pasting into a file.

# Example

A example of storing a table of a user account, and printing them.

```lua
local Container = require("ContainerOne")

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

Another example of creating two Containers with user's occupation and outputting them.

```lua
local Container = require("Container")

local Person = Container.Create("Person")

Person:Set("Name", "Jeff")
Person:Set("Age", 25)
Person:Set("Occupation", "None")

local Person2 = Container.Clone("Person", "Person2")

Person2:Set("Name", "Bob")
Person2:Set("Age", 27)
Person2:Set("Occupation", "Coder")

print("Jeff's Occupation: "..Person:Get("Occupation"))
print("Bob's Occupation: "..Person2:Get("Occupation"))
```

# Contribuiting

Pull requests are welcome, but please dont do a shit one.
You can also send me bugs or suggestions at my discord DM: let#4260

# Module Notes

* Every function was tested
* There might be bugs
* what to put here