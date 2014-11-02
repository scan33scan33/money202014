from django.shortcuts import render
from django.shortcuts import render_to_response
import new_wallet_id
from common import *
import json
from django.http import HttpResponse


# Create your views here.
def index(request):
	return render_to_response('templates/index.html')

def bid_request(request):
	# TODO: populate info
	receiver_acct_no = str(request.REQUEST["receiver_acct_no"])
	receiver_routing_no = str(request.REQUEST["receiver_routing_no"])
	amount = int(request.REQUEST["amount"]) 
	info = SRInfo('', receiver_acct_no, receiver_routing_no, amount)
	address = new_wallet_id.new_wallet_id(info)
	info.address = address
	AppendRecordToDB(info, DB_FILE)	
	response_data = {}
	response_data['handle'] = address
	response_data['bid_amount'] = amount
	response_data['buy_now'] = True
	return HttpResponse(json.dumps(response_data), content_type="application/json")

def can_transfer_money(request):
	handle = str(request.REQUEST["handle"])
	result = 0
	if handle in [x.strip() for x in open(WIN_FILE).readlines()]:
		result = 1
	res = {}
	res['value'] = result
	return HttpResponse(json.dumps(res), content_type="application/json")

def get_cap(request):
	res = {'value': CAP}
	return HttpResponse(json.dumps(res), content_type='application/json')	

def get_money(request):
	res = {'value': ReadMoney()}
	return HttpResponse(json.dumps(res), content_type='application/json')	
