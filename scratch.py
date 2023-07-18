def qnumber_to_uint28(qnumber):
    # Extract the integer and fractional parts
    integer_part = (qnumber >> 23) & 0xFF
    print(integer_part)
    fractional_part = qnumber & 0x7FFFFF
    print(fractional_part)

    # Shift the fractional part back to its original position
    normal_uint28 = (integer_part << 23) | (fractional_part >> 23)

    return normal_uint28

# Example usage
qnumber_input = 8388608  # Replace this with your Qnumber input
result = qnumber_to_uint28(qnumber_input)
print(f"Qnumber (8.23) input: 0x{qnumber_input:08X}")
print(f"Normal uint28 output: {result}")
