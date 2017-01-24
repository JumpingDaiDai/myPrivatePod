//
//  CTItemCollectionViewController.m
//  CTItemListComponentSample
//
//  Created by Jason on 2017/1/19.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "CTItemCollectionViewController.h"
#import "CTItemCollectionCell.h"

@interface CTItemCollectionViewController ()

@property (nonatomic, assign) float itemWidth;
@property (nonatomic, assign) float itemHeight;

@end

@implementation CTItemCollectionViewController

static NSString * const reuseIdentifierNormalCell = @"NormalCell";
static NSString * const reuseIdentifierTextOnlyCell = @"TextOnlyCell";
static NSString * const reuseIdentifierImageOnlyCell = @"ImageOnlyCell";

#pragma mark -
#pragma mark - Setter
#pragma mark -
//================================================================================
//
//================================================================================
- (void)setItemModelList:(NSArray *)itemModelList {
    
    _itemModelList = itemModelList;
    
    // 當資料注入時，更新視圖
    [self.collectionView reloadData];
}

//================================================================================
//
//================================================================================
- (void)setNumberOfRow:(NSInteger)numberOfRow {
    
    _numberOfRow = numberOfRow;
    
    // 當資料注入時，更新視圖
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark - Getter
#pragma mark -
//================================================================================
// item的寬度
//================================================================================
- (float)itemWidth {
    
    NSInteger itemCountOfRow = [self itemCountOfSection:0];
    float collectionViewWidth = self.collectionView.bounds.size.width;
    float itemWidth = collectionViewWidth / itemCountOfRow;
    
    return [self roundedDownToTheFifthDecimal:itemWidth];
}

//================================================================================
// item的高度
//================================================================================
- (float)itemHeight {
    
    NSInteger countOfRow = self.numberOfRow;
    float collectionViewHeight = self.collectionView.bounds.size.height;
    float itemHeight = collectionViewHeight / countOfRow;
    
    return itemHeight;
}

#pragma mark -
#pragma mark - Life-cycle methods
#pragma mark -
//================================================================================
//
//================================================================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize
    _itemModelList = [NSArray array];
    _numberOfRow = 1;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Xib_resource" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CTItemNormalCell" bundle:bundle] forCellWithReuseIdentifier:reuseIdentifierNormalCell];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CTItemImageCell" bundle:bundle] forCellWithReuseIdentifier:reuseIdentifierImageOnlyCell];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CTItemTextCell" bundle:bundle] forCellWithReuseIdentifier:reuseIdentifierTextOnlyCell];
}

#pragma mark -
#pragma mark - Instance methods
#pragma mark -
//================================================================================
//
//================================================================================
- (NSInteger)itemCountOfSection:(NSInteger)section {
    
    NSInteger itemCount = self.itemModelList.count;
    if (self.numberOfRow == 1) { // 單行的情況
        
        return itemCount;
    } else { // 雙行的情況
        
        switch (section) {
            case 0: {
                
                NSInteger count = (itemCount+1) / 2;
                return count;
            }
            case 1: {
                
                NSInteger count = itemCount / 2;
                return count;
            }
                
            default:
                return 0;
        }
    }
}

//================================================================================
// Item數量是否為偶數
//================================================================================
- (BOOL)isItemCountEven {
    
    return (self.itemModelList.count%2 == 0) ? YES : NO;
}

//================================================================================
// 無條件捨去到小數點後第五位
//================================================================================
- (float)roundedDownToTheFifthDecimal:(float)originNumber {
    
    float hundredThousandTimes = originNumber * 100000;
    NSInteger hundredThousandTimesInt = (NSInteger)hundredThousandTimes;
    float fifthDecimalFloat = hundredThousandTimesInt / 100000;
    
    return fifthDecimalFloat;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource methods
#pragma mark -
//================================================================================
//
//================================================================================
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.numberOfRow;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self itemCountOfSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // current item model
    CTItemModel *itemModel = [self.itemModelList objectAtIndex:(indexPath.section*[self itemCountOfSection:0]) + indexPath.row];
    
    // creat cell
    CTItemCollectionCell *cell;
    switch (itemModel.styleType) {
        case StyleType_Normal:
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierNormalCell forIndexPath:indexPath];
            break;
        case StyleType_ImageOnly:
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierImageOnlyCell forIndexPath:indexPath];
            break;
        case StyleType_TextOnly:
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierTextOnlyCell forIndexPath:indexPath];
            break;
            
        default:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierNormalCell forIndexPath:indexPath];
            break;
    }
    
    cell.itemModel = itemModel;
    
    return cell;
}

#pragma mark -
#pragma mark - UICollectionViewDelegateFlowLayout methods
#pragma mark -
//================================================================================
//
//================================================================================
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.itemWidth, self.itemHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(0, 0, 0, 0);
        case 1:
            if ([self isItemCountEven]) { // item數量為偶數
                
                return UIEdgeInsetsMake(0, 0, 0, 0);
            } else { // item數量為奇數
                
                return UIEdgeInsetsMake(0, self.itemWidth/2, 0, self.itemWidth/2);
            }
        default:
            return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

@end
