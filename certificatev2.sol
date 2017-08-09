pragma solidity ^0.4.11;

contract Certificate {
    enum Status { Confirmed, Waiting, Failed }
    
    struct Video {
        uint videoId;
        bytes32 info;
        Status status;
    }
    
    
    modifier checkCounter {
        require(counter < 25);
        _;
    }
    
    modifier onlyVideo (uint _videoId) {
        require(!findVideo(_videoId));
        _;
    }
    
    modifier includeVideo (uint _videoId) {
        require(findVideo(_videoId));
        _;
    }
    
    function addVideo(uint _videoId, bytes32 _info) checkCounter onlyVideo(_videoId) {
        videos[counter].info = _info;
        videos[counter].videoId = _videoId;
        videos[counter].status = Status.Waiting;
        
        videoIndex[_videoId] = counter;
        counter++;
    }
    
    function deleteVideo(uint _videoId) includeVideo(_videoId) {
        uint index = videoIndex[_videoId];
        delete videos[index];
        delete videoIndex[_videoId];
    }
    
    function confirmVideo(uint _videoId, bytes32 _info) includeVideo(_videoId){
        uint index = videoIndex[_videoId];
    }
       
    function findVideo(uint _videoId) returns (bool) {
        if(videoIndex[_videoId] < 0) {
            return false;
        }
        else if(videoIndex[_videoId] > max_counter) {
            return false;
        }
        return true;
    }
    

    uint counter = 0;
    uint max_counter = 25;
    
    uint confirmed_count = 0;
    
    mapping (uint => uint) videoIndex;
    Video[50] public videos;
}