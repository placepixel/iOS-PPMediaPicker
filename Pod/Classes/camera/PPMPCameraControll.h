//
//  PPMPCameraControll.h
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PPMPCameraShutterView.h"
#import "PPMPMediaObject.h"
@class PPMPCameraControll;
@protocol PPMPCameraControllControllDelegate <NSObject>
-(void)cameraControll:(PPMPCameraControll*)cameraControll didFinishWorkWithResponse:(PPMPMediaObject*)response;

-(void)cameraControllWillCaptureImage;
-(void)cameraControllDidCaptureImage:(UIImage*)image;

-(void)cameraControllWillStartCapturingVideo;
-(void)cameraControllDidStartCapturingVideo;
-(void)cameraControllUpdateVideoCapturingTimer:(float)newTime;
-(void)cameraControllWillFinishCapturingVideo;
-(void)cameraControllDidFinishCapturingVideo;

//-(void)didFinishWithMediaObject:(SAMediaObject*)mediaObject;


@end
@interface PPMPCameraControll : NSObject <PPMPCammeraShutterViewDelegate>



@property (nonatomic,retain)AVCaptureVideoPreviewLayer * previewLayer;
-(void)startWorkingAnimated:(BOOL )animated withComplitBlock:(void(^)())complitBlock;
-(void)stopWorking:(BOOL )animated withComplitBlock:(void(^)())complitBlock;


@property (weak,nonatomic)id<PPMPCameraControllControllDelegate> delegate;

@property (nonatomic)BOOL processing;
@property (nonatomic)BOOL recording;
-(AVCaptureFlashMode)onFlash;
-(void)onSwitch;

-(void)focus:(CGPoint)p;
@property (strong, nonatomic) AVCaptureDevice *captureDevice;


@property (nonatomic)float currentCaptureTime;
@property (nonatomic)NSInteger totalVideoTime;
@end
