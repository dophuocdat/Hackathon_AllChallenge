import Custom "Custom";
import Animal "animal";
import List "mo:base/List";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Cycles "mo:base/ExperimentalCycles";
actor{

    /*Challenge 1 : Create two files called custom.mo and main.mo, create your own type inside custom.mo and import it in your main.mo file. 
    In main, create a public function fun that takes no argument but return a value of your custom type.*/
    let students : Custom.student = {
        name = "Dat";
        age = 19;
        address = "Da nang city";
    };
    public func fun () : async Custom.student{
        return students;
    };
    /* 2 : Create a new file called animal.mo with at least 2 property (specie of type Text, energy of type Nat), 
    import this type in your main.mo and create a variable that will store an animal.*/
    public type Animal = Animal.Animal;

    /*Challenge 4*/
    public func  create_animal_then_takes_a_break(specie : Text, energy : Nat) : async Animal{
        var animal : Animal = { 
            specie = specie;
            energy = energy;
        };
        
        animal := Animal.animal_sleep(animal);
        return animal; 
    };

/*Challenge 5 : In main.mo, import the type List from the base Library and create a list that stores animal.*/
    var animal_list : List.List<Animal> = null;

    /*Challenge 6 : create a function called push_animal that takes an animal as parameter and returns nothing this function should add this animal to your list created in challenge 5.
     Then create a second functionc called get_animals that takes no parameter but returns an Array that contains all animals stored in the list.*/
     public func push_animal(animal : Animal): (){
        animal_list := List.push<Animal>(animal, animal_list);
     };
     public func get_animals(): async [Animal]{
        return List.toArray<Animal>(animal_list);
     };


     /*Challenge 11*/
     public shared({caller}) func is_anonymous() : async Bool {
      return Principal.equal(caller,Principal.fromText("2vxsx-fae"));
    };
    /*Challenge 12 : Create an HashMap called favoriteNumber where the keys are Principal and the value are Nat.*/
    var favoriteNumber =HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    
    /*Challenge 13*/
    public shared({caller}) func add_favorite_number(n: Nat): async (){
        favoriteNumber.put(caller,n);
    };
     public shared({caller}) func show_favorite_number (): async ?Nat {
         switch(favoriteNumber.get(caller)){
            case (null) return null;
            case (n) return n;
         };
    };

    /*Challenge 14*/
   
    public shared({caller}) func add_favorite_number_Update (n: Nat): async Text {
         switch(favoriteNumber.get(caller)){
            case (null) {
                favoriteNumber.put(caller,n);
                return "You've successfully registered your number"
            };
            case (?n) return "You've already registered your number";
         };
    };
    
    /*Challenge 15: Write two functions
      update_favorite_number
      delete_favorite_number*/
      public shared({caller}) func update_favorite_number(n: Nat): async Result.Result<Text,Text> {
        switch(favoriteNumber.get(caller)){
            case(null) return #err("There is ni favorite number for principal : "# Principal.toText(caller));
            case(_) {
                favoriteNumber.put(caller, n);
                return #ok("Favorite number modified for user with principal : " # Principal.toText(caller));
            };
        };
      };
      public shared({caller}) func delete_favorite_number(principal : Principal) : async Result.Result<(), Text> {
	switch(favoriteNumber.remove(principal)){
            case(null) {
                return #err("There is no favorite number for user with principal " # Principal.toText(principal));
            };
            case(?n){
                return #ok();
            };
        };
    };
    /*Challenge 16*/
    public func deposit_cycles() : async Nat{
            let amount = Cycles.available();
            let acceptable = amount;
            let accepted = Cycles.accept(acceptable);
            assert (accepted == acceptable);
            return accepted;
    }
}
