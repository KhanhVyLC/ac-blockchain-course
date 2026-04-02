// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    
    // Biến lưu trữ địa chỉ của admin (owner)
    address public owner;
    
    // Biến đếm tổng số lượng ứng viên để làm ID (key) cho mapping
    uint public candidatesCount;

    //  Struct Candidate gồm name và voteCount
    struct Candidate {
        string name;
        uint voteCount;
    }

    //  Mapping lưu danh sách ứng viên (ID ứng viên => Thông tin ứng viên)
    mapping(uint => Candidate) public candidates;

    //  Mapping kiểm tra xem một địa chỉ ví đã vote hay chưa
    mapping(address => bool) public hasVoted;

    //  Event ghi log khi có người vote thành công
    event Voted(address indexed voter, uint candidateId);

    //  Modifier kiểm soát quyền admin
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner!");
        _;
    }

    // Hàm khởi tạo, gán người deploy làm owner
    constructor() {
        owner = msg.sender;
    }

    // Hàm thêm ứng viên (Chỉ Admin mới được dùng)
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++; // Tăng ID lên 1 (bắt đầu từ 1)
        candidates[candidatesCount] = Candidate({
            name: _name,
            voteCount: 0 // Khởi tạo số phiếu bằng 0
        });
    }

    // Hàm để người dùng thực hiện vote
    function vote(uint _candidateId) public {
        // Kiểm tra xem người này đã vote chưa
        require(!hasVoted[msg.sender], "You have already voted!");
        
        // Kiểm tra ID ứng viên có hợp lệ không (từ 1 đến tổng số ứng viên)
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID!");

        // Đánh dấu người này đã vote để không được vote lại
        hasVoted[msg.sender] = true;

        // Tăng số phiếu cho ứng viên được chọn
        candidates[_candidateId].voteCount++;

        // Ghi log sự kiện vote
        emit Voted(msg.sender, _candidateId);
    }
}