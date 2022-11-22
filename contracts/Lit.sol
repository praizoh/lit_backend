// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract Lit is Ownable  {
    // postDataCID: to store data like images etc
    event NewPostCreated(
        bytes32 postID,
        address creatorAddress,
        uint256 postCreatedAt,
        string postDataCID
    );

    // @Todo: add for comments
    struct CreatePost {
        bytes32 postId;
        string postDataCID;
        address postOwner;
        uint256 postCreatedAt; 
    }

    mapping(bytes32 => CreatePost) public idToPost;

    function CreateNewPost(
        string calldata postDataCID
    ) external {
        uint256 createdAt = block.timestamp;
        bytes32 postId = keccak256(
            abi.encodePacked(
                msg.sender,
                address(this),
                createdAt,
                postDataCID
            )
        );

        // this creates a new CreatePost struct and adds it to the idToPost mapping
        idToPost[postId] = CreatePost(
            postId,
            postDataCID,
            msg.sender,
            createdAt
        );

        emit NewPostCreated(
            postId,
            msg.sender,
            createdAt,
            postDataCID
        );
    }
}