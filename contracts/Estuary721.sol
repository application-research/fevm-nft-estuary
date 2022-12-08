// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC2981ContractWideRoyalties.sol";

contract Estuary721 is ERC721URIStorage, ERC721Enumerable, ERC2981ContractWideRoyalties, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    string private _name;
    string private _symbol;
    uint256 public _maxSupply = 1000000;
    uint256 private _totalSupply;
    
    uint256 public _publicSalePrice = 1 ether; // pay me 1 for every mint!
    uint256 royalty = 300;


    bool public testMode = false;
    bool public paused = false;
    bool public revealed = false;

    //  Dev Team - Fee here for every mint!
    address public devTeam = 0x82C0b66C79dbF90E1cA0A6571C07b2a7cc78219F;

    //  Use Estuary Gateway to pin the metadata to IPFS (directory CID)
    string public baseURI = "https://gateway.estuary.tech/ipfs/QmeRHqU4a68coNKLnnaQU9D9ogky1v9V3bN1ni9ysutaz9/"; // hack!

    mapping(address => uint256[]) public userOwnedTokensPublic;

    constructor(string memory name_ , string memory symbol_, uint256 royalty_) ERC721(name_, symbol_) {
        _name = name_;
        _symbol = symbol_;
        _setRoyalties(devTeam, royalty_);

    }


    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    //  Public Mint
    function mint(uint256 qty) public payable virtual {

        require(!paused);
        require(msg.value >= 0, "Not enough Token sent; check price!");
        require(_tokenIdCounter.current() < _maxSupply);

        uint256 requiredAmount = qty * _publicSalePrice;
        require(msg.value >= requiredAmount, "Not enough tFIL sent; check price!");

        //  Mint IT!!!
        for (uint256 i = 1; i <= qty; i++) {
            _tokenIdCounter.increment();
            uint256 tokenId = _tokenIdCounter.current();
            userOwnedTokensPublic[msg.sender].push(tokenId);
            _mint(msg.sender, tokenId);
        }
        
    }

    //  SafeMint for Dev Team
    function safeMint(address to) public onlyOwner {
        require(_tokenIdCounter.current() < _maxSupply);

        // increment
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId + 1);
    }

    //  Set the TOKEN URI
    function tokenURI(uint256 tokenId) public view override(ERC721,ERC721URIStorage) returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI_ = _baseURI();

        if (revealed) {
            return bytes(baseURI_).length > 0 ? string(abi.encodePacked(baseURI_, Strings.toString(tokenId), ".json")) : "";
        } else {
            return string(abi.encodePacked(baseURI_, "hidden.json"));
        }
    }

    //  Withdraw tFil
    function withdraw() payable public onlyOwner {
        payable(devTeam).transfer(address(this).balance);
    }

    //  Configuration changes
    function changeBaseURI(string memory baseURI_) public onlyOwner {
        baseURI = baseURI_;
    }


    function changePublicSalePrice(uint256 publicSalePrice_) public onlyOwner {
        _publicSalePrice = publicSalePrice_;
    }

    function changeRoyalty(uint256 royalty_) public onlyOwner {
        royalty = royalty_;
        _setRoyalties(devTeam,royalty_);
    }

    function changeDevTeam(address devTeam_) public onlyOwner {
        devTeam = devTeam_;
    }

    function changeRevealed(bool _revealed) public onlyOwner {
        revealed = _revealed;
    }

    function pause(bool _state) public onlyOwner {
        paused = _state;
    }

    function setToTestMode(bool _testMode) public onlyOwner {
        testMode = _testMode;
    }

    function getNumberOfTokens(address _user) public view returns(uint256) {
        return (userOwnedTokensPublic[_user].length);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, ERC721Enumerable, ERC2981Base)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal override (ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }
    
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    /// @notice Allows to set the royalties on the contract
    /// @dev This function in a real contract should be protected with a onlyOwner (or equivalent) modifier
    /// @param recipient the royalties recipient
    /// @param value royalties value (between 0 and 10000)
    function setRoyalties(address recipient, uint256 value) public onlyOwner {
        _setRoyalties(recipient, value);
    }

}