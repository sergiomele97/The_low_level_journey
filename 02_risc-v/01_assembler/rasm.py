#!/usr/bin/env python3
import sys
import re

# =============================================================================
# RASM - RISC-V Micro-Assembler (Zero Abstractions)
# =============================================================================

REGISTERS = { f'x{i}': i for i in range(32) }
# Alias comunes
REGISTERS.update({
    'zero': 0, 'ra': 1, 'sp': 2, 'gp': 3, 'tp': 4,
    't0': 5, 't1': 6, 't2': 7, 's0': 8, 'fp': 8, 's1': 9,
    'a0': 10, 'a1': 11, 'a2': 12, 'a3': 13, 'a4': 14, 'a5': 15, 'a6': 16, 'a7': 17,
    's2': 18, 's3': 19, 's4': 20, 's5': 21, 's6': 22, 's7': 23, 's8': 24, 's9': 25, 's10': 26, 's11': 27,
    't3': 28, 't4': 29, 't5': 30, 't6': 31
})

def encode_i_type(opcode, rd, funct3, rs1, imm):
    """Format: imm[11:0] | rs1 | funct3 | rd | opcode"""
    imm = int(imm, 0) & 0xFFF
    return (imm << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode

def encode_r_type(opcode, rd, funct3, rs1, rs2, funct7):
    """Format: funct7 | rs2 | rs1 | funct3 | rd | opcode"""
    return (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode

def encode_u_type(opcode, rd, imm):
    """Format: imm[31:12] | rd | opcode"""
    imm = int(imm, 0) & 0xFFFFF
    return (imm << 12) | (rd << 7) | opcode

def assemble_line(line):
    line = line.split('#')[0].strip() # Eliminar comentarios
    if not line: return None
    
    parts = re.split(r'[,\s( )]+', line)
    parts = [p for p in parts if p]
    instr = parts[0].lower()
    
    if instr == "addi":
        # addi rd, rs1, imm
        return encode_i_type(0x13, REGISTERS[parts[1]], 0x0, REGISTERS[parts[2]], parts[3])
    
    elif instr == "add":
        # add rd, rs1, rs2
        return encode_r_type(0x33, REGISTERS[parts[1]], 0x0, REGISTERS[parts[2]], REGISTERS[parts[3]], 0x00)
    
    elif instr == "sub":
        # sub rd, rs1, rs2
        return encode_r_type(0x33, REGISTERS[parts[1]], 0x0, REGISTERS[parts[2]], REGISTERS[parts[3]], 0x20)
    
    elif instr == "lui":
        # lui rd, imm
        return encode_u_type(0x37, REGISTERS[parts[1]], parts[2])

    raise ValueError(f"Instrucción no soportada: {instr}")

def main():
    if len(sys.argv) < 3:
        print("Uso: rasm.py <input.s> <output.bin>")
        sys.exit(1)
        
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    
    binary_data = bytearray()
    
    with open(input_file, 'r') as f:
        for line_num, line in enumerate(f, 1):
            try:
                code = assemble_line(line)
                if code is not None:
                    # RISC-V es Little Endian por defecto en QEMU
                    binary_data.extend(code.to_bytes(4, 'little'))
            except Exception as e:
                print(f"Error en línea {line_num}: {e}")
                sys.exit(1)
                
    with open(output_file, 'wb') as f:
        f.write(binary_data)
    print(f"Ensamblado con éxito: {output_file} ({len(binary_data)} bytes)")

if __name__ == "__main__":
    main()
