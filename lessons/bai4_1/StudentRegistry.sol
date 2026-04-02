// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRegistry {

    // 1. Tạo struct Student
    struct Student {
        string name;
        uint age;
        bool isRegistered;
    }

    // 2. Dùng mapping(address => Student) để lưu thông tin
    mapping(address => Student) private students;

    // 3. Hàm đăng ký bản thân
    function register(string memory _name, uint _age) public {
        // Kiểm tra xem ví này đã đăng ký chưa để tránh ghi đè dữ liệu
        require(!students[msg.sender].isRegistered, "Student is already registered!");
        
        // Lưu thông tin người dùng vào mapping
        students[msg.sender] = Student({
            name: _name,
            age: _age,
            isRegistered: true
        });
    }

    // 4. Hàm trả về thông tin student
    function getStudent(address _user) public view returns (string memory name, uint age, bool isRegistered) {
        Student memory student = students[_user];
        return (student.name, student.age, student.isRegistered);
    }

    // 5. Hàm kiểm tra xem student đã đăng ký chưa
    function isStudentRegistered(address _user) public view returns (bool) {
        return students[_user].isRegistered;
    }
}