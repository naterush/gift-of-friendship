pragma solidity ^0.4.2;

//GiftOfFriendship will only be mortal while it is in beta. 
//Otherwise, the owner could take the money at any point. 
contract Mortal {
    address owner;

    function Mortal() { owner = msg.sender; }

    function kill() { if (msg.sender == owner) selfdestruct(owner); }
}

contract GiftOfFriendship is Mortal {
    address public friend;
    uint public ownersBirthday;
    uint public friendsBirthday;
    uint256 public totalPresentValue;
    uint256 public minPresentValue;

    // Constructor
    function GiftOfFriendship(uint _ownersBirthday, uint _friendsBirthday, uint256 _minPresentValue) {
        ownersBirthday = _ownersBirthday;
        friendsBirthday = _friendsBirthday;
        minPresentValue = _minPresentValue;
    }

    //this function is outside of contructor because this contract is meant
    //to get one's friends into ethereum. Therefore, they are unlikely to
    //already have an account. 
    function makeAFriend(address _friend) {
        if (friend != 0)
            throw;
        if (msg.sender != owner)
            throw;
        friend = _friend;
    }

    // make sure you send some ether along with this as a present
    function happyBirthday() isFriendsBirthday payable {
        //less than so can make the minPresentValue 0 and it woln't always throw
        if (msg.value < minPresentValue)
            throw;

        if (msg.sender == owner) {
            friendsBirthday = block.timestamp + 365 days;
            totalPresentValue = totalPresentValue + msg.value;

        } else if (msg.sender == friend) {
            ownersBirthday = block.timestamp + 365 days;
            totalPresentValue = totalPresentValue + msg.value;

        }
    }

    //this throws if its not within 48 hours of a birthday
    modifier isFriendsBirthday() {
        if (msg.sender != owner || msg.sender != friend) 
            throw;
            
        int currentTime = int (block.timestamp);
        //like initializing to highest value in sorting algorithm 
        int distanceFromOthersBirthday = 10 days;
        
        if (msg.sender == owner) {
            distanceFromOthersBirthday = currentTime - (int) (friendsBirthday);

        } else if (msg.sender == friend) {
            distanceFromOthersBirthday = currentTime - (int) (ownersBirthday);

        }
        if (distanceFromOthersBirthday > 24 hours || distanceFromOthersBirthday < -24 hours) {
            throw;
        }
        _;
    }

    function takeMyPresent() {
        if (msg.sender == owner) {
            if (ownersBirthday + 2 days < block.timestamp) {
                var payout = totalPresentValue;
                totalPresentValue = 0;
                if (!owner.send(payout)) {
                    throw;
                }
            }

        } else if (msg.sender == friend) {
            if (friendsBirthday + 2 days < block.timestamp) {
                var payout1 = totalPresentValue;
                totalPresentValue = 0;
                if (!friend.send(payout1)) {
                    throw;
                }
            }
        }
    }
}
