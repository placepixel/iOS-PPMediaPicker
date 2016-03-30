//
//  PPMPCameraHelper.h
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PPMPCameraHelper : NSObject
+ (BOOL)saveImageToJPGFile:(UIImage *)image path:(NSString *)filePath;
+ (NSString *)getDocumentPath;
+ (UIImage *)scaleAndRotateImage:(UIImage *)image resolution:(int)resolution;

+ (UIImage *)makeSquareImage:(UIImage *)image;
@end
