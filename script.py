import sys

def hex_to_decimal(hex_str):
    decimal_values = [int(hex_str[i:i+2], 16) for i in range(0, len(hex_str), 2)]
    return '|'.join(map(str, decimal_values))

input_hex = sys.argv[1]
result = hex_to_decimal(input_hex)
print(result)
