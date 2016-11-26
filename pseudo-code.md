#Pseudo Code for GiftOfFriendship.
This code is all a work in progress, and also my first dApp, so please point out any glaring issues you find.

In later issues, there may be a change to the structure of the dApp, where each person has a dApp that interacts with other's dApp's, but this is draft one.

##constructor GiftOfFriendship()
The constructor creates the contract, and is assigned ownership over it

##modifier isOwner()
Makes sure that the owner of the contact is the one calling the function

##modifier hasNoFriends()
Makes sure that the one calling the function currently has no friends. 

##function makeAFriend(friendsAddress) isOwner() hasNoFriends()
If you are the owner if this contact and have no friends currently, you can makeANewFriend.
When you make a new friend, you agree to give them a gift on their birthday.

##function happyBirthday()
This function is sent with the corresponding amount of ether that you want to give to your friend as a gift. This function should be called by each participant in the contact once a year, on their friends birthdays. 
The first time it is called is when the owner of the contract call's it for his/her friends birthday. The next time its called is on the owners birthday, in which case it is being called by the friend.
The present you send with happyBirthday is stored in a vault. It can only be accessed if the other person forgets to wish you happyBirthday.

##function happyBelatedBirthday()
This function can be called in the week following the other person's birthday. You should still send it with your "present," but this time some of this present goes directly to the other persons wallet. 

##function changeMyBirthday()
If both parties agree, than the date of either members birthday can be changed. 

##function takeMyPresent()
If the other member forgets to wish you a happyBirthday or a happyBelatedBirthday, then you can take your present. 
