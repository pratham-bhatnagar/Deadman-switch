// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract deadman {
    address payable public owner;
    address payable public nominee;
    uint256 public lastCallBlock;

    constructor(address payable _nominee) {
        owner = payable(msg.sender);
        nominee = _nominee;
        lastCallBlock = block.number;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner can access this function");
        _;
    }

    function stillAlive() public onlyOwner{
        lastCallBlock = block.number;
    }

    function executeSwitch() public{
        require(block.number > lastCallBlock + 10,"Owner is not Dead yet.");
        nominee.transfer(address(this).balance);
    }

    function withdraw() public onlyOwner{
        owner.transfer(address(this).balance);
    }
    

    receive() external payable {
        stillAlive();
    }

    fallback() external payable {
        stillAlive();
    }
}
