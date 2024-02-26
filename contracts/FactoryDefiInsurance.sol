// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import './DefiInsurance.sol';

contract DefiInsuranceFactory {
    address[] public walletContracts;  // Array for new wallets deployed
    address[] public loanContracts;     // Array for new loans

    event WalletCreated(address indexed contractAddress);   // Event emitted for a new wallet insurance contract is deployed
    event LoanCreated(address indexed contractAddress);     // Event emitted for a new loan insurance contract is deployed


    // Function to deploy new Crypto Wallet Insurance contract
    function createWalletInsurance() public {
        address newWalletInsurance = address(new DefiInsurance());
        walletContracts.push(newWalletInsurance);
        emit WalletCreated(newWalletInsurance);
    }

    // Function to deploy new Collateral Protection contract
    function createLoanInsurance() public {
        address newLoanInsurance = address(new DefiInsurance());
        loanContracts.push(newLoanInsurance);
        emit LoanCreated(newLoanInsurance);
    }

    // Function to get deployed Crypto Wallet Insurance contracts
    function getWalletInsuranceContracts() public view returns (address[] memory) {
        return walletContracts;
    }

    // Function to get deployed Collateral Protection contracts
    function getLoanInsuranceContracts() public view returns (address[] memory) {
        return loanContracts;
    }
}
