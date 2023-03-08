// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "./Distribution.sol";

contract MyToken is ERC20, Pausable, AccessControl, Distribution {

    bytes32 public constant PAUSE_ROLE = keccak256("PAUSE_ROLE");
    bytes32 public constant UNPAUSE_ROLE = keccak256("UNPAUSE_ROLE");
    address private teamWallet = 0x1234567890123456789012345678901234567890;
    address private CTOAddress = 0xABCDEF1234567890ABCDEF1234567890ABCDEF12;
    uint256 private communityAmount = 750000;
    uint256 private devTeamAmount = 150000;

    constructor(address multiSignWallet) ERC20("MyERC20Token", "MTK") {

        PAUSE_ROLE.add(CTOAddress);
        UNPAUSE_ROLE.add(multiSignWallet);

        distribute("Community", multiSignWallet, communityAmount * 10 ** uint(decimals()));
        distribute("DevTeam", teamWallet, devTeamAmount * 10 ** uint(decimals()));

        _mint(multiSignWallet, distributions(multiSignWallet));
        _mint(teamWallet, distributions(multiSignWallet));
    }

    function pause() public {
        require(hasRole(PAUSE_ROLE, msg.sender), "Caller is not permission for this action.");
        _pause();
    }

    function unpause() public {
        require(hasRole(UNPAUSE_ROLE, msg.sender), "Caller is not permission for this action.");
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}