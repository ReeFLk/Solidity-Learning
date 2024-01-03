// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Test} from "lib/forge-std/src/Test.sol";
import {Twitter} from "../src/Twitter.sol";

contract TwitterTest is Test {
    Twitter twitter;

    function setUp() external {
        twitter = new Twitter();
    }
            
    function testOwner() public {
        assertEq(address(twitter.i_owner()), address(this));
    }

    function testCreateAndGetTweetHelloWorldContent() public {
        twitter.createTweet("Hello World");
        string memory tweetContent = twitter.getTweetContent(0);
        assertEq(tweetContent, "Hello World");
    }
    function testLikeTweet() public {
        twitter.createTweet("Like me!");
        twitter.likeTweet(0);
        assertEq(twitter.getTotalLikesOfAUser(address(this)), 1);
    }
    function testUnlikeTweet() public {
        twitter.createTweet("Like me!");
        twitter.likeTweet(0);
        twitter.unlikeTweet(0);
        assertEq(twitter.getTotalLikesOfAUser(address(this)), 0);
    }

    function testGetTweetBlankContent() public {
        string memory tweetContent = twitter.getTweetContent(0);
        assertEq(tweetContent, "");
    }

    function testGetAllTweetOfAUser() public {
        Twitter.Tweet[] memory tweets = twitter.getAllTweetOfAUser(
            address(this)
        );
        assertEq(tweets.length, 0);
    }


    function testGetTotalLikesOfAUser() public {
        uint256 totalLikes = twitter.getTotalLikesOfAUser(address(this));
        assertEq(totalLikes, 0);
    }
}
