//mike neis
// 22/6/18
//tiny program for use in the VST


int myId(int x)
{
    return x;
}

int main(void)
{
    int condition = 1;
    int result = 0;

    if( condition ) {
        result = 1;
    }
    else {
        result = -1;
    }
    
    return ( myId( result ) );
}

