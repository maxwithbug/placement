# what is f'string in python?'
# In Python, an f-string (formatted string literal) is a way to embed expressions inside string literals, using curly braces `{}`. It allows you to include variables and expressions directly within a string, making it easier to format and display dynamic content.
# if you don't put this any thing in the curly braces, it will give you an error. or string


# print season with no. and start from 1 Index
seasons = ['Spring', 'Summer', 'Fall', 'Winter']
for index, season in enumerate(seasons, start=1):
    print(f"{index}. {season}")


# also can be done like this as list
list(enumerate(seasons))
# [(0, 'Spring'), (1, 'Summer'), (2, 'Fall'), (3, 'Winter')]
listseason = list(enumerate(seasons, start=1))
# so we are getting
# [(1, 'Spring'), (2, 'Summer'), (3, 'Fall'), (4, 'Winter')]

# now iterate through the listseason and print the season with index
for index, season in listseason:
    print(f"{index}. {season}")
    # what is f'string in python?'
    # In Python, an f-string (formatted string literal) is a way to embed expressions inside string literals, using curly braces `{}`. It allows you to include variables and expressions directly within a string, making it easier to format and display dynamic content.
    # if you don't put this any thing in the curly braces, it will give you an error. or string
    print("Index: {index}, Season: {season}")    #we didn't use f'string here so it will print the string as it is not the value of index and season

