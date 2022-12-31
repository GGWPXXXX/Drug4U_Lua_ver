
print("===========================")
print("Welcome to My DRUG4U Shop!")
print("===========================")
print('Are you a customer?')

---Check that user is a customer or admin
print("(y/n): ")
local check_wheter_customer = io.read()

---Check customer's input
while check_wheter_customer:lower() ~= 'y' and check_wheter_customer:lower() ~= 'n' do
    print('Please type (y/n)')
    check_wheter_customer = io.read()
end

