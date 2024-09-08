```js

const Web3 = require('web3');
const fs = require('fs');

// Connect to an Ethereum node (replace with your own node URL if needed)
const web3 = new Web3('http://localhost:8545');

// ABI and bytecode would come from compiled contract
const contractABI = JSON.parse(fs.readFileSync('CrowdfundingABI.json', 'utf8'));
const contractBytecode = fs.readFileSync('CrowdfundingBytecode.txt', 'utf8').trim();

// Contract instance
let crowdfundingContract;

// Deploy the contract
async function deployContract(creatorAddress, goal, duration) {
    const contract = new web3.eth.Contract(contractABI);
    
    const deployTx = contract.deploy({
        data: contractBytecode,
        arguments: [web3.utils.toWei(goal.toString(), 'ether'), duration]
    });

    const gas = await deployTx.estimateGas();
    
    const deployedContract = await deployTx.send({
        from: creatorAddress,
        gas
    });

    console.log('Contract deployed at:', deployedContract.options.address);
    return deployedContract;
}

// Contribute to the campaign
async function contribute(fromAddress, amount) {
    const amountWei = web3.utils.toWei(amount.toString(), 'ether');
    
    await crowdfundingContract.methods.contribute().send({
        from: fromAddress,
        value: amountWei,
        gas: 200000
    });

    console.log(`Contributed ${amount} ETH from ${fromAddress}`);
}

// Finish the campaign
async function finishCampaign(creatorAddress) {
    await crowdfundingContract.methods.finishCampaign().send({
        from: creatorAddress,
        gas: 200000
    });

    console.log('Campaign finished');
}

// Get refund
async function getRefund(contributorAddress) {
    await crowdfundingContract.methods.getRefund().send({
        from: contributorAddress,
        gas: 200000
    });

    console.log(`Refund processed for ${contributorAddress}`);
}

// Example usage
async function main() {
    const accounts = await web3.eth.getAccounts();
    const creatorAddress = accounts[0];
    
    // Deploy contract
    crowdfundingContract = await deployContract(creatorAddress, 10, 86400); // 10 ETH goal, 1 day duration
    
    // Contribute
    await contribute(accounts[1], 2); // Contribute 2 ETH from second account
    await contribute(accounts[2], 3); // Contribute 3 ETH from third account
    
    // Finish campaign
    await finishCampaign(creatorAddress);
    
    // Try to get refund (this will only work if the goal wasn't reached)
    try {
        await getRefund(accounts[1]);
    } catch (error) {
        console.log('Refund failed:', error.message);
    }
}

main().catch(console.error);

```
