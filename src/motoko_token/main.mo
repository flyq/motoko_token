import AssocList "mo:base/AssocList";
import List "mo:base/List";

shared({ caller = initializer }) actor class Token(_name : Text, _decimals : Nat8, _symbol : Text, _total : Nat64) {
    private stable let name : Text = _name;
    private stable let decimals : Nat8 = _decimals;
    private stable let symbol : Text = _symbol;

    private stable var balances : AssocList.AssocList<Principal, Nat64> = List.nil<(Principal, Nat64)>();
    private stable let total : Nat64 = _total * 10**decimals;
    AssocList.replace<Principal, Nat64>(balances, caller, principal_eq, total);

    public shared({ caller }) func transfer(to: Principal, value: Nat64) : async Bool {
        var temp : Nat64 = switch AssocList.find<Principal, Nat64>(balances, caller, principal_eq) {
            case (?Nat64) Nat64;
            case (_) 0;
        }
        if (temp < value) {
            return false;
        }
        AssocList.replace<Principal, Nat64>(balances, caller, principal_eq, temp - value);
        return true
    }

    public shared({ caller }) func balanceOf(who: Principal) : async Nat64 {
        var temp : Nat64 = switch AssocList.find<Principal, Nat64>(balances, caller, principal_eq) {
            case (?Nat64) Nat64;
            case (_) 0;
        }
        return temp;
    }

    func principal_eq(a: Principal, b: Principal): Bool {
        return a == b;
    };

    // Return the principal of the message caller/user identity
    public shared({ caller }) func callerPrincipal() : async Principal {
        return caller;
    };
};
