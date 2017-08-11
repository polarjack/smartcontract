pragma solidity ^0.4.11;

contract Certificate {
    enum Status { Confirmed, Waiting, Failed }
    
    struct Video {
        uint videoId;
        bytes32 info;
        Status status;
    }
    
    
    modifier checkCounter {
        require(current_counter < 25);
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
        videos[current_counter].info = _info;
        videos[current_counter].videoId = _videoId;
        videos[current_counter].status = Status.Waiting;
        
        videoIndex[_videoId] = current_counter;
        current_counter++;
    }
    
    function deleteVideo(uint _videoId) includeVideo(_videoId) {
        uint index = videoIndex[_videoId];
        delete videos[index];
        delete videoIndex[_videoId];
        current_counter--;
    }
    
    function confirmVideo(uint _videoId, bytes32 _info) includeVideo(_videoId){
        uint index = videoIndex[_videoId];
        videos[index].status = Status.Confirmed;
    }

    function failedVideo(uint _videoId, bytes32 _info) includeVideo(_videoId) {
        uint index = videoIndex[_videoId];
        videos[index].status = Status.Failed;
    }

    function renderEmptyPlace() checkCounter{

    }
       
    function findVideo(uint _videoId) returns (bool) {
        if(videoIndex[_videoId] < 0) {
            return false;
        }
        else if(videoIndex[_videoId] > max_length) {
            return false;
        }
        return true;
    }
    

    uint current_counter = 0;
    uint max_length = 25;
    uint empty_place = 0;

    uint confirmed_count = 0;
    
    mapping (uint => uint) videoIndex;
    Video[50] public videos;
}