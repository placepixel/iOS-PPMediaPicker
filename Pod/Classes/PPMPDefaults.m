//
//  PPMPDefaults.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPDefaults.h"
#import "PPMPDefaultUISetupObject.h"
@implementation PPMPDefaults
static  PPMPDefaults *  instance;

@synthesize defaultCameraPostion=_defaultCameraPostion;
+(instancetype)sharedInstance{
 
    if (!instance) {
        instance=[[self alloc] init];
    }
    return instance;
    
}
+(id<PPMPUISetupObjectProt>)uiObject{
    
    
    return [[self sharedInstance] uiObject];
}

-(instancetype)init{
    if (self=[super init]) {
        
        self.capturingTime=15.0;
        [self setDefaultFlashMode:[[[NSUserDefaults standardUserDefaults] valueForKey:@"ppmp_defaultFlashMode"]integerValue] ];
    }
    return self;
}

-(id<PPMPUISetupObjectProt>)uiObject{
    if (!_uiObject) {
        _uiObject=[[PPMPDefaultUISetupObject alloc] init];
    }
    return _uiObject;
}


#pragma mark - camera
#pragma mark position
-(AVCaptureDevicePosition)defaultCameraPostion{
    
    if (_defaultCameraPostion==AVCaptureDevicePositionUnspecified) {
        
        _defaultCameraPostion=[[[NSUserDefaults standardUserDefaults] valueForKey:@"ppmp_defaultCameraPostion"] integerValue];
        
        if (_defaultCameraPostion==0) {
            [self setDefaultCameraPostion:AVCaptureDevicePositionBack];
        }
    }
    return _defaultCameraPostion;
}
-(void)setDefaultCameraPostion:(AVCaptureDevicePosition)defaultCameraPostion{
    _defaultCameraPostion=defaultCameraPostion;
    [[NSUserDefaults standardUserDefaults] setValue:@(defaultCameraPostion) forKey:@"ppmp_defaultCameraPostion"];
    
}
#pragma mark flash
-(void)setDefaultFlashMode:(AVCaptureFlashMode)defaultFlashMode{
    _defaultFlashMode=defaultFlashMode;
        [[NSUserDefaults standardUserDefaults] setValue:@(defaultFlashMode) forKey:@"ppmp_defaultFlashMode"];
}
@end
