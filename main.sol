pragma solidity ^0.4.11;

contract Admin {
    
    struct Student {
        address who;
        uint status;
    }
    
    event MemberChange(address changer, uint status);
    event MemberCertificateChange(address changer, address certificate, uint status);
    
    modifier checkStudentIndex() {
        require(indexSaveStudent < 300);
        _:
    }

    function Admin() {
        owner = msg.sender;
    }

    function addStudent(address studentAddress) checkStudentIndex {
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
    
    address public owner = 0x0;
    uint[300] public saveStudent;
    uint public indexSaveStudent = 0;

    mapping(uint => Student) public members;
}