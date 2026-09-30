# # normally 

# value = 13
# reminder = value % 2
# if reminder == 0:
#     print(f"{value} is even")
# else:
#     print(f"{value} is odd")
    
    
    
# but with wallrus 
val = 13
if (reminder := val % 2) == 0:
    print(f"{val} is even")
else:
    print(f"{val} is odd")
    
    
# example 2
available_sizes = ['S', 'M', 'L', 'XL']
if (size := input("Enter your size: ")) in available_sizes:
    print(f"{size} is available")
else:
    print(f"{size} is not available") 