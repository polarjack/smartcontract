pragma solidity ^0.4.11;

contract Certificate {
    address public student;
    uint head = 1;
    bool if25 = false;

    address[25] public saveVideos;
    uint counter = 0;

    mapping(bytes32 => uint) public videos;
    
    struct Video {
        uint id;
        bytes32 info;
        
    }

    function addVideos(bytes32 input) {
        assert(getIndex(input) > 0);
        assert(head < 26);
        
        videos[input] = head;
        head++;
    }
    
    function deleteVideos(bytes32 input) {
        delete videos[input];
    }
    
    function replaceVideos(bytes32 _from, bytes32 _to) {
        assert(getIndex(_from) > 0);
        assert(getIndex(_to) < 26);
        
        uint replace = getIndex(_from);
        deleteVideos(_from);
        videos[_to] = replace;
    }
    function getIndex(bytes32 input) returns (uint){
        return videos[input];
    }
}