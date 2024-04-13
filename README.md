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