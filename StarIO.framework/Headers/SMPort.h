//
//  Port.h
//  StarIOPort
//
//  Created by sdtpig on 8/11/09.
//  Copyright 2009 starmicronics. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef TARGET_OS_IPHONE
    #ifdef BUILDING_STARIO
        #include <starmicronics/StarIOPort.h>
    #else
        #include <StarIO/starmicronics/StarIOPort.h>

    #endif
#else
    #include <starmicronics/StarIOPort.h>
#endif

#import "WBluetoothPort.h"

@interface PortException : NSException
{
	
}

@end

@interface PortInfo : NSObject {
    NSString *portName;
    NSString *macAddress;
    NSString *modelName;
}

- (id)initWithPortName:(NSString *)portName_ macAddress:(NSString *)macAddress_ modelName:(NSString *)modelName_;

@property(readonly) NSString *portName;
@property(readonly) NSString *macAddress;
@property(readonly) NSString *modelName;
@property(readonly, getter=isConnected) BOOL connected;
@end

@interface SMPort : NSObject {
	void * m_port;
    WBluetoothPort* wBluetoothPort;
	NSString * m_portName;
	NSString * m_portSettings;
	int m_ioTimeoutMillis;
}

+ (NSArray *)searchPrinter;

+ (SMPort *)getPort: (NSString *) portName : (NSString *) portSettings : (u_int32_t) ioTimeoutMillis;
/*
 Parameters: portName         -string taking the following form
 "tcp:nnn.nnn.nnn.nnn" which opens the network printer at the specified IP address (i.e. '192.168.11.3')
 portSettings     -this should be an empty string (i.e. "")
 ioTimeoutMillis  -this is the time out for trying to get the port in milliseconds.  
 */

/*
 ClosePort
 --------
 This function closes a connection to the port specified.
 
 Parameters: port - pointer to a previously created port
 */
+ (void)releasePort: (SMPort *) port;

- (id)init:(NSString *)portName :(NSString *)portSettings :(u_int32_t)ioTimeoutMillis;

- (void)dealloc;

/*
 WritePort
 --------
 This function writes data to the device.
 
 Parameters: writeBuffer      - pointer to a byte buffer containing the write data
             offset           - amount of data that was already written
             size             - amount of data left to write
             Returns:         Amount of data written
 
             Notes:           throws PortException on failure
 */

- (u_int32_t)writePort: (u_int8_t const *) writeBuffer: (u_int32_t)offSet: (u_int32_t)size;

/*
 ReadPort
 --------
 This function reads data from the device.
 
 Parameters: readBuffer       - pointer to a byte buffer into which data is read
             offSet           - size in bytes to read
             sizeCommunicated - amount of data to be write to the buffer
 Returns:    Aount of data written to the buffer
 Notes:      throws PortException on failure
 */
- (u_int32_t)readPort: (u_int8_t *) readBuffer: (u_int32_t) offSet: (u_int32_t)size;

/*
 GetParsedStatus
 --------
 This function retreives the device's detailed status.
 
 Parameters: starPrinterStatus - pointer to a StarPrinterStatus_n structure where the devices detailed status is written (either StarPrinterStatus_0, StarPrinterStatus_1, or StarPrinterStatus_2)
			level             - integer designating the level of status structure (either 0, 1, or 2)
 Returns:    none
 Notes:      throws PortException on failure 
 */
- (void)getParsedStatus: (void *)starPrinterStatus: (u_int32_t)level;

/*
 GetOnlineStatus
 --------
 This function retreives the device's online status.
 
 Parameters: none
 Returns:    SM_FALSE printer is offline
 or
             SM_TRUE printer is offline
 Notes:      throws PortException on failure 
*/
- (bool)getOnlineStatus;

/*
 BeginCheckedBlock
 --------
 This function initiates a checked block printing operation and returns the devices detailed status.
 
 Parameters: starPrinterStatus - pointer to a StarPrinterStatus_n structure where the devices detailed status is written (either StarPrinterStatus_0, StarPrinterStatus_1, or StarPrinterStatus_2)
			level             - integer designating the level of status structure (either 0, 1, or 2)
 Returns:    none
 Notes:      throws PortException on failure
 */
- (void)beginCheckedBlock: (void *)starPrinterStatus: (u_int32_t)level;

/*
 EndCheckedBlock
 --------
 This function ends a checked block printing operation and returns the devices detailed status.
 This function does not return until either the printer has successfully printed all data or has gone offline in error.
 If the starPrinterStatus_2 structure indicates that the printer is online upon return than all data was successfully printed.
 
 Parameters: starPrinterStatus - pointer to a StarPrinterStatus_n structure where the devices detailed status is written (either StarPrinterStatus_0, StarPrinterStatus_1, or StarPrinterStatus_2)
			level             - integer designating the level of status structure (either 0, 1, or 2)
 Returns:    none
 Notes:      throws PortException on failure
 */
- (void)endCheckedBlock: (void *)starPrinterStatus: (u_int32_t)level;


- (NSString *)portName;
- (NSString *)portSettings;
- (u_int32_t)timeoutMillis;
- (BOOL)connected;

@end
