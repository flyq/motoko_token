import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";

shared({ caller }) actor class Token(_name : Text, _decimals : Nat, _symbol : Text, _total : Nat, _owner: Principal) {
    private stable let name_ : Text = _name;
    private stable let decimals_ : Nat = _decimals;
    private stable let symbol_ : Text = _symbol;

    private stable let totalSupply_ : Nat = _total * 10**_decimals;

    private var balances =  HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    balances.put(_owner, _total * 10**_decimals);

    private var allowed = HashMap.HashMap<Principal, HashMap.HashMap<Principal, Nat>>(1, Principal.equal, Principal.hash);

    public shared({ caller }) func transfer(to: Principal, value: Nat) : async Bool {
        switch (balances.get(caller), balances.get(to)) {
            case (?caller_balance, ?to_balance) {
                if (caller_balance >= value ) {
                    var caller_balance_new = caller_balance - value;
                    var to_balance_new = to_balance + value;
                    balances.put(caller, caller_balance_new);   // 优化，如果余额为零，直接 delete
                    balances.put(to, to_balance_new);
                    return true;
                } else {
                    return false;
                };
            };
            case (?caller_balance, null) {
                if (caller_balance >= value ) {
                    var caller_balance_new = caller_balance - value;
                    balances.put(caller, caller_balance_new);
                    balances.put(to, value);
                    return true;
                } else {
                    return false;
                };
            };
            case (_) {
                return false;
            };
        }
    };

    public shared({ caller }) func transferFrom(from: Principal, to: Principal, value: Nat) : async Bool {
        switch (balances.get(from), allowed.get(from)) {
            case (?from_balance, ?allow_to) {
                switch (allow_to.get(caller)) {
                    case (?allow_num) {
                        if (from_balance >= value and allow_num >= value) {
                            var from_balance_new = from_balance - value;
                            var allow_num_new = allow_num - value;
                            var to_balance_new = switch (balances.get(to)) {
                                case (?to_balance) {
                                   to_balance + value;
                                };
                                case (_) {
                                    value;
                                };
                            };
                            allow_to.put(caller, allow_num_new);
                            allowed.put(from, allow_to);
                            balances.put(from, from_balance_new);
                            balances.put(to, to_balance_new);
                            return true;                            
                        } else {
                            return false;
                        };
                    };
                    case (_) {
                        return false;
                    };
                }
            };
            case (_) {
                return false;
            };
        }
    };

    public shared({ caller }) func approve(spender: Principal, value: Nat) : async Bool {
        switch(allowed.get(caller)) {
            case (?allow_to) {
                allow_to.put(spender, value);
                allowed.put(caller, allow_to);
                return true;
            };
            case (_) {
                var temp = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
                temp.put(spender, value);
                allowed.put(caller, temp);
                return true;
            };
        }
    };

    public query func balanceOf(who: Principal) : async Nat {
        switch (balances.get(who)) {
            case (?balance) {
                return balance;
            };
            case (_) {
                return 0;
            };
        }
    };

    public query func allowance(owner: Principal, spender: Principal) : async Nat {
        switch(allowed.get(owner)) {
            case (?allow_to) {
                switch(allow_to.get(spender)) {
                    case (?allow_num) {
                        return allow_num;
                    };
                    case (_) {
                        return 0;
                    };
                }
            };
            case (_) {
                return 0;
            };
        }
    };

    public query func totalSupply() : async Nat {
        return totalSupply_;
    };

    public query func name() : async Text {
        return name_;
    };

    public query func decimals() : async Nat {
        return decimals_;
    };

    public query func symbol() : async Text {
        return symbol_;
    };

    // Return the principal of the message caller/user identity
    public shared({ caller }) func callerPrincipal() : async Principal {
        return caller;
    };
};
