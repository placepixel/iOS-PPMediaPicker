//
//  PPMPUISetupObjectProt.h
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMPResultVideoPreviewProt.h"
#import <AVFoundation/AVFoundation.h>

@protocol PPMPUISetupObjectProt <NSObject>



-(UIButton * )root_closeButton;

-(UIColor *)defaultBackgroundColor;
//////

-(UIFont*)navTitleFont;
-(UIColor*)navTitleColor;
-(UIButton*)navBackButton;

-(void)setLeftButton:(UIButton*)button atViewController:(UIViewController*)vc;
-(void)setRightButton:(UIButton*)button atViewControoler:(UIViewController*)vc;

#pragma mark - selector

-(UIFont *)selector_titleFont;
-(UIColor*)selector_selectedColor;
-(UIColor*)selector_unselectedColor;


#pragma mark - gallery

-(NSString*)gallery_title;


#pragma mark - camera
-(NSString*)camera_title;
-(UIColor*)camera_shutterLabelRecordingColor;
-(UIColor*)camera_shutterLabelDefaultColor;
-(UIFont*)camera_shutterLabelFont;
-(NSString*)camera_shutterLabelDefaultText;
-(UIImage*)camera_flashIconForState:(AVCaptureFlashMode)state;
-(UIImage *)camrea_rotateIcon;
#pragma mark - result
-(NSString*)result_videoTitle;
-(NSString*)result_imageTitle;

-(UIButton*)result_finishButton;

-(Class)result_videoPreviewClass;
//////





@end
