local lunajson = require("lunajson")
local json = require ("dkjson")

function Update(table, new_values)
  for key, value in pairs(new_values) do
    table[key] = value
  end
  return table
end

function Register()

  print('===============================')
  print('Hi this is registration form :)')
  print('===============================')

  --- Read customer data.
  local file, err = io.open("../Drug4U_Lua_ver/User_file/User_data.json", 'r')
  local data = file:read("*all")
  file:close()
  customer_db = lunajson.decode(data)

  print("What should we call you?")
  username = io.read()
  --- Check username if it's balnk or not.
  while username == nil or username:match("%S") == nil  do
    print("Can't be blank.")
    print("Your username?")
    username = io.read()
  end
  while true do
    local found = false
    for customer_username_db, y in pairs(customer_db) do
      if username == customer_username_db then
        found = true
      end
    end

    ---Check if the username has been used.
    if found == true then
      print("Sorry, this username has already been used.")
      print("What should we call you?")
      username = io.read()
    else
      break
    end
  end
  print('===============================')
  print(string.format('Hi %s Nice to meet ya :)', username))
  print('===============================')
  print("And your password?")
  password = io.read()
  while password == nil or password:match("%S") == nil do
    print("Can't be blank.")
    print("And your password?")
    password = io.read()
  end
  print("Now the address for your shipping: ")
  address = io.read()
  while address == nil or address:match("%S") == nil do
    print("Can't be blank.")
    print("Now the address for your shipping: ")
    address = io.read()
  end

  print("Your telephone number please:) ")
  tel = io.read()
  while tel == nil or tel:match("%S") == nil do
    print("Can't be blank.")
    print("Your telephone number please:) ")
    tel = io.read()
  end
  new_acc = {
      [username] = {
      ["password"] =  password,
      ["address"] = address,
      ["tel"] = tel 
    }
  }

  --- Write new data with updated old data.
  local file = io.open("../Drug4U_Lua_ver/User_file/User_data.json", 'w')
  local new_db = json.encode(Update(customer_db, new_acc), {indent = true})
  file:write(new_db)
  file:close()
end



function Login()

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

  --- Check username if it's balnk or not.
  while username == nil or username:match("%S") == nil do
    print("Can't be blank.")
    print("Your username?")
    username = io.read()
  end

 ---Check user's input username that it's in the systemm or not.
  while true do
    local found = false
    for customer_in_db, x in pairs(customer_data) do
      if customer_in_db == username then
        found = true
        break
      end
    end

    if found == true then
      print("Logged in")
      break
    else  
      print("You're username is incoorect please try again.")
      print("Your username?")
      username = io.read()
    end
  end

  --- check the given password that if it's match with the username or not.
  local match = false
  print("Your password?")
  local password = io.read()
  while customer_data[username]["password"] ~= password do
    print("Sorry, your given password does not match with the username, Please try again.")
    print("Your password?")
    password = io.read()
  return username
  end

end

function Menu()
  print('---> Please select Menu :) <---')
  print('==========================')
  local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json")
  data = file:read("*all")
  file:close()
  local med_data = lunajson.decode(data)
  local count = 1
  for menu_name, x in pairs(med_data)do
    print(string.format("%s. %s", count, menu_name))
    count = count + 1
  end
  print('==========================')
  print(string.format("%s. Setting", count))
  print(string.format("%s. Checkout", count+1))
  print(string.format("%s. Exit", count+2))

  print('==========================')
  print("Please input number:)")
  local choice = tonumber(io.read())
  print('==========================')

  local num_of_menu = {}
  for menu_num = 1, count+2 do
    table.insert(num_of_menu, menu_num)
  end
  --- Check if customer choice is correct or not.
  local found = false
  while true do      
    for num in pairs(num_of_menu)do
      if choice == num then
        found = true
        break
      end
    end
    if found ==  true then 
      return choice
    else
      print("Wrong choice :(")
      print("Please input number:)")
      choice = tonumber(io.read())
    end
  end
end
function Setting ()
  print('==============================')
  print('What would you like to change?')
  print('==============================')
  print('1.Password')
  print('2.Address')
  print('3.Telephone number')
  print('Please type in menu number :) ')
  local chose_choice = io.read()
  while chose_choice ~= '1' and chose_choice ~= '2' and 
  chose_choice ~= '3'do
    print('Wrong choice!!')
    print('Please type in menu number :) ')
    chose_choice = io.read()
  end

  

end


Setting()