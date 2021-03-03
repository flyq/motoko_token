import AssocList "mo:base/AssocList";
import List "mo:base/List";
import Nat8 "mo:base/Nat8";
import Nat64 "mo:base/Nat64";
import Principal "mo:base/Principal";

shared({ caller = initializer }) actor class Token(_name : Text, _decimals : Nat64, _symbol : Text, _total : Nat64) {
    private stable let name : Text = _name;
    private stable let decimals : Nat64 = _decimals;
    private stable let symbol : Text = _symbol;

    private stable var balances : AssocList.AssocList<Principal, Nat64> = List.nil<(Principal, Nat64)>();
    private stable let total : Nat64 = _total * 10**decimals;
    balances := AssocList.replace<Principal, Nat64>(balances, initializer, Principal.equal, ?total).0;

    public shared({ caller }) func transfer(to: Principal, value: Nat64) : async Bool {
        var caller_balance : Nat64 = switch (AssocList.find<Principal, Nat64>(balances, caller, Principal.equal)) {
            case (?Nat64) Nat64;
            case (_) 0;
        }; 
        if (caller_balance < value) {
            return false;
        };
        var to_balance : Nat64 = switch (AssocList.find<Principal, Nat64>(balances, caller, Principal.equal)) {
            case (?Nat64) Nat64;
            case (_) 0;
        };
        balances := AssocList.replace<Principal, Nat64>(balances, caller, Principal.equal, ?(caller_balance - value)).0;
        balances := AssocList.replace<Principal, Nat64>(balances, to, Principal.equal, ?(to_balance + value)).0;
        return true;
    };

    public shared({ caller }) func balanceOf(who: Principal) : async Nat64 {
        var temp : Nat64 = switch (AssocList.find<Principal, Nat64>(balances, who, Principal.equal)) {
            case (?Nat64) Nat64;
            case (_) 0;
        };
        return temp;
    };

    // Return the principal of the message caller/user identity
    public shared({ caller }) func callerPrincipal() : async Principal {
        return caller;
    };
};
