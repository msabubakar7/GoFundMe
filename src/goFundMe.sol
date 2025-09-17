// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract goFundMe {
    address public owner;
    uint256 public amount;
    address public latestFunder;
    address[] public Funders;
    mapping(address => uint256) public FundersToAmt;

    function fundMe() public payable {
        require(msg.value >= 0.2 ether, "must be >= 0.2 ether");
        amount = msg.value;
        FundersToAmt[msg.sender] += msg.value;
        Funders.push(msg.sender);
        latestFunder = msg.sender;
    }

    function withdrawToMe(uint256 _amount) public {
        require(msg.sender == owner, "Not owner");
        require(_amount <= address(this).balance, "Too much requested");
        (bool success,) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer failed");
    }

    function getFunders() public view returns (address[] memory) {
        return Funders;
    }
}