//
//  MiniPrinterFunctions.h
//  GreenBeansMerch
//
//  Created by Burchfield, Neil on 1/12/13.
//  Copyright (c) 2013 Burchfield, Neil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrinterFunctions.h"
#import "StarIO/SMPort.h"

typedef enum {
    BarcodeWidth_125 = 0,
    BarcodeWidth_250 = 1,
    BarcodeWidth_375 = 2,
    BarcodeWidth_500 = 3,
    BarcodeWidth_625 = 4,
    BarcodeWidth_750 = 5,
    BarcodeWidth_875 = 6,
    BarcodeWidth_1_0 = 7
} BarcodeWidth;

typedef enum{
    BarcodeType_code39 = 0,
    BarcodeType_code93 = 1,
    BarcodeType_ITF = 2,
    BarcodeType_code128 = 3
}BarcodeType;

@interface MiniPrinterFunctions : NSObject {
    SMPort *starPort;
}

+ (void)PrintPDF417WithPortname:(NSString*)portName
                   portSettings:(NSString*)portSettings
                          width:(BarcodeWidth)width
                   columnNumber:(unsigned char)columnNumber
                  securityLevel:(unsigned char)securityLevel
                          ratio:(unsigned char)ratio
                    barcodeData:(unsigned char*)barcodeData
                barcodeDataSize:(unsigned char)barcodeDataSize;

+ (BOOL)PrintBitmapWithPortName:(NSString*)portName
                   portSettings:(NSString*)portSettings
                    imageSource:(UIImage*)source
                   printerWidth:(int)maxWidth;

+ (void)PrintText:(NSString*)portName
            PortSettings:(NSString*)portSettings
               Underline:(bool)underline
              Emphasized:(bool)emphasized
             Upsideddown:(bool)upsideddown
             InvertColor:(bool)invertColor
         HeightExpansion:(unsigned char)heightExpansion
          WidthExpansion:(unsigned char)widthExpansion
              LeftMargin:(int)leftMargin
               Alignment:(Alignment)alignment
             TextToPrint:(unsigned char*)textToPrint
                TextToPrintSize:(unsigned int)textToPrintSize;

@end
