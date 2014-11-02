rm -rf ../data
mkdir ../data
touch ../data/db.txt
touch ../data/win.txt
pwd
ls -l ../data
python ./bid_listener.py ../data/db.txt ../data/win.txt  &
ls -l ../data
python ./money_listener.py ../data/db.txt &
ls -l ../data
