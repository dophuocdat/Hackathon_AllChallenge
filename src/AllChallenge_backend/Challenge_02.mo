
import Array "mo:base/Array";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Prim "mo:prim";
import Text "mo:base/Text";

actor{
/*Challenge 1 : Write a function nat_to_nat8 that converts a Nat n to a Nat8. Make sure that your function never trap.*/
   public func nat_to_nat8( n : Nat) : async Nat8{
    return (Nat8.fromNat(n));
    
};
  /*Challenge 2 : Write a function max_number_with_n_bits that takes a Nat n and returns the maximum number than can be represented with only n-bits.*/
   public func max_number_with_n_bits(n : Nat) : async Nat {
    return (2**n - 1);
   };
   /*Challenge 3 : Write a function decimal_to_bits that takes a Nat n and returns a Text corresponding to the binary representation of this number.
Note : decimal_to_bits(255) -> "11111111".*/
  public func decimal_to_bits (n : Nat) :async Text{
    var text ="";
    var N : Nat = n;
    while(N > 0){
      text := Nat.toText(N%2) # text;
      N := (N -(N %2))/2;
    };
    return text;
  };
  /*Challenge 4 : Write a function capitalize_character that takes a Char c and returns the capitalized version of it.*/
  public func capitalize_character (c : Char) :async Char{
    let upChar : Char = Prim.charToUpper(c);
    Debug.print(debug_show( Prim.charToUpper(c)));
    return upChar;
  };
  /*Write a function capitalize_text that takes a Text t and returns the capitalized version of it.*/
  public func capitalize_text (t : Text) : async Text{
    return Text.map(t, Prim.charToUpper);
  };
  /*Write a function is_inside that takes two arguments : a Text t and a Char c and returns a Bool indicating if c is inside t .*/
  public func is_inside(t: Text, c: Char): async Bool{
    for(char in Text.toIter(t)){
      if(char == c){
        return true
      };
    };
    return false;
  };
  /*Challenge 7 : Write a function trim_whitespace that takes a text t and returns the trimmed version of t. 
  Note : Trim means removing any leading and trailing spaces from the text : trim_whitespace(" Hello ") -> "Hello".*/
  public func trim_whitespace(t : Text): async Text{
    let trimmedText: Text = Text.trim(t, #text " ");
    return trimmedText;

  };
  /*Write a function duplicated_character that takes a Text t and returns the first duplicated character in t converted to Text*/

  public func duplicated_character( t : Text): async Text{
    let n  = t.size();
    if(n < 2) return t;
    let c :[Char] = Iter.toArray(t.chars());

    for( char in Iter.range(1, n-1)){
      if(c[char] == c[char-1]){
        return (Char.toText(c[char]))
      };
    };
    return t;
  };

  /*Challenge 9 : Write a function size_in_bytes that takes Text t and returns the number of bytes this text takes when encoded as UTF-8.*/
  public func size_in_bytes( t :Text) : async Nat{
    var bytes = 0;
    for ( char in t.chars()){
      if(Char.toNat32(char) <= 0x7F){ bytes +=1}
      else if(Char.toNat32(char) <= 0x7FF) {bytes +=2}
      else if(Char.toNat32(char) <= 0x7FFF) {bytes +=3}
      else bytes +=4;
    };
    return bytes;
  };
  /*Implement a function bubble_sort that takes an array of natural numbers and returns the sorted array .*/
  public func bubble_sort(arr :[Nat]): async [Nat]{
    let n  = arr.size();
    var arrTemp = Array.thaw<Nat>(arr);
    for(i in Iter.range(0, n-2)){
      for ( j in Iter.range(0,n-2)){
        if(arrTemp[j] > arrTemp[j+1]){
          var temp = arrTemp[j];
          arrTemp[j] := arrTemp[j+1];
          arrTemp[j+1] := temp;
        }

      };
    };
    return Array.freeze<Nat>(arrTemp);

  };

 public func nat_opt_to_nat(n : ?Nat,m : Nat): async Nat{
    switch(n){
        case(null) {return m};
        case(?n) {return n};
    };
  };
  /*Challenge 12 : Write a function day_of_the_week that takes a Nat n and returns a Text value corresponding to the day.
   If n doesn't correspond to any day it will return null .*/
   public func day_of_the_week (n : Nat) : async ?Text{
    do ?{
      switch(n){
        case (1) {"Monday"};
        case (2) {"Tuesday"};
        case (3) { "Wednesday" };
        case (4) { "Thursday" };
        case (5) { "Friday" };
        case (6) { "Saturday" };
        case (7) { "Sunday" };
        case (__) { null ! };
      };
    };
   };
   /*Challege 13: Write a function populate_array that takes an array [?Nat] and returns an array [Nat] where all null values have been replaced by 0.
Note : Do not use a loop.*/
public func populate_array(arr : [?Nat]) : async [Nat]{
  let populate = func ( a  : ?Nat): Nat{
    switch(a){
      case null{return 0};
      case (?a) {return a};
    };
  };
  let arrTemp =  Array.map<?Nat, Nat>(arr, populate);
  return arrTemp;

};
/*Challenge 14 : Write a function sum_of_array that takes an array [Nat] and returns the sum of a values in the array.
Note : Do not use a loop.*/
  public func sum_of_array (arr: [Nat]): async Nat{
    return Array.foldLeft<Nat,Nat>(arr,0,func(x: Nat , y : Nat): Nat{x+y});
  };
  /*Write a function squared_array that takes an array [Nat] and returns a new array where each value has been squared.
Note : Do not use a loop.*/
  public func squared_array (arr : [Nat]): async [Nat]{
    return Array.map<Nat,Nat>(arr,func(a: Nat){a**2})
  };
  /*Challenge 16 : Write a function increase_by_index that takes an array [Nat] and returns a new array where each number has been increased by it's corresponding index.
Note : increase_by_index [1, 4, 8, 0] -> [1 + 0, 4 + 1 , 8 + 2 , 0 + 3] = [1,5,10,3]
Note 2 : Do not use a loop.*/
  public func increase_by_index (arr :[Nat]): async [Nat]{
    return Array.mapEntries<Nat,Nat>(arr,func(a: Nat, index : Nat): Nat { a + index})
    };
  /*Challenge 17 : Write a higher order function contains<A> that takes 3 parameters : an array [A] , a of type A and a function f that takes a tuple of type (A,A) and returns a boolean.
This function should return a boolean indicating whether or not a is present in the array.*/

let f = func contains<A>(arr : [A], a: A, f: (A,A)-> Bool):Bool{
 return Array.foldLeft<A, Bool>(arr, false, func(result, current) {
        if (f(current, a)) return true;
        return result;
      });
  };

  public func contain_test(arr : [Nat], a : Nat) : async Bool {
    try {
      return f<Nat>(arr, a, func(current, desired) {
        return current == desired;
      });
    } catch (e) {
      return false;
    };
  };

};