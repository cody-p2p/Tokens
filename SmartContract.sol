// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    address public creator;
    uint public goal;
    uint public endTime;
    uint public totalFunds;
    mapping(address => uint) public contributions;
    bool public goalReached;
    bool public campaignEnded;

    event FundReceived(address contributor, uint amount);
    event CampaignFinished(bool successful, uint totalAmount);

    constructor(uint _goal, uint _duration) {
        creator = msg.sender;
        goal = _goal;
        endTime = block.timestamp + _duration;
    }

    function contribute() public payable {
        require(block.timestamp < endTime, "Campaign has ended");
        require(!campaignEnded, "Campaign is closed");

        contributions[msg.sender] += msg.value;
        totalFunds += msg.value;

        emit FundReceived(msg.sender, msg.value);

        if (totalFunds >= goal) {
            goalReached = true;
        }
    }

    function finishCampaign() public {
        require(msg.sender == creator, "Only the creator can finish the campaign");
        require(block.timestamp >= endTime || goalReached, "Campaign cannot be finished yet");
        require(!campaignEnded, "Campaign is already closed");

        campaignEnded = true;

        if (goalReached) {
            payable(creator).transfer(address(this).balance);
        } else {
            // Allow refunds
        }

        emit CampaignFinished(goalReached, totalFunds);
    }

    function getRefund() public {
        require(campaignEnded && !goalReached, "Refunds are not available");
        require(contributions[msg.sender] > 0, "No contribution found");

        uint amount = contributions[msg.sender];
        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
