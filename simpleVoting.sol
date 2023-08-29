// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SimpleVoting {

    struct Candidate {
        bytes32 name;
        uint numberOfVotes;
    }

    struct Voter {
        bool voted;
        uint vote;
    }

    Candidate[] public candidates;

    mapping(address => Voter) public votes;

    address chairPerson;

    constructor() public {
        chairPerson = msg.sender;

        candidates.push(Candidate({
            name: 'Kush',
            numberOfVotes: 0
        }));
        candidates.push(Candidate({
            name: 'Eashan',
            numberOfVotes: 0
        }));
    }

    function castVote(uint candidateIndex) public {
        address sender = msg.sender;
        require(!votes[sender].voted, 'Voter has already voted');
        candidates[candidateIndex].numberOfVotes += 1;
        votes[sender].voted = true;
        votes[sender].vote = candidateIndex;
    }

    function getNumberOfVotes(uint candidateIndex) public view returns(uint) {
        return candidates[candidateIndex].numberOfVotes;
    }

    function getWinner() public returns(bytes32 winner) {
        uint maxNumberOfVotes;
        uint length = candidates.length;
        for(uint i = 0; i < length; i++){
            if(candidates[i].numberOfVotes > maxNumberOfVotes){
                winner = candidates[i].name;
            }
        }
    }


}