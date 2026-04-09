import { ethers } from "hardhat";

async function main() {
    // In ra câu yêu cầu của bài tập
    console.log("Test contract trực tiếp bằng hardhat.");

    // Deploy contract Counter trực tiếp
    console.log("Đang deploy Counter contract...");
    const counterContract = await ethers.deployContract("Counter");
    await counterContract.waitForDeployment();

    const contractAddress = await counterContract.getAddress();
    console.log(`Đã kết nối với contract tại địa chỉ: ${contractAddress}`);

    // 1. Gọi hàm increment() - Đây là một transaction làm thay đổi state nên cần tốn gas
    console.log("Đang gửi transaction gọi hàm increment()...");
    const tx = await counterContract.increment();
    
    // Đợi mạng lưới xác nhận transaction
    await tx.wait(); 
    console.log("Transaction đã được xác nhận!");

    // 2. Gọi hàm getCount() - Đây là hàm read-only, không tốn gas
    const count = await counterContract.getCount();
    
    // In kết quả ra console
    console.log(`Kết quả getCount(): ${count.toString()}`);
}

// Xử lý lỗi nếu có
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});