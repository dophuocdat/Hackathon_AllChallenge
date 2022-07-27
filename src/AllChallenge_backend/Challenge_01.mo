import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
actor{

    /*Challenge 1 : Write a function add that takes two natural numbers n and m and returns the sum.*/
     public func Sum(number1 : Nat,  number2 : Nat): async Nat{
     return ( number1+number2);
  };

  /*Challenge 2 : Write a function square that takes a natural number n and returns the area of a square of length n.*/
    public func square(length: Nat): async Nat {
      return (length * length);
    };
    
    /*Challenge 3 : Write a function days_to_second that takes a number of days n and returns the number of seconds.*/
    public func days_to_second(days : Nat): async Nat{
     return (days * 24 *3600);
    };


     /*Challenge 4 Write two functions increment_counter & clear_counter .*/
     var count : Nat = 0;
     public func increment_counter( n : Nat) : async Nat{
      count += n;
      return count;
     };
     
     public func clear_counter (): async Nat{
      count := 0;
      return count;
     };


    /*Challenge 5 : Write a function divide that takes two natural numbers n and m and returns a boolean indicating if n divides m.*/
    public func divide(n : Nat, m : Nat) : async Bool{
      if(n % m == 0){
        return true;
      };
      return false;
    };


    /*Challenge 6 : Write a function is_even that takes a natural number n and returns a boolean indicating if n is even.*/
    public func is_even(n : Nat) : async Bool{
      return (n%2 ==0);
    };
   
    /*Challenge 7 Write a function sum_of_array that takes an array of natural numbers and returns the sum. This function will returns 0 if the array is empty.*/
    public func sum_of_array(array : [Nat]): async Nat{
       var sum :Nat = 0;
       for(value in array.vals()){
         sum := sum + value;
       };
       if(sum > 0){
        return (sum);
       };
       return 0;
   };


   /*Challenge 8  Write a function maximum that takes an array of natural numbers and returns the maximum value in the array. This function will returns 0 if the array is empty.*/
   public func maximum(arr: [Nat]) : async Nat{
    var max = 0;
    for( value in arr.vals() ){
      max:= if(value > max) value else max;
    };
    return max;
   };


   /*Challenge 9 : Write a function remove_from_array that takes 2 parameters : an array of natural numbers and a natural number n and returns a new array where all occurences of n have been removed (order should remain unchanged).
   */
   public func remove_array(arr : [Nat], n: Nat) : async [Nat]{
    var new_arr : [Nat]=[];
    for(value in arr.vals()){
      if(value != n){
        new_arr := Array.append<Nat>(new_arr,[value]);
      };
    };
    return new_arr;
   };


  /*Challenge 10 Implement a function selection_sort that takes an array of natural numbers and returns the sorted array .*/
  public func selection_sort(arr : [Nat]): async [Nat]{
    return Array.sort<Nat>(arr, func(a,b){Nat.compare(a,b)});
  };

};