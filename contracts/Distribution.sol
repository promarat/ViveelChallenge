// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Distribution {
    mapping(address => uint256) public distributions;

    function distribute(string memory name, address recipient, uint256 amount) public {
        require(recipient != address(0), "TokenDistributor: invalid recipient");
        require(amount > 0, "TokenDistributor: invalid amount");
        distributions[recipient] += amount;
        emit NewDistribution(name, recipient, amount);
    }

    event NewDistribution(string name, address recipient, uint256 amount);
}