import lib.wallet
from common import *
import sys

def cashout_to_account(info):
	print "[Not implemented] Cashing out from coinbase!"

def send_to_receiver_by_ach(info):
	print "[Not implemented] Sending money to receiver!"

if __name__ == '__main__':
	db_file = len(sys.argv) > 1 and sys.argv[1] or DB_FILE
	while True:
		unconfirmed_infos = ParseDB(db_file)
		for info in unconfirmed_infos:
			print SRInfoToString(info)
			wallet = lib.wallet.Wallet(SECRET_IDENTIFIER, SECRET_PASSWORD)
			address = wallet.get_address(info.address, NUM_MIN_CONFIRMATIONS)
			if address.balance > 0:
				# if address.balance != info.balance:
				# 	print "Amount not match when cahsing out:", address.balance, info.balance
				print "Bitcoin received:", GetDTString()
				cashout_to_account(info)
				send_to_receiver_by_ach(info)
				UpdateMoney(int(- (address.balance / (1.0 + min(address.balance, CAP)))))
				unconfirmed_infos.remove(info)
		WriteDB(unconfirmed_infos, db_file)
