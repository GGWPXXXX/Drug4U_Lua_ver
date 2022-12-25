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

  --- Check username if it's balnk or not.
  while username == "" or username == " " do
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



login()
