import Text "mo:base/Text";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import D "mo:base/Debug";

actor MusicCanister {
  
// define a record to hold music metadata
  type Music = {
    artist: Text;
    title: Text;
    genre: Text;
    length: Nat;
    rating: Nat;
    url: Text;
    price: Nat;
  };
  // create an array to hold the music records
  var musicList : [Music] = [];

  // Set the value of the counter.
  public func add_music({artist; title; genre; length; rating; url; price} : Music) : async Text {
    let music = {artist = artist; title = title; genre = genre; length = length; rating = rating; url = url; price = price};
    musicList := Array.append(musicList, [music]);
    return "Sample added";
  };

  // get all the music records in the array
  public query  func getAllMusic() : async [Music] {
    return musicList;
  };

  // listen to a specific music record by its index in the array
  public query func listenToMusic(index: Nat) : async Text {
    if (index >= Array.size(musicList)) {
      return "Invalid music index";
    };
    let music = musicList[index];
    return "Listening to " # music.title # " by " # music.artist # "... " # music.url;
  };

  // clear the music list
  public func clearAllMusic() : async Bool {
    musicList := [];
    D.print("All music clear");
    return true;
  };

  public func buy(price: Nat, quantity: Nat, wallet: Text, index: Nat) : async Text {
    let total = price * quantity;
    
    // call a function on the wallet canister to check if the user has enough funds
    let walletResult = 50;

    let music = musicList[index];
    //validate the price is correct
    if (music.price != price) {
      return "The price is incorrect please fill again";
    };

    //validate only one copy
    if (quantity > 1) {
      return "You can only buy one sample";
    };

    if (index >= Array.size(musicList)) {
      return "Invalid music index";
    };
    
    if (walletResult==0) {
      // if the user doesn't have enough funds, return false
      return "no balance";
    } else {
      // if the user has enough funds, deduct the total amount from their wallet balance
      let balance = walletResult;
      
      // perform the actual buy transaction
      // code goes here
      return "Congratulations you will receive your music sample soon";
    }
}

};