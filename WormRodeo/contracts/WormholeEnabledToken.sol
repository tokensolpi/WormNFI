solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WormholeEnabledToken is ERC20, Ownable {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // Mint the initial supply to the contract owner
        _mint(owner(), 1000000 * (10**decimals())); // Example initial supply
    }

    // Function to burn tokens on this chain before minting on another chain via Wormhole.
    // This function would be called by the Wormhole integration logic.
    // Add access control to ensure only authorized addresses (e.g., Wormhole relayer or guardian) can call this.
    function burnTokensForWormhole(address account, uint256 amount) public onlyOwner {
        _burn(account, amount);
        // Emit an event that the Wormhole guardian network can pick up to initiate minting on the target chain.
        // emit TokensBurntForWormhole(account, amount);
    }

    // Function to mint tokens on this chain after they have been locked or burnt on another chain via Wormhole.
    // This function would be called by the Wormhole integration logic.
    // Add access control to ensure only authorized addresses (e.g., Wormhole relayer or guardian) can call this.
    function mintTokensFromWormhole(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
        // Emit an event to confirm the minting on this chain.
        // emit TokensMintedFromWormhole(account, amount);
    }

    // Function to receive indexed data (e.g., price updates from an oracle via Wormhole).
    // This function would be called by the Wormhole integration or a trusted relayer
    // after receiving a VAA containing the indexing data.
    // The contract logic would then use this data to adjust token supply or properties
    // based on the desired indexing mechanism (e.g., mint/burn based on price changes).
    // Add appropriate access control to ensure only authorized sources can provide this data.
 function receiveIndexedData(bytes memory data) public onlyOwner {
 // Implement logic to process the data and update token state/supply
 }
    // Consider adding events for Wormhole-related operations to aid monitoring and tracking.
    // event TokensBurntForWormhole(address indexed account, uint256 amount);
    // event TokensMintedFromWormhole(address indexed account, uint256 amount);

    // The standard ERC-20 functions are inherited:
    // totalSupply()
    // balanceOf(address account)
    // transfer(address recipient, uint256 amount)
    // allowance(address owner, address spender)
    // approve(address spender, uint256 amount)
    // transferFrom(address sender, address recipient, uint256 amount)
    // increaseAllowance(address spender, uint256 addedValue)
    // decreaseAllowance(address spender, uint256 subtractedValue)
}