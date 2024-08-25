import hashlib
import time
import json
from flask import Flask, request, jsonify

class Blockchain:
    def __init__(self):
        self.chain = []
        self.pending_transactions = []
        self.node_identifier = str(time.time())
        self.create_genesis_block()

    def create_genesis_block(self):
        genesis_block = {
            'index': 1,
            'previous_hash': '0',
            'timestamp': time.time(),
            'transactions': []
        }
        self.chain.append(genesis_block)

    def get_latest_block(self):
        return self.chain[-1]

    def add_transaction(self, sender, receiver, amount):
        transaction = {
            'sender': sender,
            'receiver': receiver,
            'amount': amount
        }
        self.pending_transactions.append(transaction)

    def mine_pending_transactions(self, miner):
        if len(self.pending_transactions) < 1:
            return False

        latest_block = self.get_latest_block()
        new_block = {
            'index': latest_block['index'] + 1,
            'previous_hash': latest_block['hash'],
            'timestamp': time.time(),
            'transactions': self.pending_transactions,
            'miner': miner
        }

        self.pending_transactions = []
        self.chain.append(new_block)

        return True

    def proof_of_work(self):
        proof = 0
        while True:
            hash_output = hashlib.sha256(f'{proof}{self.chain[-1]["hash"]}'.encode()).hexdigest()
            if hash_output[:4] == '0000':
                return proof
            proof += 1

    def get_block_hash(self, block):
        block_string = json.dumps(block, sort_keys=True).encode()
        return hashlib.sha256(block_string).hexdigest()

app = Flask(__name__)

blockchain = Blockchain()

@app.route('/add_transaction', methods=['POST'])
def add_transaction():
    sender = request.json['sender']
    receiver = request.json['receiver']
    amount = request.json['amount']
    blockchain.add_transaction(sender, receiver, amount)
    return jsonify({'message': 'Transaction added'})

@app.route('/mine', methods=['POST'])
def mine():
    miner = request.json['miner']
    blockchain.mine_pending_transactions(miner)
    return jsonify({'message': 'Block mined'})

if __name__ == '__main__':
    app.run(debug=True)
