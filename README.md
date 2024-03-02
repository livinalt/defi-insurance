## InsureDeFi - Decentralized Insurance Platform

### Overview
InsureDeFi is a decentralized insurance platform built on the Ethereum blockchain. It offers insurance policies tailored for decentralized finance (DeFi) users, protecting against various risks associated with DeFi activities. This platform aims to enhance the security and trustworthiness of DeFi protocols by mitigating the financial risks faced by users.

### Features
- **Decentralized Insurance Policies:** Users can purchase insurance policies directly on the blockchain without intermediaries.
- **Customizable Policies:** Users can choose from different policy types and customize parameters such as premium amount, coverage limit, and duration.
- **Transparency and Immutability:** All insurance policies and transactions are recorded on the Ethereum blockchain, ensuring transparency and immutability.
- **Automatic Claim Processing:** Smart contracts automatically process insurance claims based on predefined conditions, reducing manual intervention.
- **Error Handling:** Smart contracts include robust error handling mechanisms to ensure the integrity and security of the insurance platform.

### Contracts
- **InsureDefiWallet.sol:** Manages insurance policies for DeFi wallets.
- **InsureDefiPolicy.sol:** Manages insurance policies for DeFi loans.
- **InsuranceFactory.sol:** Acts as a factory contract for deploying instances of InsureDefiWallet and InsureDefiPolicy contracts.

### Usage
1. **Deploy Contracts:** Deploy the InsureDefiWallet, InsureDefiPolicy, and InsuranceFactory contracts to the Ethereum blockchain.
   ```bash
   npx hardhat run scripts/deploy.ts --network <network_name>
   ```
2. **Interact with InsuranceFactory:** Use the functions provided by InsuranceFactory to create new instances of insurance contracts.
   ```typescript
   // Example of deploying a new InsureDefiWallet contract
   await insuranceFactory.deployWallet();
   ```
3. **Purchase Insurance:** Users can purchase insurance policies by calling the ```buyInsurance``` function on the respective contract.
   ```typescript
   // Example of buying insurance for a DeFi wallet
   await insureDefiWallet.connect(wallet).buyInsurance(policyType, {value: premiumAmount});
   ```
4. **Claim Insurance:** In case of a claim, users can call the ``claimInsurance()`` function to receive compensation.
   ```typescript
   // Example of claiming insurance for a DeFi wallet
   await insureDefiWallet.connect(wallet).claimInsurance();
   ```

### Installation
- Clone the project repository from GitHub:
   ```bash
   git clone https://github.com/livinalt/defi-insurance.git
   ```
- Install dependencies:
   ```bash
   npm install
   ```

### Contributors
- **Jeremiah Samuel** - Smart contract development
  - Email: livinalt@gmail.com

### License
This project is licensed under the MIT License. 
