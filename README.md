# Voting Contract

This is a decentralized voting contract built on the Ethereum blockchain using Solidity. It allows users to participate in a voting process by casting votes for candidates that the admin manages. The contract enables an admin to add or remove candidates, start and end the voting process, and tracks voting activity such as vote counts and whether users have voted.

## Purpose

The purpose of this voting contract is to provide a simple mechanism for managing candidates and votes in a transparent, secure, and decentralized way. It allows the admin to control the election process, while voters can participate in a fair and immutable system where their votes are recorded on the blockchain.

## Features

- **Admin Role**: The contract defines an admin role, which is the only address allowed to manage candidates and control the voting process.
- **Candidate Management**: The admin can add and remove candidates before the voting period starts. This ensures that only legitimate candidates can participate.
- **Voting Process**: Once the voting starts, users can cast their vote for any of the candidates. Only one vote per address is allowed.
- **Voting Period**: The admin controls when the voting begins and ends, preventing any votes after the end of the period.
- **Transparency**: The contract keeps track of the number of votes each candidate has received, and it provides public access to candidate information.
- **Security**: To prevent double voting, the contract ensures that each address can only vote once during the voting period.

## Core Concepts

### Admin Role

The admin is the address that deploys the contract and has special privileges to manage the voting process. The admin is responsible for:
- Adding candidates.
- Removing candidates.
- Starting and ending the voting process.

### Candidate Management

Candidates are individuals or entities that are eligible for votes. The admin can:
- Add candidates before the voting starts.
- Remove candidates before voting begins, ensuring the list remains accurate and up-to-date.

### Voting Process

Voting is only allowed during the active voting period:
- Users can cast one vote for their preferred candidate.
- The contract ensures that users cannot vote more than once, preventing fraudulent voting.
- Once voting ends, the contract locks voting and prevents further changes.

### Modifiers

- **onlyAdmin**: This modifier ensures that only the admin can perform certain actions, like adding or removing candidates, and starting or ending voting.
- **duringVoting**: This modifier restricts actions to only occur when voting is active, preventing voting operations outside the allowed period.

### Events

The contract emits various events to keep track of important actions:
- **CandidateAdded**: Emitted when a new candidate is added by the admin.
- **Voted**: Emitted when a user votes for a candidate, logging the voter’s address and the chosen candidate ID.
- **VotingStarted**: Emitted when the voting process begins, signaling that users can now vote.
- **VotingEnded**: Emitted when the voting process ends, indicating no further votes can be cast.

## Functions

### 1. **addCandidate**

This function allows the admin to add a candidate to the list of candidates eligible for voting. It takes the candidate's name as an argument and ensures that no candidates can be added after voting has started.

**Usage**: `addCandidate(string memory _name)`

- **Modifier**: `onlyAdmin`
- **Conditions**: Cannot be executed after voting has started.

### 2. **removeCandidate**

This function allows the admin to remove a candidate from the list of candidates. It ensures that candidates cannot be removed once voting has started.

**Usage**: `removeCandidate(uint _id)`

- **Modifier**: `onlyAdmin`
- **Conditions**: Cannot be executed after voting has started.

### 3. **startVoting**

This function allows the admin to start the voting process. It ensures that voting cannot be started multiple times and that no votes can be cast before this point.

**Usage**: `startVoting()`

- **Modifier**: `onlyAdmin`
- **Conditions**: Voting cannot be started if it’s already active.

### 4. **endVoting**

This function allows the admin to end the voting process, making it impossible for any further votes to be cast after the end.

**Usage**: `endVoting()`

- **Modifier**: `onlyAdmin`
- **Conditions**: Voting must be active and not already ended.

### 5. **vote**

This function allows a registered user to cast their vote for a candidate during the active voting period. Each address can vote only once.

**Usage**: `vote(uint _candidateId)`

- **Modifier**: `duringVoting`
- **Conditions**: The caller must not have voted before, and the candidate ID must be valid.

### 6. **getCandidate**

This function allows anyone to view the details of a candidate, including the candidate's ID, name, and the number of votes they have received.

**Usage**: `getCandidate(uint _id)`

- **Conditions**: The candidate must exist in the system (i.e., the ID is valid).

## Events

- **CandidateAdded(uint id, string name)**: Emitted when a candidate is added.
- **Voted(address indexed voter, uint candidateId)**: Emitted when a user casts a vote.
- **VotingStarted()**: Emitted when voting begins.
- **VotingEnded()**: Emitted when voting ends.

## State Variables

- **admin**: The address of the admin who deploys the contract and controls it.
- **candidates**: A mapping that stores candidate data, indexed by candidate ID.
- **candidadtescount**: The number of candidates currently registered.
- **hasVoted**: A mapping to track whether an address has voted.
- **votingStarted**: A boolean flag to track if voting has started.
- **votingEnded**: A boolean flag to track if voting has ended.

## Requirements

- **Solidity version**: `^0.8.4`
- **Blockchain Platform**: Ethereum (or compatible blockchain)

## Usage Flow

1. **Deploy the contract**: The contract is deployed by the admin, who becomes the contract owner.
2. **Add Candidates**: Before the voting period begins, the admin can add eligible candidates to the voting list.
3. **Start Voting**: The admin starts the voting process, making it available for users to cast their votes.
4. **Vote**: During the active voting period, users can vote for one candidate.
5. **End Voting**: The admin ends the voting process, finalizing the results.
6. **View Results**: Anyone can query the contract to see the vote counts for each candidate.

## License

This contract is licensed under the MIT License, which allows modification, distribution, and private use.
