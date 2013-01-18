//
//  Bitmap.m
//  IOPhoneTest
//
//  Created by sdtpig on 8/25/09.
//  Copyright 2009 starmicronics. All rights reserved.
//

#import "StarBitmap.h"
#import <math.h>

@implementation StarBitmap

CGContextRef CreateARGBBitmapContext(CGImageRef inImage);

void ManipulateImagePixelData(CGImageRef inImage, void *imageData){
    // Create the bitmap context
    CGContextRef cgctx = CreateARGBBitmapContext(inImage);
    if (cgctx == NULL) {
        // error creating context
        return;
    }

    // Get image width, height. We'll use the entire image.
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = { { 0, 0 }, { w, h } };

    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    CGContextDrawImage(cgctx, rect, inImage);

    // Now we can get a pointer to the image data associated with the bitmap
    // context.
    void *data = CGBitmapContextGetData(cgctx);
    if (data != NULL) {
        CGContextRelease(cgctx);
        memcpy(imageData, data, w * h * sizeof(u_int8_t) * 4);
        free(data);
        return;

    }

    // When finished, release the context
    CGContextRelease(cgctx);
    // Free image data memory for the context
    if (data) {
        free(data);
    }
    return;
} /* ManipulateImagePixelData */


CGContextRef CreateARGBBitmapContext(CGImageRef inImage){
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    void *bitmapData;
    int bitmapByteCount;
    int bitmapBytesPerRow;

    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);

    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);

    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL) {
        return NULL;
    }

    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc(bitmapByteCount);
    if (bitmapData == NULL) {
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }

    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate(bitmapData,
                                    pixelsWide,
                                    pixelsHigh,
                                    8,                                           // bits per component
                                    bitmapBytesPerRow,
                                    colorSpace,
                                    kCGImageAlphaPremultipliedFirst);
    if (context == NULL) {
        free(bitmapData);
    }

    // Make sure and release colorspace before returning
    CGColorSpaceRelease(colorSpace);

    return context;
} /* CreateARGBBitmapContext */


u_int8_t PixelBrightness(u_int8_t red, u_int8_t green, u_int8_t blue){
    int level = ((int)red + (int)green + (int)blue) / 3;
    return level;
} /* PixelBrightness */


u_int32_t PixelIndex(u_int32_t x, u_int32_t y, u_int32_t width){
    return (x + (y * width));
} /* PixelIndex */


UIImage * ScaleImage(UIImage *image, int32_t width, int32_t height){
    CGSize size;
    size.width = width;
    size.height = height;
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
} /* ScaleImage */


u_int8_t GetGreyLevel(ARGBPixel source, float intensity){
    if (source.alpha == 0) {
        return 255;
    }

    int32_t gray = (int)(((source.red + source.green +  source.blue) / 3) * intensity);

    if (gray > 255)
        gray = 255;

    return (u_int8_t)gray;
} /* GetGreyLevel */


void ConvertToMonochromeSteinbertDithering(ARGBPixel *image, int32_t width, int32_t height, float intensity){
    int32_t **levelMap = malloc(sizeof(int32_t *) * width);
    for (int index = 0; index < width; index++) {
        levelMap[index] = malloc(sizeof(int32_t) * height);
        memset(levelMap[index], 0, sizeof(int32_t) * height);
    }
    for (int y = 0; y < height; y++) {
        if ((y & 1) == 0) {
            for (int x = 0; x < width; x++) {
                int32_t pixelIndex = PixelIndex(x, y, width);
                ARGBPixel pixel = image[pixelIndex];
                levelMap[x][y] += 255 - GetGreyLevel(pixel, intensity);

                if (levelMap[x][y] >= 255) {
                    levelMap[x][y] -= 255;
                    image[pixelIndex].red = 0;
                    image[pixelIndex].green = 0;
                    image[pixelIndex].blue = 0;
                } else {
                    image[pixelIndex].red = 255;
                    image[pixelIndex].green = 255;
                    image[pixelIndex].blue = 255;
                }

                int32_t sixteenthOfQuantError = levelMap[x][y] / 16;

                if (x < width - 1)
                    levelMap[x + 1][y] += sixteenthOfQuantError * 7;

                if (y < height - 1) {
                    levelMap[x][y + 1] += sixteenthOfQuantError * 5;

                    if (x > 0)
                        levelMap[x - 1][y + 1] += sixteenthOfQuantError * 3;

                    if (x < width - 1)
                        levelMap[x + 1][y + 1] += sixteenthOfQuantError;
                }
            }
        } else {
            for (int x = width - 1; x >= 0; x--) {
                int32_t pixelIndex = PixelIndex(x, y, width);
                ARGBPixel pixel = image[pixelIndex];

                levelMap[x][y] += 255 - GetGreyLevel(pixel, intensity);

                if (levelMap[x][y] >= 255) {
                    levelMap[x][y] -= 255;
                    image[pixelIndex].red = 0;
                    image[pixelIndex].green = 0;
                    image[pixelIndex].blue = 0;
                } else {
                    image[pixelIndex].red = 255;
                    image[pixelIndex].green = 255;
                    image[pixelIndex].blue = 255;
                }

                int32_t sixteenthOfQuantError = levelMap[x][y] / 16;

                if (x > 0)
                    levelMap[x - 1][y] += sixteenthOfQuantError * 7;

                if (y < height - 1) {
                    levelMap[x][y + 1] += sixteenthOfQuantError * 5;

                    if (x < width - 1)
                        levelMap[x + 1][y + 1] += sixteenthOfQuantError * 3;

                    if (x > 0)
                        levelMap[x - 1][y + 1] += sixteenthOfQuantError;
                }
            }
        }
    }

    for (int index = 0; index < width; index++) {
        free(levelMap[index]);
    }
    free(levelMap);
} /* ConvertToMonochromeSteinbertDithering */


- (id) initWithUIImage :(UIImage *)image :(int)maxWidth :(bool)dithering;
{
    int32_t width = image.size.width;     // CGImageGetWidth([image CGImage]);
    int32_t height = image.size.height;     // CGImageGetHeight([image CGImage]);
    int32_t h2 = 0;
    if (width > maxWidth) {
        h2 = (int)(((double)height * (float)maxWidth) / (double)width);       // SCALLING IMAGE DOWN TO FIT ON PAPER IF TOO BIG
        m_image =  ScaleImage(image, maxWidth, h2);
    } else {
        m_image = image;
    }
    imageData = nil;
    ditheringSupported = dithering;
    return self;
}

- (NSData *) getImageDataForPrinting {
    if (imageData != nil) {
        return imageData;
    }
    CGImageRef cgImage = [m_image CGImage];
    int32_t width = CGImageGetWidth(cgImage);
    int32_t height = CGImageGetHeight(cgImage);

    ARGBPixel *pixels = malloc(width * height * sizeof(ARGBPixel));
    ManipulateImagePixelData(cgImage, pixels);

    // Converts the image to a Monochrome image using a Steinbert Dithering algorithm.  This call can be removed but it that will also remove any dithering.
    if (ditheringSupported == true) {
        ConvertToMonochromeSteinbertDithering(pixels, width, height, 1.5);
    }
    if (pixels == NULL) {
        return NULL;
    }


    int32_t mWidth =  width / 8;
    if ((width % 8) != 0) {
        mWidth++;
    }

    NSMutableData *data = [[NSMutableData alloc] init];

    // The real algorithm for converting an image to star data is below
    for (int y = 0; y < height; y++) {
        int32_t longWidth = mWidth / 256;
        int32_t shortWidth = mWidth % 256;

        u_int8_t startingBytes[] = { 'b', shortWidth, longWidth };

        [data appendBytes:startingBytes length:3];


        for (int x = 0; x < mWidth; x++) {
            u_int8_t constructedByte = 0;

            for (int j = 0; j < 8; j++) {
                constructedByte = constructedByte << 1;

                ARGBPixel pixel;
                int widthPixel = (x * 8) + j;
                if (widthPixel < width) {
                    pixel = pixels[PixelIndex(widthPixel, y, width)];
                } else {
                    pixel.red = 255;
                    pixel.green = 255;
                    pixel.blue = 255;
                }

                if (PixelBrightness(pixel.red, pixel.green, pixel.blue) < 127) {
                    constructedByte = constructedByte | 1;
                }


            }
            [data appendBytes:&constructedByte length:1];
        }
    }
    free(pixels);

    imageData = [[NSData alloc] initWithBytes:[data mutableBytes] length:[data length]];

    return imageData;

} /* getImageDataForPrinting */


- (NSData *) getImageImpactPrinterForPrinting {
    if (imageData != nil) {
        return imageData;
    }

    CGImageRef cgImage = [m_image CGImage];
    int32_t width = CGImageGetWidth(cgImage);
    int32_t height = CGImageGetHeight(cgImage);

    ARGBPixel *pixels = malloc(width * height * sizeof(ARGBPixel));
    ManipulateImagePixelData(cgImage, pixels);
    if (ditheringSupported == true) {
        ConvertToMonochromeSteinbertDithering(pixels, width, height, 1.5);
    }

    if (pixels == NULL) {
        return NULL;
    }

    int mHeight = height / 8;
    if ((height % 8) != 0) {
        mHeight++;
    }

    NSMutableData *data = [[NSMutableData alloc] init];
    int heightLocation = 0;
    int bitLocation = 0;
    u_int8_t nextByte = 0;

    int cwidth = width;
    if (cwidth > 199) {
        cwidth = 199;
    }

    u_int8_t cancelColor[] = { 0x1b, 0x1e, 'C', 48 };
    [data appendBytes:cancelColor length:4];

    for (int x = 0; x < mHeight; x++) {
        u_int8_t imageCommand[] = { 0x1b, 'K', cwidth, 0 };
        [data appendBytes:imageCommand length:4];

        for (int w = 0; w < cwidth; w++) {
            for (int j = 0; j < 8; j++) {
                ARGBPixel pixel;
                if (j + (heightLocation * 8) < height) {
                    pixel =  pixels[PixelIndex(w, j + (heightLocation * 8), width)];
                } else {
                    pixel.red = 255;
                    pixel.green = 255;
                    pixel.blue = 255;
                }
                if (PixelBrightness(pixel.red, pixel.green, pixel.blue) < 127) {
                    nextByte = nextByte | (1 << (7 - bitLocation));
                }
                bitLocation++;
                if (bitLocation == 8) {
                    bitLocation = 0;
                    [data appendBytes:&nextByte length:1];
                    nextByte = 0;
                }

            }
        }
        heightLocation++;
        u_int8_t lineFeed[] = { 0x1b, 0x49, 0x10 };
        [data appendBytes:lineFeed length:3];
    }

    free(pixels);

    imageData = [[NSData alloc] initWithBytes:[data mutableBytes] length:[data length]];
    return imageData;
} /* getImageImpactPrinterForPrinting */


- (NSData *) getImageEscPosDataForPrinting {
    if (imageData != nil) {
        return imageData;
    }

    CGImageRef cgImage = [m_image CGImage];
    int32_t width = CGImageGetWidth(cgImage);
    int32_t height = CGImageGetHeight(cgImage);

    ARGBPixel *pixels = malloc(width * height * sizeof(ARGBPixel));
    ManipulateImagePixelData(cgImage, pixels);

    if (ditheringSupported == true) {
        ConvertToMonochromeSteinbertDithering(pixels, width, height, 1.5);
    }

    if (pixels == NULL) {
        return NULL;
    }

    int w = width / 8;
    if ((width % 8) != 0)
        w++;
    int mWidth = w * 8;

    uint idx = 0;
    // int pixelSize = 3;
    int byteWidth = mWidth / 8;
    // u_int8_t n1 = (u_int8_t)(byteWidth % 256);
    // u_int8_t n2 = (u_int8_t)(byteWidth / 256);

    u_int8_t *data;
    NSMutableData *someData = [[NSMutableData alloc] init];

    u_int8_t beginingBytes[] = { 0x1b,         0x40,
                                 0x1b,         0x4c,
                                 0x1b,         0x57,
                                 0x00,         0x00,        0x00,                 0x00,
//                              mWidth % 256, mWidth / 256,  height       % 256,  height       / 256,
                                 mWidth % 256, mWidth / 256,(height + 50) % 256,  (height + 50) / 256,
                                 0x1b,         0x58,        0x32,                 0x18 };
    [someData appendBytes:beginingBytes length:2 + 2 + 10 + 4];
    int totalRowCount = 0;

    for (int z = 0; z < (height - (height % 24)) / 24; z++) {
        u_int8_t imagestarting[] = { 0x1b, 0x58, 0x34, 0, 24 };
        imagestarting[3] = byteWidth;
        [someData appendBytes:imagestarting length:5];
        idx = 0;
        data = malloc(sizeof(u_int8_t) * byteWidth * 24);
        memset(data, 0, sizeof(u_int8_t) * byteWidth * 24);

        for (int y = 0; y < 24; y++) {
            for (int x = 0; x < byteWidth; x++) {
                int bits = 8;
                if ((x == (byteWidth - 1)) && (width < mWidth))
                    bits = 8 - (mWidth - width);

                // int xoffset = x * 8;
                for (int xbit = 0; xbit < bits; xbit++) {

                    ARGBPixel pixel = pixels[PixelIndex(x * 8 + xbit, totalRowCount, width)];
                    if (PixelBrightness(pixel.red, pixel.green, pixel.blue) < 127)
                        data[idx] |= (u_int8_t)(0x01 << (7 - xbit));
                }
                idx++;
            }
            totalRowCount++;
        }
        [someData appendBytes:data length:sizeof(u_int8_t) * byteWidth * 24];
        u_int8_t imageData2[] = { 0x1b, 0x58, 0x32, 0x18 };
        [someData appendBytes:imageData2 length:4];
        free(data);
    }

    if (height % 24 > 0) {
        u_int8_t imageData3[] = { 0x1b, 0x58, 0x34, 0, 0 };
        imageData3[3] = byteWidth;
        imageData3[4] = 24;
        [someData appendBytes:imageData3 length:5];
        int idx = 0;
        data = malloc(sizeof(u_int8_t) * byteWidth * 24);
        memset(data, 0, sizeof(u_int8_t) * byteWidth * 24);
        for (int y = 0; y < 24; y++) {
            for (int x = 0; x < byteWidth; x++) {
                int bits = 8;
                if ((x == (byteWidth - 1)) && (width < mWidth))
                    bits = 8 - (mWidth - width);

                // int xoffset = x * 8;
                for (int xbit = 0; xbit < bits; xbit++) {
                    ARGBPixel pixel;
                    if (totalRowCount < height) {
                        pixel = pixels[PixelIndex(xbit + x * 8, totalRowCount, width)];
                    } else {
                        pixel.alpha = 255;
                        pixel.blue = 255;
                        pixel.green = 255;
                        pixel.red = 255;
                    }

                    if (PixelBrightness(pixel.red, pixel.green, pixel.blue) < 127)
                        data[idx] |= (u_int8_t)(0x01 << (7 - xbit));
                }
                idx++;
            }
            totalRowCount++;
        }
        [someData appendBytes:data length:sizeof(u_int8_t) * byteWidth * 24];

        u_int8_t imageData4[] = { 0x1b, 0x58, 0x32, 0x18 };
        [someData appendBytes:imageData4 length:4];
        free(data);
    }

    u_int8_t imageData5[] = { 0x0c, 0x1b, 0x4A, 0x78 };
    [someData appendBytes:imageData5 length:1 + 3];

    free(pixels);

    imageData = [[NSData alloc] initWithBytes:[someData mutableBytes] length:[someData length]];
    return imageData;
} /* getImageEscPosDataForPrinting */


@end
