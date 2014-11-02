import lib.wallet
from common import *

def new_wallet_id(info):
	AppendRecordToDB(info, DB_FILE)
	wallet = lib.wallet.Wallet(SECRET_IDENTIFIER, SECRET_PASSWORD)
	return wallet.new_address('dummy').address

# for testing only
if __name__ == '__main__':
	new_wallet_id(None)
