// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Access.sol";

library LibStore {

    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("diamond.standard.store.storage");

    struct StoreStates {
        uint counter;
    }

    function diamondStorage() internal pure returns (StoreStates storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
          ds.slot := position
        }
    }

    function setCounter(uint _inc) internal {
        StoreStates storage storeState = diamondStorage();
        storeState.counter += _inc;
    }

    function getCounter() internal view returns(uint) {
        StoreStates storage storeState = diamondStorage();
        return storeState.counter;
    }
}

contract Store is AccessControl {

    uint256 private constant NOT_ENTERED = 0;
    uint256 private constant ENTERED = 1;

    uint256 private _status;
    error ReentrancyGuardReentrantCall();

    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    function setCounter(uint _inc) external onlyRole(ADMIN_ROLE) nonReentrant {
        LibStore.setCounter(_inc);
    }

    function getCounter() external view onlyRole(ADMIN_ROLE) returns(uint) {
        return LibStore.getCounter();
    }

    function _nonReentrantBefore() private {
        if (_status == ENTERED) {
            revert ReentrancyGuardReentrantCall();
        }
        _status = ENTERED;
    }

    function _nonReentrantAfter() private {
        _status = NOT_ENTERED;
    }
}