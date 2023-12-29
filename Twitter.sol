//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Twitter {
    error Twitter__invalidLength();
    error Twitter__onlyOwner();
    error Twitter__CannotUnlike();

    struct Tweet {
        uint256 id;
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
    
    /** 
     * * Events */

    event TweetCreated(uint256 tweetId, address tweetAuthor, string content, uint256 timestamp);
    event TweetLiked(address liker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);

    /*
     * * Modifiers
     */
    modifier tweet(string memory _tweet) {
        _;
        Tweet memory newTweet = Tweet({
            id: s_tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });
        s_tweets[msg.sender].push(newTweet);
        emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
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
    ) external onlyOwner tweet(_tweet) {
        if (
            bytes(_tweet).length > MAX_TWEET_LENGTH || bytes(_tweet).length <= 0
        ) {
            revert Twitter__invalidLength();
        }
    }

    function createTweetLonger(
        string memory _tweet
    ) external onlyOwner tweet(_tweet) {
        if (bytes(_tweet).length >= 0) {
            revert Twitter__invalidLength();
        }
    }

    function likeTweet(
        uint256 _idTweet
    ) external{
        s_tweets[msg.sender][_idTweet].likes++;
        emit TweetLiked(msg.sender, s_tweets[msg.sender][_idTweet].author, _idTweet, s_tweets[msg.sender][_idTweet].likes);
    }

    function unlinkeTweet(
        uint256 _idTweet
    ) external{
        if(s_tweets[msg.sender][_idTweet].likes <= 0){
            revert Twitter__CannotUnlike();
        }
        s_tweets[msg.sender][_idTweet].likes--;
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
    function getTotalLikes(address _owner) public view returns (uint256) {
        uint256 totalLikes;
        uint256 length = s_tweets[_owner].length;
        for(uint256 i;i<length;i++){
            totalLikes += s_tweets[_owner][i].likes;
        }
        return totalLikes;
    }
}
