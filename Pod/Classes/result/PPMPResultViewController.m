//
//  PPMPResultViewController.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPResultViewController.h"
#import "TWImageScrollView.h"

#import "PPMPDefaults.h"
#import "PPMPResultVideoPreviewProt.h"
@interface PPMPResultViewController ()


@property (nonatomic,retain)PPMPMediaObject * mediaObject;
@property (nonatomic) BOOL allowToEdit;
@property (nonatomic,retain)TWImageScrollView * imagePreview;

@property (nonatomic,retain)UIViewController<PPMPResultVideoPreviewProt>* videoPreviewVC;

@end

@implementation PPMPResultViewController

-(instancetype)initWithMedia:(PPMPMediaObject *)media allowToEdit:(BOOL)allowToEdit{
    if (self=[super init]) {
        self.mediaObject=media;
        self.allowToEdit=allowToEdit;
    }
    return self;
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    if (self.mediaObject.mediaType==PPMPCameraResponseMediaTypeImage) {
            self.title=[[PPMPDefaults uiObject ] result_imageTitle];
        self.imagePreview=[[TWImageScrollView alloc] init];
        
         [self.imagePreview setClipsToBounds:YES];
        if (self.mediaObject.item) {
             [self.imagePreview displayImage:self.mediaObject.item];
        }else{
            UIImage * img =[UIImage imageWithContentsOfFile:[self.mediaObject filePath]];
           
            [self.imagePreview displayImage:img];
        }
   
        [self.view addSubview:self.imagePreview];
        [self.imagePreview setUserInteractionEnabled:self.allowToEdit];
        
    }else{
            self.title=[[PPMPDefaults uiObject ] result_videoTitle];
        
        self.videoPreviewVC=[[[[PPMPDefaults uiObject ] result_videoPreviewClass] alloc] init];
        [self.videoPreviewVC ppmp_setVideoUrlStr:[self.mediaObject filePath]];
        
        [self addChildViewController:self.videoPreviewVC];
       
        [self.view addSubview:self.videoPreviewVC.view];
         [self.videoPreviewVC didMoveToParentViewController:self];
    }
    
    {
        UIButton * b =[[PPMPDefaults uiObject] navBackButton];
        [[PPMPDefaults uiObject] setLeftButton:b atViewController:self];
        
        [b addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    }

    {
        UIButton * b =[[PPMPDefaults uiObject] result_finishButton];
        [[PPMPDefaults uiObject] setRightButton:b atViewControoler:self];
        
        [b addTarget:self action:@selector(onSend) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
-(void)onSend{
    
    if (self.allowToEdit&&[self.mediaObject mediaType]==PPMPCameraResponseMediaTypeImage) {
        
        UIImage * img = [self.imagePreview capture];
        
        [self.mediaObject setItem:img];
         [[self navigationController] finishWithMediaObject:self.mediaObject];
    }else{
        
        [[self navigationController] finishWithMediaObject:self.mediaObject];
    }
    
}
-(void)onBack{
    [[self navigationController] popViewControllerAnimated:YES];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGRect previewFrame =CGRectMake(0, self.view.frame.size.height/2-self.view.frame.size.width/2, self.view.frame.size.width, self.view.frame.size.width);
    
    [self.imagePreview setFrame:previewFrame];
    [self.videoPreviewVC.view setFrame:previewFrame];
}

@end
