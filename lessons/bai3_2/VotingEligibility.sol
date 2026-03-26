// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingEligibility {
    // Khởi tạo biến minAge với giá trị mặc định là 18
    uint public minAge = 18;
    
    // Biến lưu trữ địa chỉ ví của người deploy (chủ sở hữu)
    address public owner;

    // Constructor chỉ chạy 1 lần duy nhất khi contract được deploy
    constructor() {
        owner = msg.sender; // msg.sender lúc này là ví đang thực hiện deploy
    }

    // Hàm kiểm tra tính hợp lệ (sử dụng if/else theo mục tiêu bài học)
    // Dùng 'view' vì hàm này có đọc dữ liệu state (minAge) nhưng không sửa nó
    function checkEligibility(uint _age) public view returns (bool) {
        if (_age >= minAge) {
            return true;
        } else {
            return false;
        }
        // Mẹo nhỏ: Trong thực tế, lập trình viên thường viết cực kỳ ngắn gọn là:
        // return _age >= minAge;
    }

    // Hàm cập nhật minAge
    function updateMinAge(uint _newMinAge) public {
        // Kiểm tra: Người đang gọi hàm (msg.sender) có phải là owner không?
        // Nếu không phải, giao dịch sẽ bị huỷ (revert) và báo lỗi.
        require(msg.sender == owner, "Loi: Ban khong phai la nguoi tao contract!");
        
        minAge = _newMinAge;
    }
}