#include <stdio.h>

int main()
{
    int a, b, i, n;
    a = 0;
    b = 1;
    i = 1;

    printf("Please input the number of Fibonacci: ");
    scanf("%d", &n);

    while (i < n)
    {
        int t = b;
        b = a + b;
        printf("fibonacci: %d\n", b);
        a = t;
        i = i + 1;
    }


    return 0;
}
