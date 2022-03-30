pragma solidity >= 0.8.11;

contract SimpleGreeter {
  string private _greeting = "Hello, World!";
  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function greet() external view returns(string memory) {
    return _greeting;
  }

  function setSuperGreeting(string calldata greeting) external {
    require(msg.sender == owner, "Only owner");
    _greeting = greeting;
  }
}
