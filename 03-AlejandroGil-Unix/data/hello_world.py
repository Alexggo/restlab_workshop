#!/usr/bin/env python

# Obtained from https://github.com/jbornschein/mpi4py-examples/blob/master/01-hello-world

from __future__ import print_function
from mpi4py import MPI

comm = MPI.COMM_WORLD

print("Hello! I'm rank %d from %d running in total..." % (comm.rank, comm.size))

comm.Barrier() # wait for everybody to synchronize _here_
