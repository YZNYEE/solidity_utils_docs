pragma solidity ^0.8.0;



// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (utils/math/SafeMath.sol)

pragma solidity ^0.8.0;

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract random is Ownable {
    uint256 _seed;
    uint256 _b;
    uint256 _c;
    uint256 _m;
    uint _level;
    uint256 cur;
    event getrand(uint256);
    constructor(uint256 seed,uint level,uint b,uint c,uint m) Ownable() {
        uint256 pre;
        _level=level;
        pre=seed;
        _b=b;
        _c=c;
        _m=m;
        for(uint i=0;i<level;i++) {
            pre=uint256(keccak256(abi.encodePacked(pre)));
        }
        _seed=pre;
        cur=_seed;
    }
    function _setseed(uint256 seed) internal {
        uint256 pre=seed;
        for(uint i=0;i<_level;i++) {
            pre=uint256(keccak256(abi.encodePacked(pre)));
        }
        seed=pre;
        cur=seed;
    }
    function setseed(uint256 seed) public onlyOwner {
        _setseed(seed);
    }
    function _setlevel(uint256 level) internal {
        _level=level;
    }
    function _setparam(uint b, uint c, uint m) internal  {
        _b=b;
        _c=c;
        _m=m;
    }


    function setparam(uint b,uint c, uint m)  public onlyOwner {
        _setparam(b,c,m);
    }
    function _random() internal returns(uint256) {
        uint256 pre=cur;
        uint256 v;
        bool f;
        (f,v)=SafeMath.tryMul(cur,_b);
        if(!f) {
            cur=cur%_m;
        }
        cur=(cur*_b+_c)%_m;
        return pre;
    }
    function rand() public onlyOwner returns(uint256){
        uint256 v=_random();
        emit getrand(v);
        return v;
    }

}