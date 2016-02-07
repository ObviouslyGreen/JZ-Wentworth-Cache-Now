# J.Z.-Wentworth-Cache-Now  
Shibo Yao  
Mike Chen  
Jeffrey Zhu (J.Z.)

## Basic Design  
Pipelined CPU based on the [LC-3b ISA](https://courses.engr.illinois.edu/ece411/mp/LC3b_ISA.pdf)  
Two levels of cache w/ write-back, write-allocate policies controlled by a cache arbiter
 * Split L1 caches, 2-ways, 128-bit lines (one for instructions, one for data)
 * One L2 cache, 4-ways, 256-bit lines
 * Hazard detection and data forwarding

## Advanced Design 
 * L2 cache has 4-ways, multicycle hits, and uses a pseudo-lru replacement policy.
 * Eviction Write Buffer
 * Victim Cache between D-Cache and L2 Cache
 * Local history branch prediction (w/ bimodal counters)
 * LC-3X support for instructions such as DIV, MULT, SUB, etc.
 * Counters for bubbles inserted, branch mispredictions, and cache misses (software visible) at all levels.
