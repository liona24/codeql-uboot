import cpp


predicate isntoh_(Macro m) {
    m.getName().regexpMatch("ntoh.*")
    /*
    m.getName() = "ntohl"
    or
    m.getName() = "ntohll"
    or
    m.getName() = "ntohs"
    */
}

from MacroInvocation mi
where isntoh_(mi.getMacro())
select mi, "is ntoh* invocation"
