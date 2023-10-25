pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "../src/Etherstore.sol";
import "../src/Attack.sol";

contract ContractTest is Test {
    EtherStore store;
    Attack attack;

    function setUp() public {
        store = new EtherStore();
        
        // Deposit 10 ether into store contract initially
        store.deposit{value: 10 ether}();
        
        attack = new Attack(address(store));
    }

    function testReentrancy() public {
        // Perform a reentrancy attack by depositing 1 ether in the Attack contract
        attack.attack{value: 1 ether}();
        
        // Check if the balance of EtherStore is now 0 after the reentrancy attack
        assertEq(store.getBalance(), 0, "EtherStore balance should be 0 after the reentrancy attack");
    }
}
