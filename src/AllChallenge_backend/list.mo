module{
    public type List<T> =?(T, List<T>);

        /*Challenge 7 : Write a function is_null that takes l of type List<T> and returns a boolean indicating 
        if the list is null . Tips : Try using a switch/case.*/

        public func is_null<T>(l : List<T>): async Bool{
            switch(l){
                case (null) return true;
                case (_) return false;
            };
        };
        //*CHALLENGE 8
    public func last<T>(l: List<T>) : ?T {
        switch(l) {
            case(null) {
                return null;
            };
            case(?(n, null)) return ?n;
            case(?(n, rest)) return last(rest);
        };
    };

    //*CHALLENGE 9
    public func size<T>(l : List<T>) : Nat {
        func ca(l : List.List<T>, n : Nat) : Nat {
        switch l {
            case null { n };
            case (?(_, t)) { ca(t, n + 1) };
        }
        };
        ca(l,0)
    };

    //*CHALLENGE 10
    public func get<T>(l : List<T>, n : Nat) : ?T {
        switch (n, l) {
        case (_, null) { null };
        case (0, (?(h, t))) { ?h };
        case (_, (?(_, t))) { get<T>(t, n - 1) };
        }
    };
}