// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    uint256 private s_tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping (uint256 => Mood) s_TokenIdToMood;
    
    constructor() ERC721("MoodNft", "MN") {
        string memory sadSvgImageUri;
        string memory happySvgImageUri;

        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }
        
    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }
    
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory tokenMetaData = stringconcat('{"name": "' name(), '", "description": "An NFT that reflects owners mood " , "attributes"2 : [{"trait_type": "moodiness", "value": 100}], "image": "', imageURI,'"}'); 
    }
}