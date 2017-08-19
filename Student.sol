pragma solidity ^0.4.11;

contract Student {
    address public creator = 0x0;
    address public student = 0x0;
    
    bytes32[100] public savingVideos;
    address[10] public savingCertificates;
    
    uint public indexV = 0;
    uint public indexCer = 0;
    
    mapping(bytes32 => uint) public videos;
    mapping(address => uint) public certificates;
   
    event ChangeStudent(address beforeStudent, address afterStudent, address changer);
    event VideoChange(address changer, bytes32 item, uint status);
    event CertificateChange(address changer, address item, uint status);
    
    
    //for identify creator
    modifier onlyOwner () {
        assert(creator == msg.sender);
        _;
    }
   
    //constructor 
    function Student(address input) {
        creator = msg.sender;
        student = input;
        previous = input;
    }
    
    //video part
    function AddVideo(bytes32 inputV) {
        videos[inputV] = 1;
        savingVideos[indexV] = inputV;
        indexV++;
        VideoChange(msg.sender, inputV, 1);
    }
    function DeleteVideo(bytes32 inputV) {
        videos[inputV] = 0;
        VideoChange(msg.sender, inputV, 0);
    }
    function IfInside(bytes32 inputV) constant returns (uint){
        return videos[inputV];
    }
    
    //only creator and studnet can get the whole list
    function ShowAllV() constant returns (bytes32[100]) {
        return savingVideos;
    }
   
   
    //certificates part
    function AddCertificates(address input) {
        certificates[input] = 1;
        savingCertificates[indexCer] = input;
        indexCer++;
        
        CertificateChange(msg.sender, input, 1);
    }
    function DeleteCertificates(address input) {
        certificates[input] = 0;
        CertificateChange(msg.sender, input, 0);
    }
    
    function ShowAllCer() constant returns (address[10]){
        return savingCertificates;
    }
    
    //important function
    function ChangeStudent(address input) onlyOwner {
        address previous = 0x0;
        previous = student;
        student = input;
        
        changeStudent(previous, input, msg.sender);
    }
    
    //show the target user
    function ShowStudnet() constant returns(address) {
        return student;
    }
}