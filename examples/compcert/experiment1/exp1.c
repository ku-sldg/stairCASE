//mike neis
// 22/6/18
//tiny program for use in the VST

const int mySum(int x, int y)
{
    const int z = x + y;
    return z;
}

int main(void)
{
    const int A = 2;
    const int B = 3;
    const int C = mySum( A, B );
    return C;
}
