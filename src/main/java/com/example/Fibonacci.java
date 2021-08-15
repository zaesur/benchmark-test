package com.example;

public class Fibonacci {
    private static int[] memo = new int[30];

    public static int fibonacci(int n) {
        if (n <= 1) {
            return n;
        } else if (memo[n] != 0) {
            return memo[n];
        } else {
            int f = fibonacci(n-1) + fibonacci(n-2);
            memo[n] = f;
            return f;
        }
    }
}