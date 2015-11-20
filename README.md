# J.Z.-Wentworth-Cache-Now  
ECE 411 Final Project  
Shibo Yao  
Mike Chen  
Jeffrey Zhu (J.Z.)

## Basic Design  
Pipelined CPU based on the [LC-3b ISA](https://courses.engr.illinois.edu/ece411/mp/LC3b_ISA.pdf)  
Two levels of cache w/ write-back, write-allocate policies
 * Split L1 caches, 2-ways, 128-bit lines (one for instructions, one for data)
 * One L2 cache, 4-ways, 256-bit lines

## Advanced Design 
 * L2 cache is 4-ways and uses a pseudo-lru replacement policy
 * STAY TUNED FOR MORE!!
