//
//  PPMPVidePreviewViewController.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMPVidePreviewViewController.h"

@interface PPMPVidePreviewViewController ()

@end

@implementation PPMPVidePreviewViewController

-(void)ppmp_setVideoUrlStr:(NSString *)videoUrlStr{
    
   self.videoPath = videoUrlStr;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self playFromCurrentTime];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self stop];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPlaybackLoops:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
