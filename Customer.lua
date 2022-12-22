local lunajson = require("lunajson")

function login()
    print('============================')
    print('Hi welcome to login page')
    print('Please type in your username and password :)')
    print('============================')
  
  
    -- Open the JSON file
    local file, err = io.open("../Drug4U_Lua_ver/User_file/User_data.json", 'r')
    if not file then
      print("Error opening file: " .. err)
      return
    end
  
    -- Read the contents of the file into a string
    local data = file:read("*all")
    file:close()
  
    -- Parse the JSON string into a Lua table
    local customer_data = lunajson.decode(data)
    if not customer_data then
      print("Error parsing JSON data: " .. err)
      return
    end

    print("Your username?")
    local username = io.read()
    while True do
        print("True")
        found = nil
        for username_in_db in pairs(customer_data) do
            if username_in_db == username then 
              found = True
            end
        end
    
        if found then
            break
        end
    
        if found == False then
            print("You're not in the system.")
            print("Your username?")
            username = io.read()
        end
    end
end

login()