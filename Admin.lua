local lunajson = require("lunajson")
local json = require("dkjson")
local time = require("socket")
local system = require("os")


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
    ::add_another:: do
        print("Do you want to add anything else?")
        print("(y/n)")
        local check = io.read()
        if string.lower(check) ~= 'y' or string.lower(check) ~= 'n' then print("Wrong input!") time.sleep(1) goto add_another
        elseif string.lower(check) == 'y' then goto main
        else return
        end
    end 
end

function Modify_product()
    local category = nil
    local wtd = nil
    local category_dict = {}
    local changeTo = nil
    local product_dict = {}
    local product_name = nil
    local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json", 'r')
    local data = file:read("*all")
    local med_db = json.decode(data)
    file:close()
    ::ask_modify_category::do
        print('==================================')
        print("Which category do you want to modify? ")
        print('==================================')
        local count = 1
        for k, v in pairs(med_db) do
            print(string.format("%s. %s", count, k ))
            category_dict[tostring(count)] = k
            count = count + 1
        end
        print("Please type-in category number:)")
        category = io.read()

        --- Check input. 
        if not category_dict[category] then print("Wrong Choice!") time.sleep(1) goto ask_modify_category
        end
    end
    ::ask_wtd::do
        print('======================')
        print('What do you want to do')
        print('======================')
        print('1. Check remaining stock')
        print('2. Modify the product')
        wtd = io.read()
    end
        --- Check input.
        if wtd ~= '1' and wtd ~='2' then print("Wrong Choice!") time.sleep(1) goto ask_wtd
        end

        if wtd == '1' then
            print("=========================")
            print("Stock    Medcine Name")
            print("=========================")
            for k, v in pairs(med_db[category_dict[category]]) do
                print(string.format(" %s       %s",  v["amount"], k))
            end
            ::back:: do
                print("Type 'menu' to go back to the main menu")
                print("Type 'exit' to exit the program")
                local menu = io.read()
                if string.lower(menu) == 'menu' then goto ask_modify_category
                elseif string.lower(menu) == 'exit' then system.exit()
                else goto back
                end
            end
    
        else
            ::which_product::do
                print("=========================================================")
                print("All products from the chosen cateory are the following ;)")
                print("=========================================================")
                local count = 1
                for k, v in pairs(med_db[category_dict[category]]) do
                    print(string.format("%s. %s", count, k))
                    product_dict[tostring(count)] = k
                    count = count + 1
                end
                print("Please type-in product number")
                product_name = io.read()
                local found = nil
                for k, v in pairs(product_dict) do
                    if product_name == k then found = true break else found = false
                    end
                end
                if found == false then print("Wrong choice!") time.sleep(1) goto which_product
                end
            end
        end
            ::what_to_modify::do
                print("What do you want to modify?")
                print("uses, side-effects, precautions, price, amount")
                print("Please type in ;)")
            end
            local modify_this = io.read()
            --- Check input.
            if string.lower(modify_this) ~= 'uses' and string.lower(modify_this) ~= 'side-effects' and
            string.lower(modify_this) ~= 'precautions' and string.lower(modify_this) ~= 'price' and
            string.lower(modify_this) ~= 'amount' then print("Wrong choice!") time.sleep(1) goto what_to_modify
            end
            print("Change to?")
            changeTo = io.read()
            while changeTo == nil or changeTo:match("%S") == nil do
                print("Type something!")
                changeTo = io.read()
            end
            --- Write down new product information. 
            if string.lower(modify_this) == "amount" or string.lower(modify_this) == "price" then
                changeTo = tonumber(changeTo)
            end
            med_db[category_dict[category]][product_dict[product_name]][modify_this] = changeTo
            local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json", 'w')
            local data = json.encode(med_db, {indent=true})
            file:write(data)
            file:close()
end


Modify_product()