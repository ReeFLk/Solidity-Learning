//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// 1️⃣ Define a Tweet Struct with author, content, timestamp, likes
// 2️⃣ Add the struct to array
// 3️⃣ Test Tweets

contract Twitter{

    struct Tweet{
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) private tweets;

    function createTweet(string memory _tweet) internal {
        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes:0
        });
        tweets[msg.sender].push(newTweet);
    }

    /**Getter Functions */
    function getTweet(Tweet memory _tweet, uint256 _i) public view returns(string memory){
        return tweets[_tweet.author][_i].content;
    }
    function getAlltweets(Tweet memory _tweet) public view returns(Tweet [] memory){
        return tweets[_tweet.author];
    }
}