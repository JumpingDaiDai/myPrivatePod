//
//  ViewController.m
//  CTItemListComponentSample
//
//  Created by Jason on 2017/1/12.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "CTViewController.h"
#import "CTItemModel.h"
#import "CTItemListComponent.h"
#import "CTItemCollectionViewController.h"

@interface CTViewController ()

// sample 需要的元件
@property (nonatomic, weak) IBOutlet UISlider *itemCountSlider;

// stack view 需要的元件
@property (nonatomic, weak) IBOutlet CTItemListComponent *itemListComponent;

// collection view 需要的元件
@property (nonatomic, strong) CTItemCollectionViewController *itemCollectionViewController;
@property (nonatomic, weak) IBOutlet UIView *itemCollectionView;

@end

@implementation CTViewController

#pragma mark -
#pragma mark - Getter
#pragma mark -
//================================================================================
//
//================================================================================
- (CTItemCollectionViewController *)itemCollectionViewController {
    
    if (!_itemCollectionViewController) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _itemCollectionViewController = [[CTItemCollectionViewController alloc] initWithCollectionViewLayout:layout];
        _itemCollectionViewController.collectionView.frame = self.itemCollectionView.bounds;
        [self addChildViewController:_itemCollectionViewController];
        [self.itemCollectionView addSubview:_itemCollectionViewController.collectionView];
    }
    
    return _itemCollectionViewController;
}

#pragma mark -
#pragma mark - Life-cycle methods
#pragma mark -
//================================================================================
//
//================================================================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 資料設定
    [self setData];
}

#pragma mark -
#pragma mark - Instance methods
#pragma mark -
//================================================================================
// 資料設定
//================================================================================
- (void)setData {
    
    // 注入顯示的資料
    self.itemListComponent.itemModelList = [self testData];
    self.itemCollectionViewController.itemModelList = [self testData];
}

//================================================================================
// 測試資料
//================================================================================
- (NSArray*)testData {
    
    NSMutableArray *itemModelList = [NSMutableArray array];
    
    // 新增n筆測試資料
    int itemCount = (int)self.itemCountSlider.value;
    for (int itemIndex = 0; itemIndex < itemCount; itemIndex++) {
        
        if (itemIndex == 1) {
            
            CTItemModel *model = [[CTItemModel alloc] initWithStyleType:StyleType_Normal contentType:ContentType_Button];
            
            model.image = [UIImage imageNamed:@"test_image.png"];
            model.title = @"六花";
            model.font = [UIFont systemFontOfSize:13];
            model.contentType = ContentType_Button;
            model.buttonActionBlock = ^(void) {
                
                NSLog(@"自訂item點擊");
            };
            
            [itemModelList addObject:model];
        } else if (itemIndex == 3) {
            
            CTItemModel *model = [[CTItemModel alloc] initWithStyleType:StyleType_ImageOnly contentType:ContentType_Button];
            
            model.image = [UIImage imageNamed:@"test_image.png"];
            model.contentType = ContentType_Button;
            model.buttonActionBlock = ^(void) {
                
                NSLog(@"自訂item點擊");
            };
            
            [itemModelList addObject:model];
        } else if (itemIndex == 5) {
            
            CTItemModel *model = [[CTItemModel alloc] initWithStyleType:StyleType_TextOnly contentType:ContentType_Button];
            
            model.title = @"只有文字";
            model.font = [UIFont systemFontOfSize:10.0];
            model.contentType = ContentType_Button;
            model.buttonActionBlock = ^(void) {
                
                NSLog(@"自訂item 2點擊");
            };
            
            [itemModelList addObject:model];
        } else {
            
            CTItemModel *model = [self testItemModel];
            model.title = [NSString stringWithFormat:@"No.%d", itemIndex];
            model.font = [UIFont systemFontOfSize:13];
            model.buttonActionBlock = ^(void) {
                
                NSLog(@"button %d action", itemIndex);
            };
            [itemModelList addObject:model];
        }
    }
    
    return itemModelList;
}

//================================================================================
// 測試ItemModel
//================================================================================
- (CTItemModel*)testItemModel {
    
    CTItemModel *itemModel = [[CTItemModel alloc] init];
    itemModel.image = [UIImage imageNamed:@"default_image"];
    
    return itemModel;
}

#pragma mark -
#pragma mark - Slider action
#pragma mark -
//================================================================================
// Item 數量
//================================================================================
- (IBAction)numberChanged:(id)sender {
    
    [self setData];
}

#pragma mark -
#pragma mark - Segmented action
#pragma mark -
//================================================================================
// 單、雙行切換
//================================================================================
- (IBAction)numberOfRowSwitched:(id)sender {
    
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    NSInteger index = seg.selectedSegmentIndex;
    
    self.itemListComponent.numberOfRow = index + 1;
    self.itemCollectionViewController.numberOfRow = index + 1;
}

#pragma mark -
#pragma mark - Button action
#pragma mark -
//================================================================================
// 匡線顯示模式
//================================================================================
- (IBAction)separationModeNoneIsPressed:(id)sender {
    
    self.itemListComponent.separationMode = SeparationMode_None;
}

- (IBAction)separationModeVerticalIsPressed:(id)sender {
    
    self.itemListComponent.separationMode = SeparationMode_Vertical;
}

- (IBAction)blueLineIsPressed:(id)sender {
    
    self.itemListComponent.separationColor = [UIColor blueColor];
}

- (IBAction)blackLineIsPressed:(id)sender {
    
    self.itemListComponent.separationColor = [UIColor blackColor];
}

@end
