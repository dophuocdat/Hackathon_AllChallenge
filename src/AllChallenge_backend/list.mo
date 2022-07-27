actor{
    public type List<T> =?(T, List<T>);

        /*Challenge 7 : Write a function is_null that takes l of type List<T> and returns a boolean indicating 
        if the list is null . Tips : Try using a switch/case.*/

        public func is_null<T>(l : List<T>): async Bool{
            switch(l){
                case (null) return true;
                case (_) return false;
            };
        };
        
}