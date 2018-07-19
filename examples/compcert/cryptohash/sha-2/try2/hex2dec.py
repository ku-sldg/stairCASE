# convert hex numbers to decimal numbers, delimited by semi-colons.
# mike neis
# 19 July 2018

# create output list
output = []

# grab input
with open('hex.txt') as f:
    lines = f.read()

# chunk input into a list by semi-colons
withoutSemiColons = lines.split(';')

# iterate over the list
for x in withoutSemiColons:
    
    ## translate
    y = int(x, 16);

    ## add to the end of the new list
    output.append(y);

    ## add a semi-colon to the end of the list
    output.append('; ')


# output to file
with open('output', 'w') as f:
    for a in output:
        f.write(str(a))
