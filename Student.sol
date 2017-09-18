pragma solidity ^0.4.11;

contract Student {
    address public creator = 0x0;
    address public student = 0x0;
    address public previous = 0x0;
    
    bytes32[100] public savingVideos;
    address[10] public savingCertificates;
    
    uint public indexV = 0;
    uint public indexCer = 0;
    
    mapping(bytes32 => uint) public videos;
    mapping(address => uint) public certificates;
   
    event StudentChange(address beforeStudent, address afterStudent, address changer);
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
    function addVideo(bytes32 inputV) {
        videos[inputV] = 1;
        savingVideos[indexV] = inputV;
        indexV++;
        VideoChange(msg.sender, inputV, 1);
    }
    function deleteVideo(bytes32 inputV) {
        videos[inputV] = 0;
        VideoChange(msg.sender, inputV, 0);
    }
    function ifInside(bytes32 inputV) constant returns (uint){
        return videos[inputV];
    }
    
    //only creator and studnet can get the whole list
    function showAllVideos() constant returns (bytes32[100]) {
        return savingVideos;
    }
   
    //certificates part
    function addCertificates(address input) {
        certificates[input] = 1;
        savingCertificates[indexCer] = input;
        indexCer++;
        
        CertificateChange(msg.sender, input, 1);
    }
    function deleteCertificates(address input) {
        certificates[input] = 0;
        CertificateChange(msg.sender, input, 0);
    }
    
    function showAllCer() constant returns (address[10]){
        return savingCertificates;
    }
    
    //important function
    function changeStudent(address input) onlyOwner {
        previous = student;
        student = input;
        
        StudentChange(previous, input, msg.sender);
    }
    
    //show the target user
    function showStudnet() constant returns(address) {
        return student;
    }
}