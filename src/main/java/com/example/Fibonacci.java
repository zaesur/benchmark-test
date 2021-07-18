package com.example;

public class Fibonacci {
    public static int fibonacci(int n) {
        int prev = 0, curr = 1, hold;
        if (n == 0) {
            return prev;
        }
        for (int i = 2; i <= n; i++) {
            hold = prev + curr;
            prev = curr;
            curr = hold;
        }
        return curr;
    }
}