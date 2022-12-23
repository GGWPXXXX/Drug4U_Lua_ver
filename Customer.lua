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
    local user_list = {}

    --- Check username if it's balnk or not.
    while username == "" or username == " " do
      print("Can't be blank.")
      print("Your username?")
      username = io.read()
    end

    for customer_in_db, y in pairs(customer_data) do
      table.insert(user_list, customer_in_db)
    end
    
    if pairs(customer_data)[username] then
      print("You're on the system.")
    else
      print("You're not on the system.")
    end

  end


login()
