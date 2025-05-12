# Voting Contract

A simple decentralized voting contract built on the Ethereum blockchain using Solidity. This contract allows the admin to add or remove candidates, start and end voting, and allow users to vote for their preferred candidates during the voting period.

## Contract Overview

This contract supports the following functionalities:
- **Admin Role**: Only the admin can add or remove candidates, and start or end the voting process.
- **Candidate Management**: Candidates can be added and removed by the admin before voting begins.
- **Voting**: Registered users can vote for their preferred candidate during the voting period.
- **Events**: Events are emitted for actions like adding candidates, starting/ending voting, and when a user votes.

## Features

- **Candidate Struct**: Holds details about candidates such as ID, name, and vote count.
- **Voting Process**: The contract allows the admin to control when voting starts and ends, and tracks voter participation to prevent double voting.
- **Modifiers**: Various modifiers ensure only the admin can perform certain actions and restrict voting to when it is allowed.

## Solidity Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Voting {
    address public admin;

    struct Candidate {
        uint id;
        string name;
        uint votecount;
    }

    uint public candidadtescount;
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    bool public votingStarted;
    bool public votingEnded;

    event CandidateAdded(uint id, string name);
    event Voted(address indexed voter, uint candidateId);
    event VotingStarted();
    event VotingEnded();

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(admin == msg.sender, "Only admin can perform this action");
        _;
    }

    modifier duringVoting() {
        require(votingStarted && !votingEnded, "Voting is not active.");
        _;
    }

    function addCandidate(string memory _name) public onlyAdmin {
        require(!votingStarted, "Cannot add candidates after voting has started.");
        candidates[candidadtescount] = Candidate(candidadtescount, _name, 0);
        emit CandidateAdded(candidadtescount, _name);
        candidadtescount++;
    }

    function removeCandidate(uint _id) public onlyAdmin {
        require(!votingStarted, "Cannot remove candidates after voting has started.");
        require(_id < candidadtescount, "Candidate does not exist.");
        delete candidates[_id];
    }

    function startVoting() public onlyAdmin {
        require(!votingStarted, "Voting already started.");
        votingStarted = true;
        votingEnded = false;
        emit VotingStarted();
    }

    function endVoting() public onlyAdmin {
        require(votingStarted && !votingEnded, "Voting not active.");
        votingEnded = true;
        emit VotingEnded();
    }

    function vote(uint _candidateId) public duringVoting {
        require(!hasVoted[msg.sender], "You have already voted.");
        require(_candidateId < candidadtescount, "Invalid candidate ID.");

        candidates[_candidateId].votecount++;
        hasVoted[msg.sender] = true;

        emit Voted(msg.sender, _candidateId);
    }

    function getCandidate(uint _id) public view returns (uint, string memory, uint) {
        require(_id < candidadtescount, "Candidate does not exist.");
        Candidate memory c = candidates[_id];
        return (c.id, c.name, c.votecount);
    }
}
