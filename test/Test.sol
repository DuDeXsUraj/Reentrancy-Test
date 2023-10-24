pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "../src/Etherstore.sol";
import "../src/Attack.sol";

contract ContractTest is Test {
    EtherStore store;
    Attack attack;

    function setUp() public {
        store = new EtherStore();
        attack = new Attack(address(store));

        // Deposit 10 ether into store contract
        store.deposit{value: 10 ether}();
    }

    function testReentrancy() public {
        // Simulate 10 attacks, reducing the balance of EtherStore by 1 ether each time
        for (uint i = 0; i < 10; i++) {
            attack.attack{value: 1 ether}();
        }
        
        // Check if the balance of EtherStore is now 0 after 10 attacks
        assertEq(store.getBalance(), 0, "EtherStore balance should be 0 after 10 attacks");
    }
}
