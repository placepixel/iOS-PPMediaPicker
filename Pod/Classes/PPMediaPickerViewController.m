//
//  PPMediaPickerViewController.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/29/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMediaPickerViewController.h"
#import "PPMediaPickerRootViewController.h"
@interface PPMediaPickerViewController ()

@end

@implementation PPMediaPickerViewController

-(instancetype)initMediaPicker{
    
    if (self=[super initWithRootViewController:[[PPMediaPickerRootViewController alloc] init]]) {
        
    }
    
    return self;
}
-(void)finishWithMediaObject:(PPMPMediaObject*)media{
    [self.pickerDelegate meidaPicker:self didFinishWorkingWithMediaObject:media];
}
-(void)close{
        [self.pickerDelegate meidaPickerDidCancel:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent=NO;
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
