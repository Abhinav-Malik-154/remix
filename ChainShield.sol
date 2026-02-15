// ChainShield.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ChainShield {
    // Structure of a protection event
    struct Protection {
        address user;        // Who was protected
        uint256 timestamp;   // When
        uint256 healthBefore; // Risk level before
        uint256 healthAfter;  // Safety level after
        string chain;        // Which chain triggered
        uint256 panicScore;  // Panic level at time
    }
    
    // Store all protections
    Protection[] public protections;
    mapping(address => uint256[]) public userProtections;
    
    // Event that can be watched
    event GoldenAppleActivated(
        address indexed user,
        uint256 timestamp,
        uint256 healthBefore,
        uint256 panicScore
    );
    
    // Function to record a protection
    function recordProtection(
        address user,
        uint256 healthBefore,
        uint256 healthAfter,
        string memory chain,
        uint256 panicScore
    ) external {
        Protection memory newProtection = Protection(
            user,
            block.timestamp,
            healthBefore,
            healthAfter,
            chain,
            panicScore
        );
        
        protections.push(newProtection);
        userProtections[user].push(protections.length - 1);
        
        emit GoldenAppleActivated(
            user,
            block.timestamp,
            healthBefore,
            panicScore
        );
    }
    
    // Get total protections
    function getTotalProtections() external view returns (uint256) {
        return protections.length;
    }
    
    // Get user's protections
    function getUserProtections(address user) 
        external 
        view 
        returns (uint256[] memory) 
    {
        return userProtections[user];
    }
}