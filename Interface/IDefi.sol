// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

// Interface for interacting with DeFi schemes
interface IDefi {
    function deposit(uint256 _amount) external;
    function withdraw(uint256 _amount) external;
    function getWalletInsuranceBalance() external view returns (uint256);
    function getLoanInsuranceBalance(address _loanAddress) external view returns (uint256);

}