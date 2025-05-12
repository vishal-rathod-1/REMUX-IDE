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