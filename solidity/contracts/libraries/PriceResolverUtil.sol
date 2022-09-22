// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

library PriceResolverUtil {
    function bytesToUint(bytes memory b) internal pure returns (uint256 number) {
    for (uint256 i = 0; i < 32; i++) {
      number = number + uint256(uint8(b[i])) * (2**(8 * (32 - (i + 1))));
    }
  }

  function bytesToBytes32Arr(bytes memory b, uint256 offset)
    internal
    pure
    returns (bytes32[] memory arr)
  {
    arr = new bytes32[]((b.length - offset) / 32);

    for (uint256 i = offset; i < b.length; i++) {
      arr[(i - offset) / 32] |= bytes32(b[i] & 0xFF) >> (((i - offset) % 32) * 8);
    }
  }

  function bytesToAddress(bytes memory b, uint256 offset) internal pure returns (address account) {
    bytes32 raw;

    for (uint256 i = 0; i < 20; i++) {
      raw |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
    }

    account = address(uint160(uint256(raw >> 96)));
  }
}
