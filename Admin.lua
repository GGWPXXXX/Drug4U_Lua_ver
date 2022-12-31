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
    local med_name = nil
    local med_uses = nil
    local med_side_effect = nil
    local med_precautions = nil
    local med_price = nil
    local med_amount = nil
     --- This method allow admin to add new product to the specific category.
    ::main:: do
        local category_dict = {}
        local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json", 'r')
        local data = file:read("*all")
        local med_db = json.decode(data)
        file:close()
        print('===============================')
        print("All categories are the following :)\n")
        local count = 1
        for k, v in pairs(med_db)do
            print(string.format("%s. %s", count, k))
            category_dict[tostring(count)] = k
            count = count + 1
        end
        print('\n===============================')
        print("Which category do you want to add new medicines to?")
        print("Please type in menu number of the category.")
        local choice = io.read()
        
        --- Check input
        local found = nil
        for k, v in pairs(category_dict)do
            if choice == k then found = true break else found = false
            end
        end
        if found == false then print("Wrong Choice!") time.sleep(1) goto main
        end

        ::name:: do
            print("Name of the medicine?")
            med_name = io.read()
        end
        if med_name == nil or med_name:match("%S") == nil then goto name
        end

        ::uses:: do 
            print("Uses?")
            med_uses = io.read()
        end
        if med_uses == nil or med_uses:match("%S") == nil then goto uses
        end

        ::side_effect::do
            print("Side-Effects?")
            med_side_effect = io.read()
        end
        if med_side_effect == nil or med_side_effect:match("%S") == nil then goto side_effect
        end

        ::precaution:: do
            print("Precautions?")
            med_precautions = io.read()
        end
        if med_precautions == nil or med_precautions:match("%S") == nil then goto precaution
        end

        ::price:: do
            print("Price?")
            med_price = io.read()
        end
        if med_price == nil or med_price:match("%S") == nil then goto price
        end

        ::amount:: do 
            print("Amount of medicine?")
            med_amount = io.read()
        end
        if med_amount == nil or med_amount:match("%S") == nil then goto amount
        end
        
        local new_med_form = {
                ["uses"] = med_uses,
                ["precautions"] = med_precautions,
                ["side-effects"] = med_side_effect,
                ["price"] = tonumber(med_price),
                ["amount"] = tonumber(med_amount)
        }

        --- Write down new data
        med_db[category_dict[choice]][med_name] = new_med_form
        local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json", 'w')
        local data = json.encode(med_db, {indent=true})
        file:write(data)
        file:close()
        
    end
end
Add_new_product()