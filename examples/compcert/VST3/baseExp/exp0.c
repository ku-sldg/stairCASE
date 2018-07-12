//mike neis
// 11/7/18
//tiny program for use in the VST

int fac(int x)
{
    if( x==1 )
    {
        return 1;
    }
    else
    {
        return x * fac( x-1 );
    }
}

int main(void)
{
    int result = 3;
    return ( fac( result ) );
}

