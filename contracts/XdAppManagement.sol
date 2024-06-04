// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract XdAppManagement {
    struct User {
        string username;
        address userAddress;
        address[] followers;
    }

    struct Post {
        uint id;
        string title;
        string description;
        address author;
        uint timestamp;
        address[] likes;
        bool isRead;
    }

    mapping(uint => Post) private posts;
    mapping(address => User) private users;
    uint private postCounter;

    /* 
    * User Section
    */

    function userRegister(string memory _username) public {
        require(bytes(users[msg.sender].username).length == 0, "User already exist");
        // Initialize a new user with an empty array of followers (new address[](0))
        users[msg.sender] = User(_username, msg.sender, new address[](0));
    }

    function getUser(address _userAddress) public view returns (string memory, address, address[] memory) {
        // Ensure the user exists by checking that their address is not the default (address(0))
        _validateUserExists(_userAddress);
        User memory user = users[_userAddress];
        return (user.username, user.userAddress, user.followers);
    }

    function getFollowers(address _mainUserAddress) public view returns (address[] memory) {
        _validateUserExists(_mainUserAddress);
        return users[_mainUserAddress].followers;
    }

    function addFollowers(address _mainUserAddress) public {
        _validateUserExists(_mainUserAddress);
        require(msg.sender != _mainUserAddress, "You cannot follow yourself.");
        return users[_mainUserAddress].followers.push(msg.sender);
    }

    /* 
    * Posts Section
    */

    function createPost(string memory _title, string memory _description) public {
        address author = msg.sender; 
        _validateUserExists(author);
        require(bytes(_description).length <= 300, "Description exceeds maximum length of 300 characters");
        posts[postCounter] = Post(postCounter, _title, _description, author, block.timestamp, new address[](0), false);
        postCounter++;
    }

    function getUsernamePost(uint _postId) public view returns (string memory) {
        require(_postId < postCounter, "Post does not exist");
        Post memory post = posts[_postId];
        address authorAddress = post.author;
        string memory username = users[authorAddress].username;

        return username;
    }

    function isReadPost(uint _postId) public {
         _validateUserExists(msg.sender);
        require(_postId < postCounter, "Post does not exist");
        Post storage post = posts[_postId];
        post.isRead = true;
    }

    function getUnreadPosts() public view returns (Post[] memory) {
        Post[] memory result = new Post[](postCounter);
        for (uint i = 0; i < postCounter; i++) {
            if(posts[i].isRead) {
                result[i] = posts[i];
            }
        }
        return result;
    }

    function getUserPosts(address _author) public view returns (Post[] memory) {
        _validateUserExists(_author);

         // Use a dynamic array to collect posts
        Post[] memory tempPostsArray = new Post[](postCounter);
        uint count = 0;
        for (uint i = 0; i < postCounter; i++ ) {
            if(posts[i].author == _author) {
                tempPostsArray[count] = posts[i];
                count++;
            }
        }

        // Copy posts to result array of exact size
        Post[] memory postByAuthor = new Post[](count);
        for (uint i; i < count; i++) {
            postByAuthor[i] = tempPostsArray[i];
        }
        return postByAuthor;

    }

    function getPosts() public view returns (Post[] memory) {
        Post[] memory result = new Post[](postCounter);
        for (uint i = 0; i < postCounter; i++) {
            result[i] = posts[i];
        }
        return result;
    }

    function addLikes(uint _postId) public {
         _validateUserExists(msg.sender);
        require(_postId < postCounter, "Post does not exist");
        Post storage post = posts[_postId];

        // Check if the user has already liked the post
        for (uint i = 0; i < post.likes.length; i++) {
            if(post.likes[i] == msg.sender) {
                // If user has already liked, remove the like
                post.likes[i] = post.likes[post.likes.length -1];
                post.likes.pop();
                return;
            }
        }
        // If user has not liked yet, add the like
        post.likes.push(msg.sender);
    }

    /* 
    * Utils Section
    */

    function _validateUserExists(address _userAddress) private view {
        require(users[_userAddress].userAddress != address(0), "User does not exist");
    }
}
