local lunajson = require("lunajson")
local json = require("dkjson")
local time = require("socket")


function Add_new_category ()
    --- This method allow admin to add new category to the Medicine_Data.json
    ::main:: do
        local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json", 'r')
        local data = file:read("*all")
        local med_db = json.decode(data)
        file:close()
        print('What is the name of new category?')
        local category_name = io.read()
        if category_name == nil or category_name:match("%S") == nil then print("Can't be blank!") goto main
        end
        med_db[category_name] = {}
        local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json", 'w')
        local data = json.encode(med_db, {indent=true})
        file:write(data)
        file:close()
        print("===============================================================")
        print(string.format("%s has been added to the category", category_name))
        print("===============================================================")
        for num = 5, 1, -1 do
            print(string.format("We'll take you back in main menu in %s", num))
            time.sleep(1)
          end
    end

end

function Add_new_product()
     --- This method allow admin to add new product to the specific category.
    ::main:: do
        local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json", 'r')
        local data = file:read("*all")
        local med_db = json.
        print('===============================')
        print("All categories are the following :)")

        print('===============================')
        print("Which category do you want to add new medicines to?")
        print("Please type in name of the category.")

    end
end
Add_new_product()