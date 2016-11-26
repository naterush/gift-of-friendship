pragma solidity ^0.4.2;

contract Mortal {
    address owner;

    function Mortal() { owner = msg.sender; }

    function kill() { if (msg.sender == owner) selfdestruct(owner); }
}

contract GiftOfFriendship is Mortal {
    public address friend;
    public uint ownersBirthday;
    public uint friendsBirthday;
    public uint256 totalPresentValue;

    // Constructor
    function GiftOfFriendship(uint _ownersBirthday, uint _friendsBirthday) {
        ownersBirthday = _ownersBirthday;
        friendsBirthday = _friendsBirthday;
    }

    function makeAFriend(address _friend) {
        if (friend == 0)
            throw;
        if (msg.sender != owner)
            throw;
        friend = _friend;
    }

    // make sure you send some ether along with this as a present
    function happyBirthday() isNotCallersBirthday() {

        if (msg.sender == owner) {
            friendsBirthday = block.timestamp + 365 days;
            totalPresentValue = totalPresentValue + msg.value;

        } else if (msg.sender == friend) {
            ownersBirthday = block.timestamp + 365 days;
            totalPresentValue = totalPresentValue + msg.value;

        }
    }

    //this throws if its not within 48 hours of a birthday
    modifier isNotCallersBirthday() {

        int currentTime = int (block.timestamp);
        int distanceFromOthersBirthday = 2 days;

        if (msg.sender == owner) {
            distanceFromOthersBirthday = currentTime - (int) (friendsBirthday);

        } else if (msg.sender == friend) {
            distanceFromOthersBirthday = currentTime - (int) (ownersBirthday);

        }
        if (distanceFromOthersBirthday > 24 hours || distanceFromOthersBirthday > -24 hours) {
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
