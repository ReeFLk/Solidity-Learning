//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// 1️⃣ Create a Twitter Contract 
// 2️⃣ Create a mapping between user and tweet 
// 3️⃣ Add function to create a tweet and save it in mapping
// 4️⃣ Create a function to get Tweet 
// 5️⃣ Add array of tweets 

contract Twitter{

    mapping(address => string []) private tweets;

    function createTweet(string memory _tweet) internal {
        tweets[msg.sender].push(_tweet);
    }

    /**Getter Functions */
    function getTweet(address _owner, uint256 _i) public view returns(string memory){
        return tweets[_owner][_i];
    }
    function getAlltweets(address _owner) public view returns(string [] memory){
        return tweets[_owner];
    }
}