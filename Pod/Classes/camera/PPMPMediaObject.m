//
//  PPMPCameraResopnse.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPMediaObject.h"

@implementation PPMPMediaObject
+(instancetype)createWithType:(PPMPCameraResponseMediaType)type andFilePath:(NSString *)filePath{
    
    PPMPMediaObject * r =[[self alloc] init];
    r.mediaType=type;
    r.filePath=filePath;
    
    return r;
    
}
@end
