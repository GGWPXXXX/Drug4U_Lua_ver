local lunajson = require("lunajson")
local json = require ("dkjson")
local time = require("socket")

function Update(table, new_values)
  for key, value in pairs(new_values) do
    table[key] = value
  end
  return table
end

function Register()
  local username = nil
  local customer_db = nil
  local password = nil
  local address = nil
  local tel = nil
  local new_acc = nil
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
  end
  for num = 5, 1, -1 do
    print(string.format("We'll take you back in main menu in %s"), num)
    time.sleep(1)
  end
  return username
end

function Menu()
  
  print('---> Please select Menu :) <---')
  print('==========================')
  local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json", "r")
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
  print(string.format("%s. Manage Cart", count +1))
  print(string.format("%s. Checkout", count+2))
  print(string.format("%s. Exit", count+3))

  print('==========================')
  print("Please input number:)")
  local choice = tonumber(io.read())
  print('==========================')

  local num_of_menu = {}
  for menu_num = 1, count+3 do
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

function Manage_cart(user_name)
  local file = io.open("../Drug4U_Lua_ver/User_file/Cart.json", 'r')
  local data = file:read("*all")
  file:close()
  local cart_db = lunajson.decode(data)
  local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json", 'r')
  local data = file:read("*all")
  local med_db = lunajson.decode(data)
  file:close()
  
  --- If customer didn't have anything in cart database then.
  if not cart_db[user_name] then
    print("======================================================")
    print("There's nothing to be Manage cause your cart is empty!")
    print("======================================================")
    for count = 5, 1, -1 do
      print(string.format("We'll take you back in main menu in %s", count))
      time.sleep(1)
    end
    return

  else
    local name_med_dict = {}
    local count = 1
    for k, v in pairs(cart_db[user_name]) do
      print(count, v[1], v[2], v[3])
      name_med_dict[tostring(count)] = v[1]
      count = count + 1
    end
    ::ask_menu::
    print('=====================================')
    print("Which order do you want to customize?")
    print('=====================================')
    local choice = io.read()
    local found = nil
    
    --- Check that customer input is correct or not.
    for num in pairs(cart_db[user_name])do
      if tonumber(choice) == tonumber(num) then found = true break else found = false
      end
    end
    if found == false then print("Wrong choice!") goto ask_menu
    end
    ::main::
    print("=======================")
    print("What do you want to do?")
    print("=======================")
    print("1.Delete this order?")
    print("2.Change the quantity you purchase?")
    print("=======================")
    print("Please type in menu number :)")
    local to_do = io.read()
    if to_do ~= '1' and to_do ~= '2' then print("Wrong choice!") time.sleep(1) goto main
    end
    if to_do == '1' then goto delete_items
    elseif to_do == '2' then goto change_quantity
    end
    ::delete_items:: do
      cart_db[user_name][choice] = nil
      local file = io.open("../Drug4U_Lua_ver/User_file/Cart.json", 'w')
      local data = json.encode(cart_db, {indent=true})
      file:write(data)
      file:close()
      print("Deleted successfully!")
    end
    ::change_quantity::do
      print("Change it to?")
      local change_qn_to = io.read()
      if tonumber(change_qn_to) < 0 then print("Can't less then zero!") goto change_quantity
      elseif tonumber(change_qn_to) == cart_db[user_name][tostring(choice)][2] then
        print("Can't change to equal to the original quantity!") 
        goto change_quantity
      end
      for k, v_table in pairs(med_db) do 
        for name, info in pairs(v_table)do
          if name == name_med_dict[tostring(choice)] then
            if tonumber(change_qn_to) > info["amount"] then print("Unfortunately, the quantity of this medication is insufficient.") goto change_quantity
            end
          end
        end
      end
      cart_db[user_name][tostring(choice)][2] = tonumber(change_qn_to)
      local file = io.open("../Drug4U_Lua_ver/User_file/Cart.json", 'w')
      local data = json.encode(cart_db, {indent=true})
      file:write(data)
      file:close()
      print("Changed successfully.")
      
    end
  end
end
function Setting (user_name)
  ::main:: do
    local menu = {
      ["1"] =  "Password",
      ["2"] = "Address", 
      ["3"] = "Telephone number"
      }

    print('==============================')
    print('What would you like to change?')
    print('==============================')
    for num, menu_name in pairs(menu) do
      print(string.format("--- %s", menu[num]))
    end
    print('Please type in menu name :) ')
    local chose_choice = io.read()
    local found = false
    while true do
      for menu_num, menu_name in pairs(menu) do
        if string.lower(chose_choice) == string.lower(menu_name) then
          found = true
          break
        end
      end
      if found == false then 
        print('Wrong choice!!')
        print('Please type in menu name :( ')
        chose_choice = io.read()
      else
        break
      end
    end

    if string.lower(chose_choice) == "password" then goto password
    elseif string.lower(chose_choice) == "address" then goto address
    elseif string.lower(chose_choice) == "telephone number"  then goto telephone_number
    end

    ::password:: do
      print("--- Password ---")
      print("Change it to?")
      local new_password = io.read()
      while new_password == nil or new_password:match("%S") == nil do
        print("Can't be blank !")
        print("Change it to?")
        new_password = io.read()
      end
      local file = io.open("../Drug4U_Lua_ver/User_file/User_data.json", "r")
      local data = file:read("*all")
      file:close()
      local old_data = lunajson.decode(data)
      local new_form = {
        [user_name] = {
          ["address"] = old_data[user_name]["address"],
          ["tel"] = old_data[user_name]["tel"],
          ["password"] = new_password
        }
      }
      local write_file = io.open("../Drug4U_Lua_ver/User_file/User_data.json", "w")
      local new_data = json.encode(Update(old_data, new_form), {indent = true})
      write_file:write(new_data)
      write_file:close()
      goto ask
    end

    ::address:: do
      print("--- Address ---")
      print("Change it to?")
      local new_address = io.read()
      while new_address == nil or new_address:match("%S") == nil do
        print("Can't be blank !")
        print("Change it to?")
        new_address = io.read()
      end
      local file = io.open("../Drug4U_Lua_ver/User_file/User_data.json", "r")
      local data = file:read("*all")
      file:close()
      local old_data = lunajson.decode(data)
      local new_form = {
        [user_name] = {
          ["address"] = new_address,
          ["tel"] = old_data[user_name]["tel"],
          ["password"] = old_data[user_name]["password"]
        }
      }
      local write_file = io.open("../Drug4U_Lua_ver/User_file/User_data.json", "w")
      local new_data = json.encode(Update(old_data, new_form), {indent = true})
      write_file:write(new_data)
      write_file:close()
      goto ask
    end

  ::telephone_number:: do
    print("--- Telephone Number ---")
    print("Change it to?")
    local new_tel = io.read()
    while new_tel == nil or new_tel:match("%S") == nil do
      print("Can't be blank !")
      print("Change it to?")
      new_tel = io.read()
    end
    local file = io.open("../Drug4U_Lua_ver/User_file/User_data.json", "r")
    local data = file:read("*all")
    file:close()
    local old_data = lunajson.decode(data)
    local new_form = {
      [user_name] = {
        ["address"] = old_data[user_name]["address"],
        ["tel"] = new_tel,
        ["password"] = old_data[user_name]["password"]
      }
    }
    local write_file = io.open("../Drug4U_Lua_ver/User_file/User_data.json", "w")
    local new_data = json.encode(Update(old_data, new_form), {indent = true})
    write_file:write(new_data)
    write_file:close()
    goto ask
  end
end
::ask:: do
  print("Do you want to change anything else?")
  print("Type (y/n)")
  local more = io.read()

  while string.lower(more) ~= 'y' and
  string.lower(more) ~= 'n' do
    print("Wrong choice!!")
    print("Type (y/n)")
    more = io.read()
  end
  
  
  if string.lower(more) == "y" then
    goto main
  end
  
end
end
function Add_to_cart (user_name, med_name, med_amount, price)
  local file = io.open("../Drug4U_Lua_ver/User_file/Cart.json", 'r')
  local data = file:read("*all")
  file:close()
  local cart_data = lunajson.decode(data)
  local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json", 'r')
  local data = file:read("*all")
  local med_db = lunajson.decode(data)
  file:close()

  if not cart_data[user_name] then
    -- Add new user and new order to cart data
    cart_data[user_name] = {
        ["1"] = {med_name, med_amount, price}
    }
  else
    -- Find highest order number for existing user
    local highest_order_num = 0
    for order_num, _ in pairs(cart_data[user_name]) do
      highest_order_num = math.max(highest_order_num, tonumber(order_num))
    end
    -- Add new order to cart data
    local new_order_num = highest_order_num + 1
    cart_data[user_name][new_order_num] = {med_name, med_amount, price}
  end

  -- Write updated cart data to JSON file
  local cart_data_for_write = io.open("../Drug4U_Lua_ver/User_file/Cart.json", 'w')
  local new_data = json.encode(cart_data, {indent = true})
  cart_data_for_write:write(new_data)
  cart_data_for_write:close()
  print(string.format("%s was added to your cart :)", med_name))

  -- Delete amount of medecine that customer buy in stock.
  for cate, med_table in pairs(med_db) do
    for name, info in pairs(med_table)do
      if name == med_name then med_db[cate][name]["amount"] = med_db[cate][name]["amount"] - med_amount
      end
    end
  end
  -- Write down new data.
  local file = io.open("../Drug4U_Lua_ver/Medicine/Medicine_Data.json", 'w')
  local data = json.encode(med_db, {indent=true})
  file:write(data)
  file:close()
end

function Check_out(user_name)
  -- Open all necessary files
  local file = io.open("../Drug4U_Lua_ver/Admin_file/Orders.json", 'r')
  local data = file:read("*all")
  local order_data = lunajson.decode(data)
  file:close()
  local file = io.open("../Drug4U_Lua_ver/User_file/Cart.json", 'r')
  local data = file:read("*all")
  local cart_data = lunajson.decode(data)
  file:close()
  local file = io.open("../Drug4U_Lua_ver/User_file/User_data.json", 'r')
  data = file:read("*all")
  file:close()
  local customer_data = lunajson.decode(data)
  
  -- If there's nothing in the user's cart, print a message and return
  if not cart_data[user_name] then
    print("===============================")
    print("There's nothing in your cart :)")
    print("===============================")
    return
  end
  
  -- If this is the user's first order, create a new entry in the orders data
  if not order_data[user_name] then
    order_list = {}
    customer_info = {}
    --- Add customer's order into list.
    for num, med_list in pairs(cart_data[user_name]) do
      table.insert(order_list, {med_list[1], med_list[2], med_list[3]})
    end
    --- Add customer's infomation ie.address, telephone_number into list.
    for key, info in pairs(customer_data[user_name]) do
      table.insert(customer_info, info)
    end
    order_data[user_name] = {
      ["0"] = customer_info,
      ["1"] = order_list
    }
  else
    -- If the user has placed previous orders, find the highest order number and create a new order with the next highest number
    local highest_order_num = 0
    order_list = {}
    for num, med_list in pairs(cart_data[user_name]) do
      table.insert(order_list, {med_list[1], med_list[2], med_list[3]})
    end
    for order_num, _ in pairs(order_data[user_name]) do
      highest_order_num = math.max(highest_order_num, tonumber(order_num))
    end
    local new_order_num = highest_order_num + 1
    --- Convert highest number into string.
    new_order_num = tostring(new_order_num)
    order_data[user_name][new_order_num] = order_list
  end
  
  -- Write the updated orders data to the orders file.
  local orders_data_for_write = io.open("../Drug4U_Lua_ver/Admin_file/Orders.json", 'w')
  local new_data = json.encode(order_data, {indent = true})
  orders_data_for_write:write(new_data)
  orders_data_for_write:close()
  
  local total_price = 0
  print('=================================')
  print("You're order(s) are the following :)")
  print('=================================')
  for count, items in pairs(order_list) do
    print(string.format("%s. %s x %s  %s x %s = %s Baht.", count, items[1], items[2]
    , items[2], items[3], items[2] * items[3]))
    total_price = total_price + (items[2] * items[3])
  end
  print('=================================')
  print(string.format("Your total is %s Baht.", total_price ))
  ---  Delete order that ordered from the cart database.
  cart_data[user_name] = nil
  --- Write down new data
  local file = io.open("../Drug4U_Lua_ver/User_file/Cart.json", 'w')
  local write_file = json.encode(cart_data, {indent=true})
  file:write(write_file)
  file:close()
end
