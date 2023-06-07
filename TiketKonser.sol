pragma solidity >0.7.0 <=0.9.0;

contract TiketKonser {

    uint totalTiket;
    uint totalHarga;
    uint tiketTerjual;

    address payable pembeli;
    address organizer;
    
    constructor (uint _totalTiket) {
        organizer = msg.sender;
        totalTiket = _totalTiket;
        tiketTerjual = 0;
    }

    function beliTiket(uint totalBeli) public payable {
        require(totalBeli > 0, "Tidak boleh 0");
        require(totalTiket > totalBeli , "Tiket Tidak Cukup");
        totalHarga = totalBeli * (0.01 ether);
        tiketTerjual += totalBeli;

        pembeli = payable(msg.sender);
        require(msg.value >= totalHarga, "Uang tidak cukup");
        if(msg.value > totalHarga) {
            uint uangKembalian = msg.value - totalHarga;
            pembeli.transfer(uangKembalian);
        }
    }

    function sisaTiket() public view returns(uint) {
        return(totalTiket - tiketTerjual);
    }
}
