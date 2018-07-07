pragma solidity ^0.4.24;

import "./lib/Ownable.sol";

contract PermissionedNodes is Ownable {

  //enode addresses
  mapping(bytes => bool) permissionedNodes;

  uint count;

  event NodeAdded(string indexed nodeName);
  event NodeDeleted(string indexed nodeName);
  

  function exists (bytes name) public view returns (bool) {
    return permissionedNodes[name];
  }

 
  function addNode (bytes name) onlyOwner public {
    require(!exists(name));
    permissionedNodes[name] = true;
    count++;
    emit NodeAdded(name);
  }

  function deleteNode (bytes name) onlyOwner public {
    require(exists(name));
    permissionedNodes[name] = false;
    emit NodeDeleted(name);
  }

}
