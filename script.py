import sys

def format_binary_sequence(binary_sequence):
    formatted_sequence = ''
    for i, bit in enumerate(binary_sequence, 1):
        formatted_sequence += bit
        if i % 4 == 0 and i % 8 != 0:
            formatted_sequence += '_'
        elif i % 8 == 0:
            formatted_sequence += '|'
    return formatted_sequence

def binary_to_decimal(binary_str):
    decimal_values = [int(binary_str[i:i+8], 2) for i in range(0, len(binary_str), 8)]
    return '|'.join(map(str, decimal_values))

# Example usage
input_binary = sys.argv[1]
result = binary_to_decimal(input_binary)
print(result)

# Example usage
#input_sequence = sys.argv[1]
#formatted_result = format_binary_sequence(input_sequence)
#print(formatted_result)
