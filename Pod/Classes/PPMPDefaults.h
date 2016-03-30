//
//  PPMPDefaults.h
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "PPMPUISetupObjectProt.h"
@interface PPMPDefaults : NSObject
+(instancetype)sharedInstance;
@property (nonatomic)NSInteger capturingTime;

@property (nonatomic)AVCaptureDevicePosition defaultCameraPostion;
@property (nonatomic)AVCaptureFlashMode defaultFlashMode;


///////camera ui

+(id<PPMPUISetupObjectProt>)uiObject;

@property (nonatomic,retain)id<PPMPUISetupObjectProt> uiObject;

@end
