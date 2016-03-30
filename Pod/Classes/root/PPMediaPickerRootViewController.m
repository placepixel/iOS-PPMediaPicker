//
//  PPMediaPickerRootViewController.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMediaPickerRootViewController.h"
#import "PPMPGalleryAlbumViewController.h"
#import "PPMPCameraViewController.h"
@implementation PPMediaPickerRootViewController
-(instancetype)init{
    if (self=[super init]) {
        
    }
    
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    PPMPGalleryAlbumViewController * gallery = [[PPMPGalleryAlbumViewController alloc] init];
    PPMPCameraViewController * camera = [[PPMPCameraViewController alloc] init];
    
    [self setViewControllers:@[gallery,camera]];
    
    {
        UIButton *  b = [[PPMPDefaults uiObject] root_closeButton];
        [[PPMPDefaults uiObject] setLeftButton:b atViewController:self];
        [b addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
    }
    
    {
        UIButton *  b =[UIButton buttonWithType:UIButtonTypeCustom];
        
        [b setFrame:CGRectMake(0, 0, 44, 44)];
        
        [[PPMPDefaults uiObject] setRightButton:b atViewControoler:self];
    }
    
}

-(void)onClose{
    
    [self.navigationController close];
}

@end
