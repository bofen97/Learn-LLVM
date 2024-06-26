### Learn LLVM

This repo records the development of the [Kaleidoscope](https://llvm.org/docs/tutorial/index.html) language using llvm 17.1,Use **cmake** and **ninja** to compile. When I was learning llvm, I encountered the problem that the llvm versions used in the reading materials spanned a long time. I was wondering if I could rewrite some things if I only used llvm17.1. Lines of code marked "[bug]" in the code file represent spelling errors that occurred in the Kaleidoscope tutorial.

#### Install LLVM 17.1
TODO

#### Run
```bash
cd Learn-LLVM
chmod +x run.sh
./run.sh
```
##### ch8 completed
There are some differences from the original Chapter 8 code. I only generated native code x86-64, retained the JIT's evaluation of top-level expressions, continued to use the JIT's layout, and commented out the HandleDefinition JIT part to generate the obj file.After getting output.obj, you can compile main.cpp with g++ or clang++ and link output.obj to generate an executable file.

```
ready> 1+1;
ready> Evaluated to 2.000000
ready> def average(x y) (x + y) * 0.5;
ready> Read function definition:define double @average(double %x, double %y) {
entry:
  %addtmp = fadd double %x, %y
  %multmp = fmul double %addtmp, 5.000000e-01
  ret double %multmp
}

ready> ready> %                                                        
Learn-LLVM % objdump -t build/output.o 

build/output.o:     file format mach-o-x86-64

SYMBOL TABLE:
0000000000000000 g       0f SECT   01 0000 [.text] _average


Learn-LLVM % g++ main.cpp ./build/output.o -o main && ./main
average of 3.0 and 4.0: 3.5
```


##### ch7 completed
```
ready> extern printd(x);
ready> Read extern: declare double @printd(double)

ready> def binary : 1 (x y) y;
ready> Read function definition:define double @"binary:"(double %x, double %y) {
entry:
  ret double %y
}

ready> def test(x) printd(x) : x =4 : printd(x);
ready> Read function definition:define double @test(double %x) {
entry:
  %calltmp = call double @printd(double %x)
  %binop = call double @"binary:"(double %calltmp, double 4.000000e+00)
  %calltmp4 = call double @printd(double 4.000000e+00)
  %binop5 = call double @"binary:"(double %binop, double %calltmp4)
  ret double %binop5
}

ready> test(123);
ready> 123.000000
4.000000
Evaluated to 0.000000
ready> 
```
##### ch5 completed
```
ready> extern putchard(char);
def printstar(n)
  for i = ready> Read extern: declare double @putchard(double)

ready> ready> 1, i < n, 1.0 in
    putchard(42);
Read function definition:define double @printstar(double %n) {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %i = phi double [ 1.000000e+00, %entry ], [ %nextvar, %loop ]
  %calltmp = call double @putchard(double 4.200000e+01)
  %nextvar = fadd double %i, 1.000000e+00
  %cmptmp = fcmp ult double %i, %n
  br i1 %cmptmp, label %loop, label %afterloop

afterloop:                                        ; preds = %loop
  ret double 0.000000e+00
}

ready> printstar(100);
ready> ****************************************************************************************************Evaluated to 0.000000
ready> 
```

##### ch4 outputs (Duplication of symbols in separate modules is not allowed since LLVM-9.)
```
Found LLVM 17.0.1, build type Release
-- Configuring done (0.2s)
-- Generating done (0.0s)
-- Build files have been written to: /Users/bofeng/Learn-LLVM/build
[1/1] Linking CXX executable toy
ready> extern sin(x);
ready> Read extern: declare double @sin(double)

ready> extern cos(x);
ready> Read extern: declare double @cos(double)

ready> sin(1.0);
ready> Evaluated to 0.841471
ready> cos(1.0);
ready> Evaluated to 0.540302
ready> def foo(x) sin(x)*sin(x) + cos(x)*cos(x);
ready> Read function definition:define double @foo(double %x) {
entry:
  %calltmp = call double @sin(double %x)
  %calltmp1 = call double @sin(double %x)
  %multmp = fmul double %calltmp, %calltmp1
  %calltmp2 = call double @cos(double %x)
  %calltmp3 = call double @cos(double %x)
  %multmp4 = fmul double %calltmp2, %calltmp3
  %addtmp = fadd double %multmp, %multmp4
  ret double %addtmp
}

ready> foo(4.0);
ready> Evaluated to 1.000000
ready> extern printd(x);
ready> Read extern: declare double @printd(double)

ready> printd(1);
ready> 1.000000
Evaluated to 0.000000
ready> 
```
##### ch3 outputs（Ch3 has been completed and there are no APIs that need to be modified. A spelling error was found.）
```
ready> def foo(a b) a*a + 2*a*b + b*b;
ready> Read function definition:define double @foo(double %a, double %b) {
entry:
  %multmp = fmul double %a, %a
  %multmp1 = fmul double 2.000000e+00, %a
  %multmp2 = fmul double %multmp1, %b
  %addtmp = fadd double %multmp, %multmp2
  %multmp3 = fmul double %b, %b
  %addtmp4 = fadd double %addtmp, %multmp3
  ret double %addtmp4
}

ready> def bar(a) foo(a, 4.0) + bar(31337);
ready> Read function definition:define double @bar(double %a) {
entry:
  %calltmp = call double @foo(double %a, double 4.000000e+00)
  %calltmp1 = call double @bar(double 3.133700e+04)
  %addtmp = fadd double %calltmp, %calltmp1
  ret double %addtmp
}

ready> extern cos(x);
ready> Read extern: declare double @cos(double)

ready> cos(1.234);
ready> Read top-level expression:define double @__anon_expr() {
entry:
  %calltmp = call double @cos(double 1.234000e+00)
  ret double %calltmp
}

ready> ready> ; ModuleID = 'my cool jit'
source_filename = "my cool jit"

define double @foo(double %a, double %b) {
entry:
  %multmp = fmul double %a, %a
  %multmp1 = fmul double 2.000000e+00, %a
  %multmp2 = fmul double %multmp1, %b
  %addtmp = fadd double %multmp, %multmp2
  %multmp3 = fmul double %b, %b
  %addtmp4 = fadd double %addtmp, %multmp3
  ret double %addtmp4
}

define double @bar(double %a) {
entry:
  %calltmp = call double @foo(double %a, double 4.000000e+00)
  %calltmp1 = call double @bar(double 3.133700e+04)
  %addtmp = fadd double %calltmp, %calltmp1
  ret double %addtmp
}

declare double @cos(double)
```