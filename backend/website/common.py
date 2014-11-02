import os
import datetime
# MUST TODO: please fill in these feilds to make this work.
SECRET_IDENTIFIER = ''
SECRET_PASSWORD = ''

DB_FILE = './data/db.txt'
WIN_FILE = './data/win.txt'
NUM_MIN_CONFIRMATIONS = 0
CAP = 20
MONEY = 50000000
TIME_WINDOW = 10		# 60 minutes

def GetDTString():
	return ("%02s" % str(datetime.datetime.now().hour)) + ("%02s" % str(datetime.datetime.now().minute))

class SRInfo:
	def __init__(self, address, receiver_acct_no, receiver_routing_no, amount):
		# address that the sender sent the bitcoin to
		self.address = address  		# Handle
		# TODO: receiver information
		self.receiver_acct_no = receiver_acct_no
		self.receiver_routing_no = receiver_routing_no
		self.amount = amount

def ReadMoney():
	if os.path.exists('/tmp/money.txt'):
		return int(open('/tmp/money.txt').read())
	else:
		return MONEY

def UpdateMoney(diff):
	new_num = ReadMoney() + diff
	open('/tmp/money.txt', 'w').write(str(new_num))

# TODO
# Serialize SRInfo to one line.
def SRInfoToString(info):
	''' Format: address=string;receiver_acct_no=int;receiver_routing_no=int;amount=float
	'''
	# info.receiver_acct_no = int(info.receiver_acct_no)
	# info.receiver_routing_no = int(info.receiver_routing_no)
	# info.amount = int(info.amount)
	result = 'address=' + str(info.address) + ';receiver_acct_no=' + str(info.receiver_acct_no)
	result += ';receiver_routing_no=' + str(info.receiver_routing_no) + ';amount=' + str(info.amount)
	return result

# TODO
def SRInfoFromString(text):
	''' Format: address=string;receiver_acct_no=int;receiver_routing_no=int;amount=float
	'''
	result = SRInfo('', '0', '0', 0)
	infos = text.split(";")
	for info in infos:
		s = info.split("=")
		if s[0] == "address":
			result.address = s[1]
		elif s[0] == "receiver_acct_no":
			result.receiver_acct_no = str(s[1])
		elif s[0] == 'receiver_routing_no':
			result.receiver_routing_no = str(s[1])
		elif s[0] == 'amount':
			result.amount = int(s[1])
	return result

def AppendRecordToDB(info, db_file):
	print "Appending Info"
	os.system("echo \"" + SRInfoToString(info)  + "\" >> " + db_file)

def ParseDB(db_file):
	return [SRInfoFromString(line) for line in open(db_file).readlines()]

def WriteDB(infos, db_file):
	f = open(db_file, "w")
	for info in infos:
		f.write(SRInfoToString(info) + "\n")
	f.close()
