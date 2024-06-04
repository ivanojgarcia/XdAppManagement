# XdAppManagement

## Overview

XdAppManagement is a Solidity-based smart contract designed to manage users and their posts in a decentralized application (dApp). It includes functionality for user registration, following other users, creating posts, liking posts, and marking posts as read.

## Features

### User Management
- **Register User**: Allows a new user to register with a unique username.
- **Get User**: Retrieves user details by address.
- **Follow User**: Enables users to follow other users.
- **Get Followers**: Returns the list of followers for a user.

### Post Management
- **Create Post**: Allows users to create a post with a title and description (max 300 characters).
- **Get User Posts**: Fetches all posts by a specific user.
- **Get All Posts**: Retrieves all posts in the system.
- **Add Like**: Adds or removes a like from a post.
- **Get Username of Post Author**: Returns the username of the post author.
- **Mark Post as Read**: Marks a post as read.
- **Get Unread Posts**: Retrieves all unread posts.

## Functions

### User Section
- `userRegister(string memory _username)`
- `getUser(address _userAddress) public view returns (string memory, address, address[] memory)`
- `getFollowers(address _mainUserAddress) public view returns (address[] memory)`
- `addFollowers(address _mainUserAddress) public`

### Posts Section
- `createPost(string memory _title, string memory _description) public`
- `getUsernamePost(uint _postId) public view returns (string memory)`
- `isReadPost(uint _postId) public`
- `getUnreadPosts() public view returns (Post[] memory)`
- `getUserPosts(address _author) public view returns (Post[] memory)`
- `getPosts() public view returns (Post[] memory)`
- `addLikes(uint _postId) public`

### Utils Section
- `_validateUserExists(address _userAddress) private view`

## Usage

1. **Deploy the Contract**: Deploy the `XdAppManagement` contract on an Ethereum-compatible blockchain.
2. **Register Users**: Users can register with unique usernames.
3. **Create and Manage Posts**: Registered users can create, like, and mark posts as read.
4. **Follow Other Users**: Users can follow other users to see their posts.
5. **Retrieve Data**: Use the provided functions to retrieve posts, followers, and user details.

## Development

- **Solidity Version**: ^0.8.24
- **Dependencies**: Hardhat (for development and testing)

## License

This project is licensed under the MIT License.

## Author

- **Author Name**: Ivano J. Garcia