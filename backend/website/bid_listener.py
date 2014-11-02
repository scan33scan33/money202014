import lib.wallet as wallet
import datetime
from common import *
import sys
import time

def WriteBid(info, output_file):
	f = open(output_file, "w")
	f.write(SRInfoToString(info) + "\n")
	f.close()


if __name__ == '__main__':
	start = datetime.datetime.now()
	while True:
		curr = datetime.datetime.now()
		time = ((curr - start).seconds)/60
		infos = ParseDB(sys.argv[1])

		if True: #time > TIME_WINDOW:
			max_amt = 0
			user_info = None
			for info in infos:
				if info.amount > max_amt:
					max_amt = info.amount
					user_info = info
			if user_info:
				WriteBid(user_info, sys.argv[2])
			#sys.exit(0)

		for info in infos:
			if info.amount > CAP:
				WriteBid(info, sys.argv[2])
				break
		#		sys.exit(0)
