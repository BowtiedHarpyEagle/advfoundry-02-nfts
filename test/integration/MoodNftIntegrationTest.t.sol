// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";



contract MoodNftIntegrationTest is Test {
    MoodNft moodNft;
    string public constant HAPPY_SVG_IMAGE_URL = "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgZmlsbD0ieWVsbG93IiByPSI3OCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIzIi8CiAgPGcgY2xhc3M9ImV5ZXMiPgogICAgPGNpcmNsZSBjeD0iNjEiIGN5PSI4MiIgcj0iMTIiLz4KICAgIDxjaXJjbGUgY3g9IjEyNyIgY3k9IjgyIiByPSIxMiIvPgogIDwvZz4KICA8cGF0aCBkPSJtMTM2LjgxIDExNi41M2MuNjkgMjYuMTctNjQuMTEgNDItODEuNTItLjczIiBzdHlsZT0iZmlsbDpub25lOyBzdHJva2U6IGJsYWNrOyBzdHJva2Utd2lkdGg6IDM7Ii8+Cjwvc3ZnPg==";
    string public constant SAD_SVG_IMAGE_URL = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAyNHB4IiBoZWlnaHQ9IjEwMjRweCIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8cGF0aCBmaWxsPSIjMzMzIiBkPSJNNTEyIDY0QzI2NC42IDY0IDY0IDI2NC42IDY0IDUxMnMyMDAuNiA0NDggNDQ4IDQ0OCA0NDgtMjAwLjYgNDQ4LTQ0OFM3NTkuNCA2NCA1MTIgNjR6bTAgODIwYy0yMDUuNCAwLTM3Mi0xNjYuNi0zNzItMzcyczE2Ni42LTM3MiAzNzItMzcyIDM3MiAxNjYuNiAzNzIgMzcyLTE2Ni42IDM3Mi0zNzIgMzcyeiIvPgogIDxwYXRoIGZpbGw9IiNFNkU2RTYiIGQ9Ik01MTIgMTQwYy0yMDUuNCAwLTM3MiAxNjYuNi0zNzIgMzcyczE2Ni42IDM3MiAzNzIgMzcyIDM3Mi0xNjYuNiAzNzItMzcyLTE2Ni42LTM3Mi0zNzItMzcyek0yODggNDIxYTQ4LjAxIDQ4LjAxIDAgMCAxIDk2IDAgNDguMDEgNDguMDEgMCAwIDEtOTYgMHptMzc2IDI3MmgtNDguMWMtNC4yIDAtNy44LTMuMi04LjEtNy40QzYwNCA2MzYuMSA1NjIuNSA1OTcgNTEyIDU5N3MtOTIuMSAzOS4xLTk1LjggODguNmMtLjMgNC4yLTMuOSA3LjQtOC4xIDcuNEgzNjBhOCA4IDAgMCAxLTgtOC40YzQuNC04NC4zIDc0LjUtMTUxLjYgMTYwLTE1MS42czE1NS42IDY3LjMgMTYwIDE1MS42YTggOCAwIDAgMS04IDguNHptMjQtMjI0YTQ4LjAxIDQ4LjAxIDAgMCAxIDAtOTYgNDguMDEgNDguMDEgMCAwIDEgMCA5NnoiLz4KICA8cGF0aCBmaWxsPSIjMzMzIiBkPSJNMjg4IDQyMWE0OCA0OCAwIDEgMCA5NiAwIDQ4IDQ4IDAgMSAwLTk2IDB6bTIyNCAxMTJjLTg1LjUgMC0xNTUuNiA2Ny4zLTE2MCAxNTEuNmE4IDggMCAwIDAgOCA4LjRoNDguMWM0LjIgMCA3LjgtMy4yIDguMS03LjQgMy43LTQ5LjUgNDUuMy04OC42IDk1LjgtODguNnM5MiAzOS4xIDk1LjggODguNmMuMyA0LjIgMy45IDcuNCA4LjEgNy40SDY2NGE4IDggMCAwIDAgOC04LjRDNjY3LjYgNjAwLjMgNTk3LjUgNTMzIDUxMiA1MzN6bTEyOC0xMTJhNDggNDggMCAxIDAgOTYgMCA0OCA0OCAwIDEgMC05NiAweiIvPgo8L3N2Zz4=";
    string public constant SAD_SVG_URL ="data:application/json;base64,eyJuYW1lIjogIk1vb2ROZnQiLCAiZGVzY3JpcHRpb24iOiAiQW4gTkZUIHRoYXQgcmVmbGVjdHMgb3duZXJzIG1vb2QgIiAsICJhdHRyaWJ1dGVzIjIgOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiAiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCM2FXUjBhRDBpTVRBeU5IQjRJaUJvWldsbmFIUTlJakV3TWpSd2VDSWdkbWxsZDBKdmVEMGlNQ0F3SURFd01qUWdNVEF5TkNJZ2VHMXNibk05SW1oMGRIQTZMeTkzZDNjdWR6TXViM0puTHpJd01EQXZjM1puSWo0S0lDQThjR0YwYUNCbWFXeHNQU0lqTXpNeklpQmtQU0pOTlRFeUlEWTBRekkyTkM0MklEWTBJRFkwSURJMk5DNDJJRFkwSURVeE1uTXlNREF1TmlBME5EZ2dORFE0SURRME9DQTBORGd0TWpBd0xqWWdORFE0TFRRME9GTTNOVGt1TkNBMk5DQTFNVElnTmpSNmJUQWdPREl3WXkweU1EVXVOQ0F3TFRNM01pMHhOall1Tmkwek56SXRNemN5Y3pFMk5pNDJMVE0zTWlBek56SXRNemN5SURNM01pQXhOall1TmlBek56SWdNemN5TFRFMk5pNDJJRE0zTWkwek56SWdNemN5ZWlJdlBnb2dJRHh3WVhSb0lHWnBiR3c5SWlORk5rVTJSVFlpSUdROUlrMDFNVElnTVRRd1l5MHlNRFV1TkNBd0xUTTNNaUF4TmpZdU5pMHpOeklnTXpjeWN6RTJOaTQySURNM01pQXpOeklnTXpjeUlETTNNaTB4TmpZdU5pQXpOekl0TXpjeUxURTJOaTQyTFRNM01pMHpOekl0TXpjeWVrMHlPRGdnTkRJeFlUUTRMakF4SURRNExqQXhJREFnTUNBeElEazJJREFnTkRndU1ERWdORGd1TURFZ01DQXdJREV0T1RZZ01IcHRNemMySURJM01tZ3RORGd1TVdNdE5DNHlJREF0Tnk0NExUTXVNaTA0TGpFdE55NDBRell3TkNBMk16WXVNU0ExTmpJdU5TQTFPVGNnTlRFeUlEVTVOM010T1RJdU1TQXpPUzR4TFRrMUxqZ2dPRGd1Tm1NdExqTWdOQzR5TFRNdU9TQTNMalF0T0M0eElEY3VORWd6TmpCaE9DQTRJREFnTUNBeExUZ3RPQzQwWXpRdU5DMDROQzR6SURjMExqVXRNVFV4TGpZZ01UWXdMVEUxTVM0MmN6RTFOUzQySURZM0xqTWdNVFl3SURFMU1TNDJZVGdnT0NBd0lEQWdNUzA0SURndU5IcHRNalF0TWpJMFlUUTRMakF4SURRNExqQXhJREFnTUNBeElEQXRPVFlnTkRndU1ERWdORGd1TURFZ01DQXdJREVnTUNBNU5ub2lMejRLSUNBOGNHRjBhQ0JtYVd4c1BTSWpNek16SWlCa1BTSk5Namc0SURReU1XRTBPQ0EwT0NBd0lERWdNQ0E1TmlBd0lEUTRJRFE0SURBZ01TQXdMVGsySURCNmJUSXlOQ0F4TVRKakxUZzFMalVnTUMweE5UVXVOaUEyTnk0ekxURTJNQ0F4TlRFdU5tRTRJRGdnTUNBd0lEQWdPQ0E0TGpSb05EZ3VNV00wTGpJZ01DQTNMamd0TXk0eUlEZ3VNUzAzTGpRZ015NDNMVFE1TGpVZ05EVXVNeTA0T0M0MklEazFMamd0T0RndU5uTTVNaUF6T1M0eElEazFMamdnT0RndU5tTXVNeUEwTGpJZ015NDVJRGN1TkNBNExqRWdOeTQwU0RZMk5HRTRJRGdnTUNBd0lEQWdPQzA0TGpSRE5qWTNMallnTmpBd0xqTWdOVGszTGpVZ05UTXpJRFV4TWlBMU16TjZiVEV5T0MweE1USmhORGdnTkRnZ01DQXhJREFnT1RZZ01DQTBPQ0EwT0NBd0lERWdNQzA1TmlBd2VpSXZQZ284TDNOMlp6ND0ifQ==";
    address USER = makeAddr("user");

    function setUp() public {
        moodNft = new MoodNft(SAD_SVG_IMAGE_URL, HAPPY_SVG_IMAGE_URL);
    }

    function testViewTokenUriIntegration() public { 
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }

    function testFlipTokenToSad() public {
        vm.prank(USER);
        moodNft.mintNft();
        vm.prank(USER);
        moodNft.flipMood(0);
        console.log(moodNft.tokenURI(0));

        assertEq(keccak256(abi.encodePacked(SAD_SVG_URL)),
            keccak256(abi.encodePacked(moodNft.tokenURI(0)))
        );
    }
}