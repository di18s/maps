//
//  ViewController.m
//  news_HolmogorovDmitry_l3
//
//  Created by Дмитрий on 23/03/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollectionViewCell.h"
#import "Photo.h"

@interface PhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) NSMutableArray* photoArray;
@property (nonatomic, strong) NSArray* photoArraySearch;
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) UIImage* localImage;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
	[self.collectionView setBackgroundColor:UIColor.whiteColor];
	self.collectionView.dataSource = self;
	self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    self.photoArraySearch = [NSArray new];
    self.photoArray = [NSMutableArray new];
    Photo* defaultPhoto = [[Photo alloc] initWithPhoto:[UIImage imageNamed:@"addPhoto"] andTitle:@"add photo"];
    [self.photoArray addObject:defaultPhoto];
    self.photoArraySearch = [NSMutableArray arrayWithArray:self.photoArray];
    [self searchBarSetup];
    
	
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

    PhotoCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.imagePhoto.image = [self.photoArraySearch[indexPath.row] image_Photo];
        cell.titlePhoto.text = [self.photoArraySearch[indexPath.row] title_Photo];
    }
    if (self.photoArraySearch.count > 0 && indexPath.row > 0){
        cell.imagePhoto.image = [self.photoArraySearch[indexPath.row] image_Photo];
        cell.titlePhoto.text = [self.photoArraySearch[indexPath.row] title_Photo];
    }
    
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArraySearch.count;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}
//MARK: - delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self presentPickerController];
    }
}

//MARK: - SearchBar
-(void)searchBarSetup{
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.barStyle = UIBarStyleDefault;
    self.navigationItem.titleView = _searchBar;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.photoArraySearch = [self.photoArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.title_Photo CONTAINS[cd] %@", searchText]];
    if ([searchText  isEqual: @""]) {
        self.photoArraySearch = self.photoArray;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    
    
}
//MARK: - picker controller
- (void)presentPickerController {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if (image) {
        NSString* localTitle = [NSString stringWithFormat:@"Photo #%lu", (unsigned long)self.photoArray.count];
        Photo* photo = [[Photo alloc] initWithPhoto:image andTitle:localTitle];
        [self.photoArray addObject:photo];
        self.photoArraySearch = [NSMutableArray arrayWithArray:self.photoArray];
        NSLog(@"Получено изображение");
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
