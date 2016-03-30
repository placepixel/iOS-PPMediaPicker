//
//  MGAPPhotoGalleryCropperView.m
//  MagraCamera
//
//  Created by Alex Padalko on 7/1/15.
//  Copyright (c) 2015 Alex Padalko. All rights reserved.
//

#import "MGAPPhotoGalleryCropperView.h"
#include <AssetsLibrary/AssetsLibrary.h>

@implementation MGAPPhotoGalleryCropperView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
//        [self setBackgroundColor:     [MGCameraDefaults sharedDefaults].mainBgColor];
        
        ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
//            if (group) {
//                [groups addObject:group];
//            }
            NSLog(@"%@", group);
            
            // Do any processing you would do here on groups
//            [self processGroups:groups];
//            
//            // Since this is a background process, you will need to update the UI too for example
//            [self.tableView reloadData];
        };
        
        
    }
    return self;
}

//-(void)getAllPictures
//{
//   NSArray * imageArray=[[NSArray alloc] init];
// NSMutableArray *   mutableArray =[[NSMutableArray alloc]init];
//    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
//    NSInteger count = 0;
//  ALAssetsLibrary *  library = [[ALAssetsLibrary alloc] init];
//    
//    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
//        if(result != nil) {
//            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
//                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
//                
//                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
//                
//                [library assetForURL:url
//                         resultBlock:^(ALAsset *asset) {
//                             [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
//                             
//                             if ([mutableArray count]==count)
//                             {
//                                 imageArray=[[NSArray alloc] initWithArray:mutableArray];
//                                 [self allPhotosCollected:imageArray];
//                             }
//                         }
//                        failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
//                
//            }
//        }
//    };
//    
//    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
//    
//    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
//        if(group != nil) {
//            [group enumerateAssetsUsingBlock:assetEnumerator];
//            [assetGroups addObject:group];
//            count=[group numberOfAssets];
//        }
//    };
//    
//    assetGroups = [[NSMutableArray alloc] init];
//    
//    [library enumerateGroupsWithTypes:ALAssetsGroupAll
//                           usingBlock:assetGroupEnumerator
//                         failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
