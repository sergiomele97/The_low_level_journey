import sys

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 hex_to_bin.py <input.hex> <output.bin>")
        sys.exit(1)

    input_hex_path = sys.argv[1]
    output_bin_path = sys.argv[2]

    data = []
    with open(input_hex_path, "r") as f:
        for line in f:
            # Ignore lines starting with # or empty lines
            if line.strip().startswith("#") or not line.strip():
                continue
            
            # Split by # to ignore comments, then split by space for bytes
            parts = line.split("#")[0].strip().split()
            data.extend(parts)
    
    bytes_out = bytes([int(x, 16) for x in data])
    
    with open(output_bin_path, "wb") as f:
        f.write(bytes_out)

    print(f"Successfully converted {input_hex_path} to {output_bin_path}")

if __name__ == "__main__":
    main()
