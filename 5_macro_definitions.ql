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

from Macro m
where isntoh_(m)
select m, "is ntoh* function"
