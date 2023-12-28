//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Twitter {
    error Twitter__invalidLength();
    error Twitter__onlyOwner();

    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }
    /** 
     * * Variables */
    
    uint16 constant MAX_TWEET_LENGTH = 280;
    address immutable s_owner;

    mapping(address => Tweet[]) private s_tweets;

    modifier tweet(string memory _tweet) {
        _;
        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });
        s_tweets[msg.sender].push(newTweet);
    }
    modifier onlyOwner() {
        if (msg.sender != s_owner) {
            revert Twitter__onlyOwner();
        }
        _;
    }

    /*
     * * Functions
     */

    constructor() {
        s_owner = msg.sender;
    }

    function createTweet(
        string memory _tweet
    ) internal onlyOwner tweet(_tweet) {
        if (
            bytes(_tweet).length > MAX_TWEET_LENGTH || bytes(_tweet).length <= 0
        ) {
            revert Twitter__invalidLength();
        }
    }

    function createTweetLonger(
        string memory _tweet,
        uint256 _maxLength
    ) internal onlyOwner tweet(_tweet) {
        if (bytes(_tweet).length > _maxLength || bytes(_tweet).length >= 0) {
            revert Twitter__invalidLength();
        }
    }

    /**Getter Functions */
    function getTweet(
        uint256 _i
    ) public view returns (string memory) {
        return s_tweets[msg.sender][_i].content;
    }

    function getAlltweets(address _owner) public view returns (Tweet[] memory) {
        return s_tweets[_owner];
    }
}
