public class Calculator {

    public static void main(String[] args) {
        int result = divide(10, 0); // ⚠️ Logical error: division by zero
        System.out.println("Result: " + result);
        
        int sum = add("5", 3); // ⚠️ Semantic error: passing string to int
        System.out.println("Sum: " + sum);
    }

    public static int divide(int a, int b) {
        return a / b; // ⚠️ Runtime error when b == 0
    }

    public static int add(int a, int b) {
        return a + b;
    }
}

