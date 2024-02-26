// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

// Interface for interacting with DeFi schemes
interface IDefi {
    function deposit(uint256 _amount) external;
    function withdraw(uint256 _amount) external;
    function getWalletInsuranceBalance() external view returns (uint256);
    function getLoanInsuranceBalance(address _loanAddress) external view returns (uint256);

}


contract DefiInsurance {
    address public owner;

    // Crypto Wallet Insurance
    uint256 public payoutAmount;
    mapping(address => bool) public insuredWallets; // this checks if a wallet is insured
    mapping(address => uint256) public walletPolicyStartTime; // Track the start time of the wallet policy
    
    uint256 constant public policy_period = 30 days; // Duration of the insurance policy (30 days)
    
    enum WalletPolicyType {Basic, Partial, Advanced, Customized} // Enum for the policy types of the wallets

    event WalletInsured(address indexed wallet, uint256 premium);
    event WalletClaimSubmitted(address indexed wallet, uint256 amount);

    // Collateral Protection
    uint256 public fullCoverageThreshold;
    uint256 public partialPolicyThreshold;
    mapping(address => uint256) public insuredLoans;
    enum LoanPolicyType {fullPolicy, partialPolicy, dynamicPolicy, escalatingPolicy} // Enum for different policy types

    event LoanInsured(address indexed loan, uint256 amountInsured);
    event LoanClaimProcessed(address indexed loan, uint256 amountPaid);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    // Function to get the balance related to Crypto Wallet Insurance
    function getWalletInsuranceBalance() external view returns (uint256) {
        return payoutAmount;
    }

    // Function for users to pay premium and select policy type for Crypto Wallet Insurance
    function payWalletPremium(WalletPolicyType _policy) external payable {
        require(!insuredWallets[msg.sender], "This Wallet is already insured");
        
        if (_policy == WalletPolicyType.Basic) {
            payoutAmount = msg.value;
        } 
        
        else if (_policy == WalletPolicyType.Partial) {
            payoutAmount = msg.value / 2; // For partial coverage, the user is reimbursed half of the premium
        } 
        
        else if (_policy == WalletPolicyType.Advanced) {
            payoutAmount = msg.value * 2; // A wild scenario where Advanced coverage doubles the premium
        } 
        
        else if (_policy == WalletPolicyType.Customized) {
            
            payoutAmount = msg.value * 3; //  A wild scenario where Advanced coverage doubles the premium
        }

        IDefi(msg.sender).deposit(msg.value); // Deposit premium into DeFi scheme        
        insuredWallets[msg.sender] = true;
        
        walletPolicyStartTime[msg.sender] = block.timestamp; // Record the start time of the policy
        emit WalletInsured(msg.sender, msg.value);
    }

    // Function for users to submit insurance claim for Crypto Wallet Insurance
    function submitWalletClaim() external {
        require(insuredWallets[msg.sender], "Wallet is not insured");
        require(block.timestamp < walletPolicyStartTime[msg.sender] + policy_period, "Policy has expired");
        
        IDefi(msg.sender).withdraw(payoutAmount); // Withdraw claim payout from DeFi scheme
        payable(msg.sender).transfer(payoutAmount);
        emit WalletClaimSubmitted(msg.sender, payoutAmount);
    }

    // Function to get the balance related to Collateral Protection
    function getLoanInsuranceBalance(address _loanAddress) external view returns (uint256) {
        return insuredLoans[_loanAddress];
    }

    // Function for users to pay premium and select policy type for Collateral Protection
    function payLoanPremium(address _loanAddress, uint256 _loanAmount, LoanPolicyType _policy) external payable {
        require(insuredLoans[_loanAddress] == 0, "Loan is already insured");        
        if (_policy == LoanPolicyType.fullPolicy) {
            fullCoverageThreshold = _loanAmount; // Set full coverage threshold to loan amount
        } 
        
        else if (_policy == LoanPolicyType.partialPolicy) {
            partialPolicyThreshold = _loanAmount / 2; // Set partial coverage threshold to half of the loan amount
        } 
        
        insuredLoans[_loanAddress] = _loanAmount;
        emit LoanInsured(_loanAddress, _loanAmount);
    }

    // Function for users to submit insurance claim for Collateral Protection
    function submitLoanClaim(address _loanAddress, uint256 _collateralValue) external {
        require(insuredLoans[_loanAddress] > 0, "Loan is not insured");
        uint256 amountPaid;

        if (_collateralValue < partialPolicyThreshold) {
            amountPaid = insuredLoans[_loanAddress] / 2; // Reimburse half of the loan amount for partial coverage
        } 
        
        else if (_collateralValue < fullCoverageThreshold) {
            amountPaid = insuredLoans[_loanAddress]; // Reimburse full loan amount for full coverage
        }
        
        // Transfer insurance payout to the loan holder
        payable(_loanAddress).transfer(amountPaid);
        emit LoanClaimProcessed(_loanAddress, amountPaid);
    }
}

