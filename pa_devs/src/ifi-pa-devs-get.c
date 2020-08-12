#include <stdio.h>
#include <math.h>
#include <portaudio.h>

/*******************************************************************/
int main(void);
int main(void)
{
    int     i, numDevices;
    const   PaDeviceInfo *deviceInfo;
    PaError err;

    err = Pa_Initialize();
    if( err != paNoError )
    {
        printf( "ERROR: Pa_Initialize returned 0x%x\n", err );
        goto error;
    }
    numDevices = Pa_GetDeviceCount();
    if( numDevices < 0 )
    {
        printf( "ERROR: Pa_GetDeviceCount returned 0x%x\n", numDevices );
        err = numDevices;
        goto error;
    }
    
    for( i=0; i<numDevices; i++ )
    {
        deviceInfo = Pa_GetDeviceInfo( i );
        printf( "device#%d=%s\n", i, deviceInfo->name );
    }
    printf( "Number of devices = %d\n", numDevices );

    Pa_Terminate();

    return 0;

error:
    Pa_Terminate();
    fprintf( stderr, "Error number: %d\n", err );
    fprintf( stderr, "Error message: %s\n", Pa_GetErrorText( err ) );
    return err;
}

