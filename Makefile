PROG=test
OBJS=add_with_overflow.bc test.bc

CC=clang
COPTS=-Wall -O2
LLVM_OPT_OPTS=-std-compile-opts

LLVM_AS=llvm-as
LLVM_LINK=llvm-link
LLVM_LLC=llc
LLVM_OPT=opt

all: $(PROG)

.SUFFIXES: .bc .ll .cpp

$(PROG): $(PROG).optimized.s
	$(CC) $(COPTS) -o $@ $@.optimized.s

$(PROG).optimized.s: $(OBJS)
	$(LLVM_LINK) -o $(PROG).linked.bc $(OBJS)
	$(LLVM_OPT) $(LLVM_OPT_OPTS) -o $(PROG).optimized.bc $(PROG).linked.bc
	$(LLVM_LLC) -o $(PROG).optimized.s $(PROG).optimized.bc

clean:
	rm -f $(PROG)
	rm -f $(PROG).optimized.s
	rm -f $(PROG).linked.bc
	rm -f $(PROG).optimized.bc
	rm -f $(OBJS)

.ll.bc:
	$(LLVM_AS) -o $@ $<

.cpp.bc:
	$(CC) $(COPTS) -emit-llvm -S -o $@ $<

