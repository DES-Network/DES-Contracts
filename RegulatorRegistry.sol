pragma solidity ^0.4.24;

import "./lib/Ownable.sol";


/**
 * @title RegulatorRegistry
 * @dev The RegulatorRegistry contract is Ownable and allows addition, 
 * and removal of regulator addresses in the DES network.
 */
contract RegulatorRegistry is Ownable {

  // regulator public key
  mapping(string => bool) regulators;

  // number of regulators registered
  uint count;

  event RegulatorRegistered(string indexed _address);
  event RegulatorRemoved(string indexed _address);
  

  /**
   * @dev Allows anyone to check if the given public key belongs to a 
   * registered regulator
   * @param _address The public key to check for regulator privileges
   */
  function exists (string _address) public view returns (bool) {
    return regulators[_address];
  }


  /**
   * @dev Allows only the owner to add the given public key as a  
   * regulator
   * @param _address The address to register
   */ 
  function register (string _address) onlyOwner public {
    require(!exists(_address));
    regulators[_address] = true;
    count++;
    emit RegulatorRegistered(_address);
  }

  /**
   * @dev Allows only the owner to remove the given public key from 
   * the regulator registry
   * @param _address The address to remove from registry
   */ 
  function remove (string _address) onlyOwner public {
    require(exists(_address));
    regulators[_address] = false;
    emit RegulatorRemoved(_address);
  }

}
