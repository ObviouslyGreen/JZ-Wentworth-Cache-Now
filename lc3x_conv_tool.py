# The goal of this tool is to convert a lc3x asm file to a lc3b asm file.
# Instructions necessary to remove in conversion are  DIV, MULT, SUB, XOR, and OR  
# Instructions look like this (for split reference): SUB dest, R1, R2

import logging
import argparse

def clean(self, filename):
	with open(filename) as f_old, open('converted_' + filename,'w') as f_new:
		for line in f_old:
			instr_whole = line.split()
			instruction = instr_whole[0]
			regs = instr_whole[1:]
			# get only the number of the register
			dest = ((regs[0])[:-1])[1]
			R1 = ((regs[1])[:-1])[1]
			R2 = (regs[2])[1]
			# removing div
			binary_dest = '{0:03b}'.format(int(dest))
			binary_R1 = '{0:03b}'.format(int(R1))
			binary_R2 = '{0:03b}'.format(int(R2))
			if instruction == 'DIV':
				concat = (binary_dest << 11) + (binary_R1 << 8) + bin(0) + '01' + str(binary_R2)
				f_new.write('DATA 4x1'+'')

			elif instruction == 'MULT':


			elif instruction == 'SUB':


			elif instruction == 'XOR':


			elif instruction == 'OR':


			else:
				f_new.write(line)
		f_new.close()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('filename', help='Determine which asm file to use (include ".asm" on input)')
    args = parser.parse_args()
    clean(args.filename)



if __name__ == '__main__':
    main()