// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRegistryV2 {
    
    // 1. Biến lưu trữ địa chỉ của owner (người deploy)
    address public owner;

    struct Student {
        string name;
        uint age;
        bool isRegistered;
    }

    mapping(address => Student) private students;

    // 2. Định nghĩa Event để ghi log khi thêm sinh viên thành công
    event StudentAdded(address indexed studentAddress, string name, uint age);

    // 3. Hàm khởi tạo: Gán người deploy contract làm owner
    constructor() {
        owner = msg.sender;
    }

    // 4. Định nghĩa Modifier để giới hạn quyền
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner!");
        _; // Dấu _; đại diện cho phần code của hàm sẽ được thực thi nếu require thỏa mãn
    }

    // 5. Hàm thêm sinh viên (áp dụng modifier onlyOwner)
    function registerStudent(address _studentAddress, string memory _name, uint _age) public onlyOwner {
        // Kiểm tra xem sinh viên này đã được đăng ký chưa
        require(!students[_studentAddress].isRegistered, "Student is already registered!");
        
        // Lưu thông tin sinh viên
        students[_studentAddress] = Student({
            name: _name,
            age: _age,
            isRegistered: true
        });

        // 6. Phát ra sự kiện (emit event) để ghi log
        emit StudentAdded(_studentAddress, _name, _age);
    }

    // Hàm đọc thông tin sinh viên
    function getStudent(address _studentAddress) public view returns (string memory name, uint age, bool isRegistered) {
        Student memory student = students[_studentAddress];
        return (student.name, student.age, student.isRegistered);
    }

    // Hàm kiểm tra sinh viên đã đăng ký chưa
    function isStudentRegistered(address _studentAddress) public view returns (bool) {
        return students[_studentAddress].isRegistered;
    }
}