//
//  PPMPCameraControll.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPDefaults.h"

#import "PPMPCameraControll.h"
#import <ImageIO/ImageIO.h>
#import <CoreMedia/CoreMedia.h>
#import "PPMPCameraHelper.h"
#define IMAGE_FILE @"image.jpg"
#define MOVIE_FILE @"movie.mov"

#define kDefaultMinZoomFactor 1
#define kDefaultMaxZoomFactor 4
@interface PPMPCameraControll ()<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic,getter=isRunning)BOOL running;

@property(nonatomic,strong) AVCaptureSession *captureSession;

@property (strong, nonatomic) AVCaptureDeviceInput *deviceInput;
@property(nonatomic,strong) AVCaptureStillImageOutput *imageOutput;
@property (strong, nonatomic) AVCaptureMovieFileOutput *movieOutput;


@property (nonatomic,retain)NSTimer * recordingTimer;

@property (nonatomic)BOOL flashIsSelected;
@property (nonatomic,weak)UIButton * flashButton;

@property (nonatomic)BOOL frontCameraIsOn;

@end
@implementation PPMPCameraControll



-(instancetype)init{
    
    if (self=[super init]) {
        self.flashIsSelected=NO;
        self.frontCameraIsOn=NO;
//        _totalTime=15.0;
        self.totalVideoTime=[[PPMPDefaults sharedInstance] capturingTime];
        _running=NO;
        
        self.captureSession = [[AVCaptureSession alloc]init];
        self.captureSession.sessionPreset = AVCaptureSessionPresetMedium;
        
        
        
        self.captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        
        if ([[PPMPDefaults sharedInstance] defaultCameraPostion]==AVCaptureDevicePositionFront) {
            self.captureDevice=[self frontFacingCamera];
        }else{
            self.captureDevice=[self backFacingCamera];
        }
        
        NSError *error = nil;
        
        
        
        self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];
        if ([self.captureSession canAddInput:self.deviceInput])
            [self.captureSession addInput:self.deviceInput];
        
        AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        AVCaptureDeviceInput * audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
        if ([self.captureSession canAddInput:audioInput]) {
            [self.captureSession addInput:audioInput];
        }
        
        self.movieOutput = [[AVCaptureMovieFileOutput alloc] init];
        CMTime maxDuration = CMTimeMakeWithSeconds(20, 30);
        self.movieOutput.maxRecordedDuration = maxDuration;
        self.movieOutput.minFreeDiskSpaceLimit = 1024 * 1024;
        
        if ([self.captureSession canAddOutput:self.movieOutput])
            [self.captureSession addOutput:self.movieOutput];
        else
            self.movieOutput = nil;
        
        self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = @{ AVVideoCodecKey : AVVideoCodecJPEG};
        [self.imageOutput setOutputSettings:outputSettings];
        
        if ([self.captureSession canAddOutput:self.imageOutput])
            [self.captureSession addOutput:self.imageOutput];
        else
            self.imageOutput = nil;
        
        
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        //  self.previewLayer.borderColor=[UIColor colorFromHexString:@"6D6D6D"].CGColor;
        self.previewLayer.borderWidth=.25;
        
        
    }
    return self;
}
-(void)stopWorking:(BOOL)animated withComplitBlock:(void (^)())complitBlock{
    
    
    if (animated) {
        
        [UIView animateWithDuration:0.33 animations:^{
            
        }completion:^(BOOL finished) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSLog(@"start");
                
                [self.captureSession stopRunning];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    complitBlock();
                });
                
                
            });
        }];
        
    }
    else{
        
        self.running=NO;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSLog(@"start");
            
            [self.captureSession stopRunning];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                complitBlock();
            });
            
            
        });
        
    }
    
}

-(void)startWorkingAnimated:(BOOL)animated withComplitBlock:(void (^)())complitBlock{
    
    
    if (animated) {
        
        [UIView animateWithDuration:0.33 animations:^{
            
        }completion:^(BOOL finished) {
            [self startWorkingAnimated:NO withComplitBlock:complitBlock];
        }];
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSLog(@"start");
            
            [self.captureSession startRunning];
            
            Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
            if (captureDeviceClass != nil) {
                
                if ([self.captureDevice isFlashAvailable])
                {
                    if([self.captureDevice lockForConfiguration:nil]){
                        self.captureDevice.flashMode = [[PPMPDefaults sharedInstance] defaultFlashMode];
                        [self.captureDevice unlockForConfiguration];
                    }
                }
            }
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.running=YES;
                complitBlock();
            });
            
            
        });
    }
    
    
    
}


#pragma mark - actions
-(AVCaptureFlashMode)onFlash
{
    if ([self.captureDevice isFlashAvailable])
    {
        
        NSInteger flashMode= self.captureDevice.flashMode +1;
        if (flashMode>AVCaptureFlashModeAuto) {
            flashMode=AVCaptureFlashModeOff;
        }
        [[PPMPDefaults sharedInstance] setDefaultFlashMode:flashMode];
        if([self.captureDevice lockForConfiguration:nil]){
            self.captureDevice.flashMode = flashMode;
            [self.captureDevice unlockForConfiguration];
        }
        
        return flashMode;
    }
    return -1;
}

-(void)onGridButton:(UIButton*)button{
    
    
    
}
- (AVCaptureDevice *)cameraAtPosition:(AVCaptureDevicePosition)position
{
    NSArray *captureDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *captureDevice in captureDevices)
    {
        if ([captureDevice position] == position)
            return captureDevice;
    }
    
    return nil;
}
- (AVCaptureDevice *)backFacingCamera
{
    return [self cameraAtPosition:AVCaptureDevicePositionBack];
}

- (AVCaptureDevice *)frontFacingCamera
{
    return [self cameraAtPosition:AVCaptureDevicePositionFront];
}
-(void)focus:(CGPoint)p{
    if (self.recording) {
        return;
    }
    double focus_x = self.previewLayer.frame.size.width/2;
    double focus_y =self.previewLayer.frame.size.height/2;
    NSError * err =nil;
    [self.captureDevice lockForConfiguration:&err];
    [self.captureDevice  setFocusPointOfInterest:p];
    [self.captureDevice  unlockForConfiguration];
}
-(void)onSwitch{
    
    
    AVCaptureDevice *newDevice;
    AVCaptureDevicePosition curPosition = [self.captureDevice position];
    if (curPosition == AVCaptureDevicePositionFront){
        
        [[PPMPDefaults sharedInstance] setDefaultCameraPostion:AVCaptureDevicePositionFront];
//        [[SADefaults sharedInstance] setDefaultCamera:0];
        newDevice = [self backFacingCamera];
    }
    
    else if (curPosition == AVCaptureDevicePositionBack){
     [[PPMPDefaults sharedInstance] setDefaultCameraPostion:AVCaptureDevicePositionBack];
        newDevice = [self frontFacingCamera];
    }
    
    
    if (newDevice == nil)
        return;
    
    NSError *error = nil;
    AVCaptureDeviceInput *newInput = [AVCaptureDeviceInput deviceInputWithDevice:newDevice error:&error];
    if (newInput == nil || error != nil)
        return;
    
    [self.captureSession beginConfiguration];
    [self.captureSession removeInput:self.deviceInput];
    
    if (![self.captureSession canAddInput:newInput])
    {
        [self.captureSession addInput:self.deviceInput];
    }
    else
    {
        self.deviceInput = newInput;
        
        if (![newDevice isFlashAvailable])
        {
            
            
        }else{
            if([newDevice lockForConfiguration:nil]){
                newDevice.flashMode = [[PPMPDefaults sharedInstance] defaultFlashMode];
                [newDevice unlockForConfiguration];
            }
        }
        self.captureDevice = newDevice;
        [self.captureSession addInput:self.deviceInput];
    }
    
    [self.captureSession commitConfiguration];
    
    
    
}

- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == position) return device;
    }
    return nil;
}
#pragma mark - methods
- (void)onCaptureImage
{
    if (self.processing) {
        return;
    }
    
    if (!self.running) {
        return;
    }
    
    self.processing=YES;
    [self.captureSession beginConfiguration];
    [self.captureSession setSessionPreset:AVCaptureSessionPreset1280x720];
    [self.captureSession commitConfiguration];
    [self.delegate cameraControllWillCaptureImage];
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.imageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        
        if (videoConnection)
            break;
    }
    
    
    
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection
                                                  completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         if (exifAttachments)
         {
             // Do something with the attachments.
             NSLog(@"attachements: %@", exifAttachments);
         }
         else
             NSLog(@"no attachments");
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];
         
         int imageWidth = (int)CGImageGetWidth(image.CGImage);
         int imageHeight = (int)CGImageGetHeight(image.CGImage);
         image = [PPMPCameraHelper makeSquareImage:image];
         imageWidth = (int)CGImageGetWidth(image.CGImage);
         imageHeight = (int)CGImageGetHeight(image.CGImage);
         
         AVCaptureDevicePosition curPosition = [self.captureDevice position];
         if (curPosition == AVCaptureDevicePositionFront)
         {
             image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUpMirrored];
         }
         
         NSString *strDocuments = [PPMPCameraHelper getDocumentPath];
         NSString *strPhotoFile = [strDocuments stringByAppendingPathComponent:IMAGE_FILE];
         
         
         
         BOOL fSuccess = [PPMPCameraHelper saveImageToJPGFile:image path:strPhotoFile];
         NSLog(@"%@",strPhotoFile);
        [self.delegate cameraControllDidCaptureImage:image];
         if (fSuccess && self.delegate != nil)
         {
             
             
             [self.delegate cameraControll:self
                 didFinishWorkWithResponse:[PPMPMediaObject createWithType:PPMPCameraResponseMediaTypeImage andFilePath:strPhotoFile]];
//             [self.delegate didFinishWithMediaObject:[SAMediaObject mediaObjectWithType:SAMediaObjectTypePhoto andPath:strPhotoFile]];
         }
         
         self.processing=NO;
         
     }];
}
- (void)onStartCaptureVideo
{
    if (self.processing) {
        return;
    }
    
    [self.delegate cameraControllWillStartCapturingVideo];
    // Configure capture session
    self.currentCaptureTime=0;
    [self.captureSession beginConfiguration];
    [self.captureSession setSessionPreset:AVCaptureSessionPreset640x480];
    [self.captureSession commitConfiguration];
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.movieOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo])
            {
                videoConnection = connection;
                break;
            }
        }
        
        if (videoConnection)
            break;
    }
    self.recording=YES;
    AVCaptureDevicePosition curPosition = [self.captureDevice position];
    if (curPosition == AVCaptureDevicePositionFront && [videoConnection isVideoMirroringSupported]){
        [videoConnection setVideoOrientation:AVCaptureVideoOrientationPortraitUpsideDown];
        [videoConnection setVideoMirrored:YES];
    }
    NSString *strDocuments = [PPMPCameraHelper getDocumentPath];
    NSString *strVideoFile = [strDocuments stringByAppendingPathComponent:@"temp_1.mov"];
    // Check for existing file and remove it.
    if ([[NSFileManager defaultManager] fileExistsAtPath:strVideoFile])
        [[NSFileManager defaultManager] removeItemAtPath:strVideoFile error:nil];
    NSURL *videoFileURL = [NSURL fileURLWithPath:strVideoFile];
    [self.movieOutput startRecordingToOutputFileURL:videoFileURL recordingDelegate:self];
    
    self.recordingTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onUPD) userInfo:nil repeats:YES];
    [self.delegate cameraControllDidStartCapturingVideo];
    // [self performSelector:@selector(onUPD) withObject:nil afterDelay:1.0];
}
-(void)onUPD{
    self.currentCaptureTime+=0.1;
    
    [self.delegate cameraControllUpdateVideoCapturingTimer:self.currentCaptureTime];
    if (self.currentCaptureTime  >= self.totalVideoTime) {
        
        [self onStopCaptureVideo];
    }else{
        
    }
}
- (void)onStopCaptureVideo
{
    [self.recordingTimer invalidate];
    self.recordingTimer=nil;
    [self.movieOutput stopRecording];
}

#pragma mark AVCaptureFileOutputRecordingDelegate

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    
    
    if (!self.recording) {
        return;
    }
    if (self.processing) {
        return;
    }
    NSLog(@"DINISH CAPURT");
    [self.delegate cameraControllWillFinishCapturingVideo];
    self.recording=NO;
    self.processing=YES;
    [self.recordingTimer invalidate];
    self.recordingTimer=nil;
    if (error != nil)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        alertView = nil;
    }
    else
    {
        NSLog(@"%@", outputFileURL);
        
        NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *exportPath = [documentsPath stringByAppendingPathComponent:MOVIE_FILE];
        NSURL *exportUrl = [NSURL fileURLWithPath:exportPath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:exportPath])
            [[NSFileManager defaultManager] removeItemAtPath:exportPath error:nil];
//        NSString* docFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        NSString* savePath = [docFolder stringByAppendingPathComponent:MOVIE_FILE];

        
        AVAsset* asset = [AVAsset assetWithURL:outputFileURL];
        
        AVMutableComposition *composition = [AVMutableComposition composition];
        [composition  addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        
        // input clip
        AVAssetTrack *clipVideoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
        
        //create a video composition and preset some settings
        AVMutableVideoComposition* videoComposition = [AVMutableVideoComposition videoComposition];
        videoComposition.frameDuration = CMTimeMake(1, 30);
        //here we are setting its render size to its height x height (Square)
        videoComposition.renderSize = CGSizeMake(clipVideoTrack.naturalSize.height, clipVideoTrack.naturalSize.height);
        AVMutableVideoCompositionInstruction *instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
        
        instruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeMakeWithSeconds(60, 30));
        
        AVMutableVideoCompositionLayerInstruction* transformer = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:clipVideoTrack];
//        CGAffineTransform t1 = CGAffineTransformMakeTranslation(clipVideoTrack.naturalSize.height, 0);
        CGAffineTransform t1 = CGAffineTransformMakeTranslation(clipVideoTrack.naturalSize.height, -(clipVideoTrack.naturalSize.width - clipVideoTrack.naturalSize.height) /2 );
        
        CGAffineTransform t2 = CGAffineTransformRotate(t1, M_PI_2);
        
        CGAffineTransform finalTransform = t2;
        [transformer setTransform:finalTransform atTime:kCMTimeZero];
        
        //add the transformer layer instructions, then add to video composition
        instruction.layerInstructions = [NSArray arrayWithObject:transformer];
        videoComposition.instructions = [NSArray arrayWithObject: instruction];

 
        // export
        

        
      AVAssetExportSession *  exporter = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetHighestQuality] ;
        exporter.videoComposition = videoComposition;
        exporter.outputURL=exportUrl;
        exporter.outputFileType=AVFileTypeQuickTimeMovie;

        [exporter exportAsynchronouslyWithCompletionHandler:^(void){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *strDocuments = [PPMPCameraHelper getDocumentPath];
                NSString *strVideoFile = [exportUrl absoluteString];
                
                
                NSLog(@"%@",strVideoFile);
              
                [self.delegate cameraControllDidFinishCapturingVideo];
                [self.delegate cameraControll:self
                    didFinishWorkWithResponse:[PPMPMediaObject createWithType:PPMPCameraResponseMediaTypeVideo andFilePath:strVideoFile]];
                  self.processing=NO;
            });
  
        }];
        
        // Configure capture session
        
    //        if (self.delegate != nil)
//            [self.delegate didFinishWithMediaObject:[SAMediaObject mediaObjectWithType:SAMediaObjectTypeVideoClean andPath:strVideoFile]];
    }
}
#pragma mark - <PPMPCammeraShutterViewDelegate>


- (void)ppmps_wantToCaptureImage{
#if TARGET_OS_SIMULATOR
    [self onCaptureImageSim];
#else
    [self onCaptureImage];
#endif
}
- (BOOL)ppmps_wantToStartRecordingVideo{
    
    if (self.processing) {
        return NO;
    }
    
    [self onStartCaptureVideo];
    return self.recording;
}
- (void)ppmps_wantToEndRecordingVideo{
    [self onStopCaptureVideo];
}



#pragma mark - sim

-(void)onCaptureImageSim{
    NSString *strDocuments = [PPMPCameraHelper getDocumentPath];
    NSString *strPhotoFile = [strDocuments stringByAppendingPathComponent:IMAGE_FILE];
    [PPMPCameraHelper saveImageToJPGFile:[UIImage imageNamed:@"123_s.jpg"] path:strPhotoFile];
    
//    [self.delegate didFinishWithMediaObject:[SAMediaObject mediaObjectWithType:SAMediaObjectTypePhoto andPath:strPhotoFile]];
}

@end
