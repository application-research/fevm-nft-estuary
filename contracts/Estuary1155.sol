// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract Estuary1155 is ERC1155 {
    uint256 public constant CAKE_LEGEND = 0;
    uint256 public constant LODGE_KING = 1;
    uint256 public constant LAWRENCE_GENERAL = 2;
    uint256 public constant GABE_BISHOP = 3;
    uint256 public constant NEEL_MASTER = 4;
    uint256 public constant AYUSH_PRINCE = 5;
    uint256 public constant COCO_PRINCESS = 6;
    uint256 public constant BEN_LINUX_GRAND_MASTER = 7;

    constructor() public ERC1155("https://gateway.estuary.tech/gw/ipfs/<CID>/{id}.json") {
        _mint(msg.sender, CAKE_LEGEND, 10**18, "");
        _mint(msg.sender, LODGE_KING, 10**27, "");
        _mint(msg.sender, LAWRENCE_GENERAL, 1, "");
        _mint(msg.sender, GABE_BISHOP, 1, "");
        _mint(msg.sender, NEEL_MASTER, 10**9, "");
        _mint(msg.sender, AYUSH_PRINCE, 10**9, "");
        _mint(msg.sender, COCO_PRINCESS, 10**9, "");
        _mint(msg.sender, BEN_LINUX_GRAND_MASTER, 10**9, "");
    }
}