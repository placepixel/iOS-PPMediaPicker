//
//  PPViewController.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 03/30/2016.
//  Copyright (c) 2016 Alex Padalko. All rights reserved.
//

#import "PPViewController.h"
#import <PPMediaPicker/PPMediaPickerViewController.h>
@interface PPViewController ()<PPMediaPickerViewControllerDelegate>

@end

@implementation PPViewController

-(void)a{
    PPMediaPickerViewController * p = [[PPMediaPickerViewController alloc] initMediaPicker];
    [p setPickerDelegate:self];
    [self presentViewController:p animated:YES completion:^{
        
    }];
}

-(void)meidaPickerDidCancel:(PPMediaPickerViewController*)mediaPicker{
    
    [mediaPicker dismissViewControllerAnimated:YES
     
                                    completion:^{
                                        
                                    }];
    
}
-(void)meidaPicker:(PPMediaPickerViewController*)mediaPicker didFinishWorkingWithMediaObject:(PPMPMediaObject*)media{
    [mediaPicker dismissViewControllerAnimated:YES
     
                                    completion:^{
                                        
                                    }];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(a) withObject:nil afterDelay:1.0];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
