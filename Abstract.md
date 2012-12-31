With the increasing need for large scale data centers for industrial
and research purposes, the difficulty of distributed programming is
becoming more apparent. Some languages are bettter suited for large
scale distributed programming. Erlang , with its actor model,
particularly has proven quite successful for programming large
clusters. There have been recent advances in Haskell in area of
distributed programming. Cloud Haskell, a recent implementation, is a
domain-speciﬁc language for developing programs for a distributed
computing environment. Implemented as a shallow embedding in Haskell,
it provides a message passing communication model, inspired by Erlang.

Apache Pig is a platform for analyzing large data sets that consists
of a high-level language for expressing data analysis programs,
coupled with infrastructure for evaluating these programs.

In this project , we have looked into the specific advantages Cloud
Haskell brings to programmers for distributed programming and look at
how a Pig-like DSL on top of CloudHaskell could be implemented.