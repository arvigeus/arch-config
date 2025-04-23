import lz4.block
import sys

input_file = sys.argv[1]  # First argument is the input file

with open(input_file, 'rb') as f:
    data = f.read()
    compressed = lz4.block.compress(data, store_size=False)
    
    # Write to stdout
    sys.stdout.buffer.write(b'mozLz40\0')
    sys.stdout.buffer.write(len(data).to_bytes(4, 'little'))
    sys.stdout.buffer.write(compressed)
    sys.stdout.buffer.flush()