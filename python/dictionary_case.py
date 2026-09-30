users = [
    {'id': 1,'total': 100, 'coupon': 'p20', 'name': 'Alice' },
    {'id': 2,'total': 200, 'coupon': 'p30', 'name': 'Bob' }, 
    {'id': 3,'total': 150, 'coupon': 'f10', 'name': 'Charlie' }       
]
discounts = {
    'p20': (0.2,0), 
    'p30': (0.3,0),
    'f10': (0,10),
}

for user in users:
    # user_id = user['id']
    # user_name = user['name']
    # print(f"User ID: {user_id}, User Name: {user_name}")
    
    # for discount_code, (percentage, fixed_amount) in discounts.items():
    #     print(f"Discount Code: {discount_code}, Percentage: {percentage*100}%, Fixed Amount: ${fixed_amount}")
    
    percent , fixed = discounts.get(user['coupon'], (0,0)) #its a default value if the coupon is not found in the discounts dictionary
    discount = user['total'] * percent + fixed
    print(f"User: {user['name']}, Total: ${user['total']}, Discount: ${discount:.2f}, Final Total: ${user['total'] - discount:.2f}")
    
    
    