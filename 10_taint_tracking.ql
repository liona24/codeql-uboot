/**
 * @kind path-problem
 */

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

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

class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
      source.asExpr() instanceof NetworkByteSwap
  }
  override predicate isSink(DataFlow::Node sink) {
      exists(FunctionCall c |
        c.getTarget().hasName("memcpy")
        and
        // c.getAnArgument() = sink.asExpr()
        c.getArgument(2) = sink.asExpr()
      )
      /*
      sink.asExpr() instanceof FunctionCall
      and
      sink.asExpr().(FunctionCall).getTarget().hasName("memcpy")
      */
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
