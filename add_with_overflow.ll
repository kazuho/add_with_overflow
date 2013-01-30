define zeroext i1 @add_with_overflow(i32* %r, i32 %x, i32 %y) nounwind uwtable ssp {
entry:
  %r.addr = alloca i32*, align 8
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  store i32* %r, i32** %r.addr, align 8
  store i32 %x, i32* %x.addr, align 4
  store i32 %y, i32* %y.addr, align 4
  %0 = load i32** %r.addr, align 8
  %1 = load i32* %x.addr, align 4
  %2 = load i32* %y.addr, align 4
  %3 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %1, i32 %2)
  %4 = extractvalue { i32, i1 } %3, 0
  store i32 %4, i32* %0
  %5 = extractvalue { i32, i1 } %3, 1
  ret i1 %5
}

declare { i32, i1 } @llvm.sadd.with.overflow.i32(i32, i32) nounwind readnone
