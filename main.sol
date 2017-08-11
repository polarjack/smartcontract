pragma solidity ^0.4.11;

contract Admin {
    address public owner = 0x0;
    uint[300] public saveStudent;
    uint public indexSaveStudent = 0;
    
    struct Student {
        address who;
        mapping(address => uint) certificates;
        uint status;
    }
    mapping(uint => Student) public members;
    
    event MemberChange(address changer, uint studentId, uint status);
    event MemberCertificateChange(address changer, uint studentId, address certificate, uint status);
    
    function Admin() {
        owner = msg.sender;
    }

    function addStudent(uint studentId, address studentAddress) {
        members[studentId].who = studentAddress;
        members[studentId].status = 1;
        saveStudent[indexSaveStudent] = studentId;
        indexSaveStudent++;
        
        MemberChange(msg.sender, studentId, 1);
    }
    function deleteStudent(uint studentId) {
        members[studentId].status = 0;
        
        MemberChange(msg.sender, studentId, 0);
    }
    
    function addCertificate(uint studentId, address certificateAddress) {
        members[studentId].certificates[certificateAddress] = 1;
        
        MemberCertificateChange(msg.sender, studentId, certificateAddress, 1);
    }
    
    function deleteCertificate(uint studentId, address certificateAddress) {
        members[studentId].certificates[certificateAddress] = 0;
        
        MemberCertificateChange(msg.sender, studentId, certificateAddress, 0);
    }

    //status code: 0 => not exist, 1 => exist , 2 => userInvalid
    function ifSingleCertificateExist(uint studentId, address certificate) returns (uint) {
        if(members[studentId].status == 0) {
            return 2;
        }
        else {
            return members[studentId].certificates[certificate];
        }
    }
}