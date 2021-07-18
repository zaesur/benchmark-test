package com.example;
import org.openjdk.jmh.annotations.*;

@State(Scope.Benchmark)
@BenchmarkMode(Mode.SingleShotTime) 
public class FibonacciBenchmark {
    @Param({ "15", "20", "25" })
    public int i;

    @Benchmark
    public int testFibonacci() throws Exception {
        return Fibonacci.fibonacci(i);
    }
}
