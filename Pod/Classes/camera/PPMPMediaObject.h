//
//  PPMPCameraResopnse.h
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,PPMPCameraResponseMediaType) {
    
    PPMPCameraResponseMediaTypeImage,
   PPMPCameraResponseMediaTypeVideo
    
};

@interface PPMPMediaObject : NSObject

+(instancetype)createWithType:(PPMPCameraResponseMediaType)type andFilePath:(NSString*)filePath;

@property (nonatomic)PPMPCameraResponseMediaType mediaType;
@property (nonatomic,retain)NSString * filePath;
@property (nonatomic,retain)id item;
@end
