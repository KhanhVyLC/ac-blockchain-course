export class SmartContract {
    private message: string;

    // Tương đương với việc lúc Deploy Contract, ta truyền giá trị khởi tạo
    constructor(initialMessage: string) {
        this.message = initialMessage; 
    }

    // Tương đương với một transaction gọi hàm để thay đổi State trên Blockchain
    public updateMessage(newMsg: string): void {
        this.message = newMsg; 
    }

    // Tương đương với một hàm "view" trong Solidity để đọc dữ liệu mà không tốn gas
    public getMessage(): string {
        return this.message; 
    }
}
