pragma solidity ^0.4.8;

    /*
    https://solidity-by-example.org/sending-ether/

    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

contract Bank {

    mapping (address => uint) private userBalances;

    function stake() public payable {
        require(msg.value > 0);
        userBalances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint withdrawAmount = userBalances[msg.sender];
        (bool success, ) = msg.sender.call.value(withdrawAmount)("");
        require(success, "Withdraw failed");
        userBalances[msg.sender] = 0;
    }

    function getBalance() public view returns (uint) {
        return userBalances[msg.sender];
    }

    function getTotalBalance() public view returns (uint) {
        return address(this).balance;
    }

}
