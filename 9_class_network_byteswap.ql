import cpp

predicate isntoh_(Macro m) {
    m.getName().regexpMatch("ntoh.*")
}

class NetworkByteSwap extends Expr {
  NetworkByteSwap () {
    exists(MacroInvocation mi |
        isntoh_(mi.getMacro())
        and
        mi.getExpr() = this
    )
  }
}

from NetworkByteSwap n
select n, "Network byte swap"
