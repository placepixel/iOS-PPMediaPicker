//
//  PPMPGalleryViewController.m
//  PPMediaPicker
//
//  Created by Alex Padalko on 3/28/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//
#import "PPMPResultViewController.h"
#import "PPMPGalleryAlbumViewController.h"
#import "PPMPDefaults.h"
#import "PPMPGalleryAlbumCollectionViewCell.h"
#import "PPMPGalleryAlbumTopbar.h"

#import "PPMPGalleryAlbumCollectionViewLayout.h"
@import Photos;

@interface  PPMPGalleryAlbumViewController ()  <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,retain)UICollectionView * photosCollectionView;
@property (nonatomic,retain)PPMPGalleryAlbumCollectionViewLayout * photosCollectionViewLayout;
@property (nonatomic,retain)PHFetchResult *allPhotos;

@property (nonatomic, strong) PHCachingImageManager *imageManager;

//@property

@end
@implementation PPMPGalleryAlbumViewController


-(NSString *)title{
    return [[PPMPDefaults uiObject] gallery_title];
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title=[[PPMPDefaults uiObject] gallery_title];
    self.imageManager = [[PHCachingImageManager alloc] init];
    [self.photosCollectionView registerClass:[PPMPGalleryAlbumCollectionViewCell class] forCellWithReuseIdentifier:@"ppmp_album_cell"];
    [self.photosCollectionView registerClass:[PPMPGalleryAlbumTopbar class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ppmp_album_header"];

    
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    
    
    NSLog(@"%ld",self.allPhotos.count);
    
    [self.photosCollectionView reloadData];
    
    
    
}




#pragma mark - layout

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.photosCollectionView setFrame:self.view.bounds];
//            [_photosCollectionViewLayout setHeaderReferenceSize:CGSizeMake(self.view.frame.size.width, 44)];
    [self.photosCollectionViewLayout setItemSize:CGSizeMake(self.view.frame.size.width/4.0-3, self.view.frame.size.width/4.0-3)];
//    [self.photosCollectionView setContentOffset:CGPointMake(0,44) animated:YES];
}

#pragma mark -  <UICollectionViewDelegate,UICollectionViewDataSource>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
           NSLog(@"?!!!!?");
        PHAsset *asset = self.allPhotos[indexPath.row];
    __block BOOL once = NO;
    [self.imageManager requestImageForAsset:asset
                                 targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight)
                                contentMode:PHImageContentModeAspectFill
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  // Set the cell's thumbnail image if it's still showing the same asset.
                                  if (!once) {
                                       once=YES;
                                      return ;
                                  }
                                 
                                  NSLog(@"???");
                                 PPMPMediaObject * mm = [PPMPMediaObject createWithType:PPMPCameraResponseMediaTypeImage andFilePath:nil];
                                  
                                  mm.item = result;
                                  
                                     PPMPResultViewController * res= [[PPMPResultViewController alloc] initWithMedia:mm allowToEdit:YES];
                                  [[[self parentViewController] navigationController] pushViewController:res animated:YES];
                              }];
    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allPhotos.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   PPMPGalleryAlbumCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ppmp_album_cell" forIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    PHAsset *asset = self.allPhotos[indexPath.row];
    
    cell.assetsIndif = asset.localIdentifier;
    [cell setImage:nil];
    [self.imageManager requestImageForAsset:asset
                                 targetSize:[self.photosCollectionViewLayout itemSize]
                                contentMode:PHImageContentModeAspectFill
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  // Set the cell's thumbnail image if it's still showing the same asset.
                                  if ([cell.assetsIndif isEqualToString:asset.localIdentifier]) {
                                      cell.image = result;
                                  }
                              }];
    
    return cell;
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    UICollectionReusableView  * rv =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ppmp_album_header" forIndexPath:indexPath ];
//    
//    return rv;
//    
//    
//}

#pragma mark - lazy init

-(PPMPGalleryAlbumCollectionViewLayout *)photosCollectionViewLayout{
    if (!_photosCollectionViewLayout) {
        _photosCollectionViewLayout=[[PPMPGalleryAlbumCollectionViewLayout alloc] init];
        [_photosCollectionViewLayout setMinimumLineSpacing:3.0];
        [_photosCollectionViewLayout setMinimumInteritemSpacing:3.0];
        [_photosCollectionViewLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        
    }
    return _photosCollectionViewLayout;
}
-(UICollectionView *)photosCollectionView{
    if (!_photosCollectionView) {
        _photosCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.photosCollectionViewLayout];
        [_photosCollectionView setAlwaysBounceVertical:YES];
        [self.view addSubview:_photosCollectionView];
        [_photosCollectionView setDelegate:self];
        [_photosCollectionView setDataSource:self];
        
          [_photosCollectionView setBackgroundColor:[UIColor whiteColor] ];
    }
    return _photosCollectionView;
}


@end
