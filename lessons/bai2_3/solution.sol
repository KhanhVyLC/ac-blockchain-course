// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WelcomeAdvanced {
    string public greeting;
    address public deployer; // Biến lưu địa chỉ người deploy

    constructor(string memory _greeting) {
        greeting = _greeting;
        deployer = msg.sender; // Ghi nhận người deploy contract
    }

    // Hàm trả về cả câu chào và địa chỉ của người đã deploy
    function getGreetingAndDeployer() public view returns (string memory, address) {
        return (greeting, deployer);
    }
}