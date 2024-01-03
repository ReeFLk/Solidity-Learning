//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Calculator{
    int256 result;

    function add(int256 _a, int256 _b) public {
        result = _a + _b;
    }

    function subtract(int256 _a, int256 _b) public {
        result = _a - _b;
    }

    function multiply(int256 _a, int256 _b) public {
        result = _a * _b;
    }
    
    /**Getter Functions */
    function getResult() public view returns (int256){
        return result;
    }
}
