// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Profile {
    // Khai báo state variables với từ khóa public
    string public name;
    uint public age;

    // Hàm cập nhật name và age
    // Lưu ý: Kiểu string trong tham số hàm cần đi kèm từ khóa 'memory'
    function setProfile(string memory _name, uint _age) public {
        name = _name;
        age = _age;
    }
}