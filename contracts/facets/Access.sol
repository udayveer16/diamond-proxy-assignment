// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";

library LibAccess {

    bytes32 public constant SUPER_ADMIN_ROLE = 0x00;
    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("diamond.standard.access.storage");

    struct Access {
        mapping(bytes32 => RoleData) _roles;
    }

    struct RoleData {
        mapping(address => bool) hasRole;
        bytes32 adminRole;
    }

    function diamondStorage() internal pure returns (Access storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
          ds.slot := position
        }
    }

    function checkRole(bytes32 role, address account) internal view returns(bool) {
        Access storage access = diamondStorage();
        return access._roles[role].hasRole[account];
    }

    function getRoleAdmin(bytes32 role) internal view returns(bytes32) {
        Access storage access = diamondStorage();
        return access._roles[role].adminRole;
    }

    function setAdminRole(bytes32 role, bytes32 adminRole) internal {
        Access storage access = diamondStorage();
        access._roles[role].adminRole = adminRole;
    }

    function grantRole(bytes32 role, address account) internal returns(bool){
        Access storage access = diamondStorage();
        if (!checkRole(role, account)) {
            access._roles[role].hasRole[account] = true;
            return true;
        } else {
            return false;
        }
    }

    function revokeRole(bytes32 role, address account) internal returns(bool) {
        Access storage access = diamondStorage();
        if (!checkRole(role, account)) {
            access._roles[role].hasRole[account] = false;
            return true;
        } else {
            return false;
        }
    }

}

contract AccessControl {

    bytes32 constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    modifier onlyRole(bytes32 role) {
        if (LibAccess.checkRole(LibAccess.SUPER_ADMIN_ROLE, msg.sender)) {
            _;
        }
        else {
            require(LibAccess.checkRole(role, msg.sender), "Caller not admin");
            _;
        }
    }

    function addAdmin(address newAdmin) external onlyRole(LibAccess.SUPER_ADMIN_ROLE){
        console.log("admin role granted to", newAdmin);
        LibAccess.grantRole(ADMIN_ROLE, newAdmin);
    }

    function removeAdmin(address admin) external onlyRole(LibAccess.SUPER_ADMIN_ROLE) {
        LibAccess.revokeRole(ADMIN_ROLE, admin);
    }

    function transferAdminRole(address newSuperAdmin) external onlyRole(LibAccess.SUPER_ADMIN_ROLE) {
        LibAccess.grantRole(LibAccess.SUPER_ADMIN_ROLE, newSuperAdmin);
        LibAccess.revokeRole(LibAccess.SUPER_ADMIN_ROLE, msg.sender);
    }

    function renounceAdminRole() external onlyRole(LibAccess.SUPER_ADMIN_ROLE){
        LibAccess.revokeRole(LibAccess.SUPER_ADMIN_ROLE, msg.sender);
    }

}