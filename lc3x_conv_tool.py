# The goal of this tool is to convert a lc3x asm file to a lc3b asm file.
# Instructions necessary to remove in conversion are  DIV, MULT, SUB, XOR, and OR  
# Instructions look like this (for split reference): SUB dest, R1, R2

import logging
import argparse
import re

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def clean(filename):
	with open(filename) as f_old:
		with open('converted_' + filename,'w') as f_new:
			for line in f_old:
				instr_whole = line.split()
				if(len(instr_whole) > 0):
					instruction = instr_whole[0]
					if(instruction == 'DIV' or instruction == 'MULT' or instruction == 'SUB' or instruction == 'XOR' or instruction == 'OR' or instruction == 'NAND'):
						regs = instr_whole[1:]
						# get only the number of the register
						dest = int((regs[0])[1])
						R1 = int((regs[1])[1])
						R2 = int((regs[2])[1])
						# shifting bits to the right position
						dest = dest << 9
						R1 = R1 << 6
						# R2 is in correct position
						logger.info(line)

						if instruction == 'DIV':
							concat = dest | R1 | 8 | R2
							f_new.write('	DATA2 4x1'+format(concat,'x')+'\n')

						if instruction == 'MULT':
							concat = dest | R1 | 16 | R2
							f_new.write('	DATA2 4x1'+format(concat,'x')+'\n')

						if instruction == 'SUB':
							concat = dest | R1 | 24 | R2
							f_new.write('	DATA2 4x1'+format(concat,'x')+'\n')

						if instruction == 'OR':
							concat = dest | R1 | 8 | R2
							f_new.write('	DATA2 4x5'+format(concat,'x')+'\n')

						if instruction == 'XOR':
							concat = dest | R1 | 16| R2
							f_new.write('	DATA2 4x5'+format(concat,'x')+'\n')

						if instruction == 'NAND':
							concat = dest | R1 | 24| R2
							f_new.write('	DATA2 4x5'+format(concat,'x')+'\n')


					else:
						f_new.write(line)
				else:
					f_new.write(line)
		f_new.close()
	f_old.close()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('filename', help='Determine which asm file to use (include ".asm" on input)')
    args = parser.parse_args()
    clean(args.filename)



if __name__ == '__main__':
    main()