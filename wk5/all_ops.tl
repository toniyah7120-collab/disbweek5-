// CMSC430 - Week 5
// Completely new design vs. the examples provided

fn run(a: Int, b: Int, x: Real, ch: Char) -> Void {
    // --- literals & multiple declarations
    var dec, zero: Int = 7, 0;         // decimal int literal
    var hex: Int = 0x0C;               // hexadecimal int literal (12)
    var r1, r2: Real = 4.5, 0.25;      // real literals
    var c1, c2: Char = 'X', 'a';       // character literals

    // --- precedence / associativity probe using all arithmetic ops (+ - * / % ^ ~)
    // No extra parentheses on purpose:
    // ^ binds tighter than * / % which bind tighter than + -
    // Note: with dec=7 and hex=12, dec^2=49, (b*49)%12 == (b%12)
    var prec1: Int  = a + b * dec ^ 2 % hex - 5 / 2;    // integers only: 5/2 uses int division
    var expr2: Real = x / 2.0 + 1.5 * 2.0 - 0x10 % 3;   // mixes real + hex; 0x10%3 = 1
    var tnot:  Int  = ~hex;                              // unary ~

    print("prec1=", prec1);
    print("expr2=", expr2);
    print("tilde_hex=", tnot);

    // --- relational operators (all of them)
    print("a=b?",  a = b);
    print("a/=b?", a /= b);
    print("a>b?",  a > b);
    print("a>=b?", a >= b);
    print("a<b?",  a < b);
    print("a<=b?", a <= b);

    // --- WHEN with alternatives and a nested statement; also exercises logical '&'
    // Uses a single WHEN whose condition is a disjunction of tests separated by '|'
    when ( (a % 2 = 0) | (ch = c1) | (b > a & a >= 0) ) {
        print("when: branch-1");
        // nested in WHEN: & precedence check (both must be true)
        if ( (x < r1) & (a <= b) ) {
            print("nested-when: then");
        } else {
            print("nested-when: else");
        }
    } else {
        print("when: else-branch");
    }

    // --- IF chain (cover eq / less / greater) with nesting
    if ( (a = b) & (b >= 0) ) {
        print("if: equal-case");
    } else if ( a < b & x >= 0.0 ) {
        print("if: less-case");
    } else {
        print("if: greater-case");
    }

    // --- SWITCH on an expression (not just a variable), with nested statements
    var sel: Int = (a + b + 0x0A) % 4;   // 0,1,2,3
    switch (sel) {
        case 0:
            print("switch: zero");
            if (dec > hex) { print("zero:nested-true"); } else { print("zero:nested-false"); }
            break;
        case 1:
            print("switch: one");
            when (r2 <= 0.25 | a > 100) { print("one:nested-when"); } else { print("one:nested-else"); }
            break;
        case 2:
            print("switch: two");
            break;
        default:
            print("switch: other");
            break;
    }

    // --- FOLDs (two styles) to ensure full coverage and more % precedence
    // sum1 = sum_{i=1..a} (i % 3)
    var sum1: Int = fold i in 1..a with acc = 0 do acc + (i % 3);
    // sum2 = ((((1*(0+1))%(0x1F)) * (1+1))%(0x1F) * ... up to i=b)
    var sum2: Int = fold i in 0..b with acc = 1 do (acc * (i + 1)) % 0x1F;

    print("sum1=", sum1);
    print("sum2=", sum2);
}

// ---------- sample driver ----------
fn main() -> Void {
    // Five input sets chosen so every line/branch executes at least once
    run(3, 5, 1.0, 'Q');  // WHEN branch-1 + nested-then, IF:less, SWITCH:2
    run(4, 4, 5.0, 'X');  // WHEN branch-1 + nested-else, IF:eq,   SWITCH:2
    run(1, 0, -1.0, 'Z'); // WHEN else,             IF:greater,     SWITCH:default
    run(2, 0, 2.0, 'Y');  // SWITCH:0
    run(3, 0, 0.1, 'N');  // SWITCH:1
}
