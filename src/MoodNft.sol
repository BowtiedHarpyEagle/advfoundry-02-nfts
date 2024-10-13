// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    uint256 private s_tokenCounter;
    string private s_happySvg;
    string private s_sadSvg;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping (uint256 => Mood) s_TokenIdToMood;
    
    constructor(string memory sadSvg, string memory happySvg) ERC721("MoodNft", "MN") {
        s_tokenCounter = 0;
        s_sadSvg = sadSvg;
        s_happySvg = happySvg;
    }
        
    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_TokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal view override returns (string memory) {
        return "data:application/json;base64,";
    }
    
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if (s_TokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvg;
        }
        else {
            imageURI = s_sadSvg;
        }
        return(
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "', name(), '", "description": "An NFT that reflects owners mood " , "attributes"2 : [{"trait_type": "moodiness", "value": 100}], "image": "', imageURI,'"}'
                            )
                        )
                    )
                )
            )
        );
    }
}