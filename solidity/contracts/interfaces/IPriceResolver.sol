// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import '../libraries/ERC721Enumerable.sol';

/**
  @notice A price resolver interface meant for NFT contracts to calculate price based on some parameters. Several functions are available with increasing parameter complexity. The target token contract is expected to be an implementation of ERC721Enumerable, that is also in this repo, which provides a totalSupply and balanceOf functions.
 */
interface IPriceResolver {
  /**
    @notice A pricing function meant to return some default price. Should revert if not relevant for a particular implementation.
    */
  function getPrice(ERC721Enumerable _token) external returns (uint256);

  /**
    @notice A function to calculate price based on the owner address.

    @param _token NFT contract requesting the price.
    @param _owner Address the NFT is being minted for.
    */
  function getPriceFor(ERC721Enumerable _token, address _owner) external returns (uint256);

  /**
    @notice A function to calculate price based on the token id being minted.
    */
  function getPriceOf(ERC721Enumerable _token, uint256 _tokenId) external returns (uint256);

  /**
    @notice A function to calculate price based on caller address, token id being minted and some arbitrary collection of parameters, for example Merkle tree parts.

    @dev The specific pameters being passed must agree between the NFT and price resolver implementation. The interface places no restriction on what it might be. Accompanying PriceResovlerUtil has functions to pars the parameter bytes into useful types.
    */
  function getPriceWithParams(
    ERC721Enumerable _token,
    address _owner,
    uint256 _tokenId,
    bytes calldata
  ) external returns (uint256);
}
