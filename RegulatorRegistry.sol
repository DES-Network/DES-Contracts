pragma solidity ^0.4.24;

import "./lib/Ownable.sol";


/**
 * @title RegulatorRegistry
 * @dev The RegulatorRegistry contract is Ownable and allows addition, 
 * and removal of regulator addresses in the DES network.
 */
contract RegulatorRegistry is Ownable {

  // regulator address
  mapping(address => bool) regulators;

  // number of regulators registered
  uint count;

  event RegulatorRegistered(address indexed _address);
  event RegulatorRemoved(address indexed _address);
  

  /**
   * @dev Allows anyone to check if the given address belongs to a 
   * registered regulator
   * @param _address The address to check for regulator privileges
   */
  function exists (address _address) public view returns (bool) {
    return regulators[_address];
  }


  /**
   * @dev Allows only the owner to add the given address as a  
   * regulator
   * @param _address The address to register
   */ 
  function register (address _address) onlyOwner public {
    require(!exists(_address));
    regulators[_address] = true;
    count++;
    emit RegulatorRegistered(_address);
  }

  /**
   * @dev Allows only the owner to remove the given address from 
   * the regulator registry
   * @param _address The address to remove from registry
   */ 
  function remove (address _address) onlyOwner public {
    require(exists(_address));
    regulators[_address] = false;
    emit RegulatorRemoved(_address);
  }

}
