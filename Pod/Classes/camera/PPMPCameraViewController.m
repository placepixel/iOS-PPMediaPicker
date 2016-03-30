//
//  PPMPCameraViewController.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPCameraViewController.h"
#import "PPMPCameraControll.h"
#import "PPMPCameraShutterView.h"

#import "PPMPResultViewController.h"
#import "PPMPDefaults.h"
typedef NS_ENUM(NSInteger,PPMPCameraUIStateType){
    PPMPCameraUIStateTypeDefault,
    PPMPCameraUIStateTypeCapturingVideo
    
};

@interface PPMPCameraViewController () <PPMPCameraControllControllDelegate,UIGestureRecognizerDelegate>{
    UITapGestureRecognizer * tapRec;
}

@property (nonatomic,retain)PPMPCameraControll * cameraControll;
@property (nonatomic,retain)PPMPCameraShutterView * shutterView;
@property (nonatomic,retain)UIImageView * imgv;

@property (nonatomic,retain)UILabel * shutterLabel;

@property (nonatomic)PPMPCameraUIStateType uiState;

@property (nonatomic,retain)UIButton * flashButton;
@property (nonatomic,retain)UIButton * rotateCameraButton;


@end

@implementation PPMPCameraViewController

-(NSString *)title{
    return [[PPMPDefaults uiObject] camera_title];
}
#pragma mark - lc
-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    self.cameraControll=[[PPMPCameraControll alloc] init];
    [self.view.layer addSublayer:self.cameraControll.previewLayer];
    [self.cameraControll setDelegate:self];
    
    self.shutterView=[[PPMPCameraShutterView alloc] init];
    [self.shutterView setDelegate:self.cameraControll];
    [self.view addSubview:self.shutterView];
    
    self.shutterLabel=[[UILabel alloc] init];
    [self.shutterLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.shutterLabel];
    
    self.imgv=[[UIImageView alloc] init];
    
    [self.view addSubview:self.imgv];
    
    self.uiState=PPMPCameraUIStateTypeDefault;
    
    
    self.flashButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.flashButton addTarget:self action:@selector(onFlashButton) forControlEvents:UIControlEventTouchUpInside];
    [self.flashButton setBackgroundColor:[UIColor purpleColor]];
    [self.flashButton setImage:[[PPMPDefaults uiObject] camera_flashIconForState:[[PPMPDefaults sharedInstance] defaultFlashMode]] forState:UIControlStateNormal];
    [self.view addSubview:self.flashButton];

    self.rotateCameraButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.rotateCameraButton addTarget:self action:@selector(onRotateCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.rotateCameraButton setBackgroundColor:[UIColor purpleColor]];
    [self.rotateCameraButton setImage:[[PPMPDefaults uiObject] camrea_rotateIcon] forState:UIControlStateNormal];
    [self.view addSubview:self.rotateCameraButton];
    
  tapRec =[[UITapGestureRecognizer alloc] init];
    [tapRec setDelegate:self];
    [tapRec addTarget:self action:@selector(onTap:)];
    [self.view addGestureRecognizer:tapRec];
    
    
    
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.cameraControll startWorkingAnimated:animated withComplitBlock:^{}];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.cameraControll stopWorking:animated withComplitBlock:^{}];
}

#pragma mark - actions
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([tapRec isEqual:gestureRecognizer]&& CGRectContainsPoint( [self.cameraControll.previewLayer frame],[gestureRecognizer locationInView:self.view])) {
        return YES;
        
    }else{
        return NO;
    }
    
}

-(void)onTap:(UIGestureRecognizer*)gesture{
    
    if ([gesture state]==UIGestureRecognizerStateEnded) {
        [self.cameraControll focus:[gesture locationInView:self.view]];
    }
    
    
    
}
-(void)onRotateCamera{
   [self.cameraControll onSwitch];
}
-(void)onFlashButton{
       [self.flashButton setImage:[[PPMPDefaults uiObject] camera_flashIconForState:[[self cameraControll] onFlash]] forState:UIControlStateNormal];
  
}

#pragma mark - ui setup


-(void)setUiState:(PPMPCameraUIStateType)uiState{
    _uiState=uiState;
    
    if (uiState==PPMPCameraUIStateTypeDefault) {
        
        [self.shutterLabel setText:[[PPMPDefaults uiObject] camera_shutterLabelDefaultText]];
        [self.shutterLabel setTextColor:[[PPMPDefaults uiObject] camera_shutterLabelDefaultColor]];
        
        [self.flashButton setHidden:NO];
        [self.rotateCameraButton setHidden:NO];
        
        [[self parentViewController].view setUserInteractionEnabled:YES];
        
    }else if (uiState==PPMPCameraUIStateTypeCapturingVideo){
        
        
        
        [self.shutterLabel setText:@"15s."];
        [self.shutterLabel setTextColor:[[PPMPDefaults uiObject] camera_shutterLabelRecordingColor]];
        [self.flashButton setHidden:YES];
        [self.rotateCameraButton setHidden:YES];
        
        [[self parentViewController].view setUserInteractionEnabled:NO];

    }
    
}

#pragma mark - layout

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
      [self.cameraControll.previewLayer setFrame:CGRectMake(0, self.view.frame.size.height/2-self.view.frame.size.width/2, self.view.frame.size.width, self.view.frame.size.width)];
    
    [self.shutterView setFrame:CGRectMake(self.view.frame.size.width/2-70/2, self.view.frame.size.height-70-10, 70, 70)];
    
    [self.shutterLabel setFrame:CGRectMake(16, self.shutterView.frame.origin.y-32, self.view.frame.size.width-32, 32)];
    
    [self.imgv setFrame:self.cameraControll.previewLayer.frame];
    
    
    [self.flashButton setFrame:CGRectMake(self.view.frame.size.width-8-44, self.cameraControll.previewLayer.frame.origin.y+ 8, 44, 44)];
    [self.rotateCameraButton setFrame:CGRectMake(8, self.cameraControll.previewLayer.frame.origin.y+ 8, 44, 44)];
}



#pragma mark -  PPMPCameraControllControllDelegate
-(void)cameraControll:(PPMPCameraControll*)cameraControll didFinishWorkWithResponse:(PPMPMediaObject*)response{
    
    [[self.parentViewController navigationController] pushViewController:[[PPMPResultViewController alloc] initWithMedia:response allowToEdit:NO] animated:YES];
    
}
#pragma mark image
-(void)cameraControllWillCaptureImage{
    
}
-(void)cameraControllDidCaptureImage:(UIImage*)image{
//    [self.imgv setImage:image];
}
#pragma mark video
-(void)cameraControllWillStartCapturingVideo{
    
    self.uiState=PPMPCameraUIStateTypeCapturingVideo;
}
-(void)cameraControllDidStartCapturingVideo{
    
}
-(void)cameraControllUpdateVideoCapturingTimer:(float)newTime{
    
    
    [self.shutterLabel setText:[NSString stringWithFormat:@"%lds.",(NSInteger)self.cameraControll.totalVideoTime-(NSInteger)newTime]];
    
}
-(void)cameraControllWillFinishCapturingVideo{
    
}
-(void)cameraControllDidFinishCapturingVideo{
        self.uiState=PPMPCameraUIStateTypeDefault;
    
    [self.shutterView stopRecording];
}

@end
