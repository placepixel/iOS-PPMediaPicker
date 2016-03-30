//
//  PPMPDefaultUISetupObject.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPDefaultUISetupObject.h"
#import "PPMPVidePreviewViewController.h"
@implementation PPMPDefaultUISetupObject
-(UIButton*)root_closeButton{
    
    UIButton * but =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [but setTitle:@"x" forState:UIControlStateNormal];
    [but.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [but setFrame:CGRectMake(0, 0, 44, 44)];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [but setFrame:CGRectMake(0, 0, but.frame.size.width, 44)];
    
    return but;
}
-(UIColor *)defaultBackgroundColor{
    return [UIColor blueColor];
}

-(void)setRightButton:(UIButton *)button atViewControoler:(UIViewController *)vc{
    
    UIBarButtonItem * butItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -16;
    [vc.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, butItem/*this will be the button which u actually need*/, nil] animated:NO];
}
-(void)setLeftButton:(UIButton *)button atViewController:(UIViewController *)vc{
    UIBarButtonItem * butItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -16;
    [vc.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, butItem/*this will be the button which u actually need*/, nil] animated:NO];
}


-(UIFont*)navTitleFont{
    return [UIFont boldSystemFontOfSize:17];
}
-(UIColor*)navTitleColor{
    return [UIColor whiteColor];
}
-(UIButton*)navBackButton{
    UIButton * but =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [but setTitle:@"<" forState:UIControlStateNormal];
    [but.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [but setFrame:CGRectMake(0, 0, 44, 44)];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [but setFrame:CGRectMake(0, 0, but.frame.size.width, 44)];
    
    return but;
}
#pragma mark - selector

-(UIFont *)selector_titleFont{
    return [UIFont systemFontOfSize:16];
}
-(UIColor*)selector_selectedColor{
    
    return [UIColor redColor];
}
-(UIColor*)selector_unselectedColor{
    return [UIColor whiteColor];
}
#pragma mark - gallery

-(NSString*)gallery_title{
    return @"LIBRARY";
}


#pragma mark - camera
-(NSString*)camera_title{
    return @"camera";
}

-(UIColor*)camera_shutterLabelRecordingColor{
    return [UIColor redColor];
}
-(UIColor*)camera_shutterLabelDefaultColor{
    return [UIColor whiteColor];
}
-(UIFont*)camera_shutterLabelFont{
    return [UIFont systemFontOfSize:16];
}
-(NSString*)camera_shutterLabelDefaultText{
    
    return @"Tap for photo, hold for video";
}
-(UIImage *)camrea_rotateIcon{
    return nil;
}
-(UIImage*)camera_flashIconForState:(AVCaptureFlashMode)state{
    
    return nil;
}



#pragma mark - result
-(Class)result_videoPreviewClass{
    return [PPMPVidePreviewViewController class];
}
-(NSString*)result_videoTitle{
    
    return @"video";
}
-(NSString*)result_imageTitle{
    return @"image";
}

-(UIButton*)result_finishButton{
    
    UIButton * but =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [but setTitle:@"send" forState:UIControlStateNormal];
    [but.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [but setFrame:CGRectMake(0, 0, 120, 44)];
    [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [but sizeToFit];
    [but setFrame:CGRectMake(0, 0, but.frame.size.width, 44)];
    
    return but;
    
    
}

@end
