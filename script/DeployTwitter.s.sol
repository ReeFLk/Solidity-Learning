// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";
import {Twitter} from "../src/Twitter.sol";

contract DeployTwitter is Script {
    function run() external {
        vm.startBroadcast();
        // Twitter twitter = new Twitter();
        vm.stopBroadcast();
    }
}