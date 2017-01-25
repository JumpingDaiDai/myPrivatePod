//
//  CTItemListComponent.m
//  CTItemListComponentSample
//
//  Created by Jason on 2017/1/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "CTItemListComponent.h"
#import "CTItem.h"

@interface CTItemListComponent()

@property (nonatomic, weak) IBOutlet UIStackView *topStackView;
@property (nonatomic, weak) IBOutlet UIView *topStackBackgroundView;
@property (nonatomic, weak) IBOutlet UIStackView *bottomStackView;
@property (nonatomic, weak) IBOutlet UIView *bottomStackBackgroundView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topStackHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomStackWidth;

@end

@implementation CTItemListComponent

#pragma mark -
#pragma mark - Setter
#pragma mark -
//================================================================================
//
//================================================================================
- (void)setItemModelList:(NSArray *)itemModelList {
    
    _itemModelList = itemModelList;
    
    // 當資料注入時，更新視圖
    [self itemSetup];
}

//================================================================================
//
//================================================================================
- (void)setNumberOfRow:(NSInteger)numberOfRow {
    
    _numberOfRow = numberOfRow;
    
    // 當資料注入時，更新視圖
    [self itemSetup];
}

//================================================================================
//
//================================================================================
- (void)setSeparationMode:(SeparationMode)separationMode {
    
    _separationMode = separationMode;
    
    // 當資料注入時，更新視圖
    [self itemSetup];
}

//================================================================================
//
//================================================================================
- (void)setSeparationColor:(UIColor *)separationColor {
    
    _separationColor = separationColor;
    
    // 當資料注入時，更新視圖
    [self itemSetup];
}

#pragma mark -
#pragma mark - Life-cycle methods
#pragma mark -
//================================================================================
//
//================================================================================
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        // initialize
        _itemModelList = [NSArray array];
        _numberOfRow = 1;
        _separationMode = SeparationMode_None;
        _separationColor = [UIColor grayColor];
        
        [self viewInit];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Instance methods
#pragma mark -
//================================================================================
// 匡線的調整
//================================================================================
- (void)viewInit {
    
    // 取得xibView 使用Name來取得
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Xib_resource" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    CTItemListComponent *itemView = [[bundle loadNibNamed:@"CTItemListComponent"
                                                                                                   owner:self
                                                                                                 options:nil]
                                     objectAtIndex:0];
    // 設定該xibView的Frame
    itemView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    itemView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // 將xibView加入
    [self addSubview:itemView];
}

//================================================================================
// 用itemModelList產生CTItem, 並加入到StackView
//================================================================================
- (void)itemSetup {
    
    // 清空StackView
    [self stackViewClean];
    
    // 加入新的itemModel進入StackView
    int count = (int)[self.itemModelList count];
    
    if (self.numberOfRow == 1) {
        
        for (int i = 0; i < count; i++) {
            
            CTItem *fCTItem = [[CTItem alloc] initWithItemModel:[self.itemModelList objectAtIndex:i]];
            
            [self.topStackView addArrangedSubview:fCTItem];
        }
    } else {
        
        for (int i = 0; i < count; i++) {
            
            CTItem *fCTItem = [[CTItem alloc] initWithItemModel:[self.itemModelList objectAtIndex:i]];
            
            if (i < (count+1)/2) { // 前半
                
                [self.topStackView addArrangedSubview:fCTItem];
            } else { // 後半
                
                [self.bottomStackView addArrangedSubview:fCTItem];
            }
        }
    }
    
    // 調整第一列高度
    [self updateHeightOfFirstRow];
    
    // 調整第二列的顯示與否
    [self updateSecondRowVisible];
    
    // 調整第二列寬度
    [self updateWidthOfSecondRow];
    
    // 調整匡線
    [self updateSeparation];
}

//================================================================================
// 清空StackView
//================================================================================
- (void)stackViewClean {
    
    [self.topStackView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.bottomStackView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

//================================================================================
// 調整第一列高度
//================================================================================
- (void)updateHeightOfFirstRow {
    
    if (self.numberOfRow == 1) {
     
        self.topStackHeight.constant = self.frame.size.height/2;
    } else {
        
        self.topStackHeight.constant = 0;
    }
    
}

//================================================================================
// 調整第二列是否顯示
//================================================================================
- (void)updateSecondRowVisible {
    
    self.bottomStackView.hidden = (self.numberOfRow == 1) ? YES : NO;
    self.bottomStackBackgroundView.hidden = (self.numberOfRow == 1) ? YES : NO;
}

//================================================================================
// 調整第二列寬度
//================================================================================
- (void)updateWidthOfSecondRow {
    
    int count = (int)[self.itemModelList count];
    
    if (count%2 == 0) { // item數量為偶數
        
        self.bottomStackWidth.constant = 0;
    } else { // 奇數
        
        int itemCountPerRow = (count+1)/2;
        float itemWidth = self.topStackView.frame.size.width/itemCountPerRow + 1;
        self.bottomStackWidth.constant = -itemWidth;
    }
}

//================================================================================
// 匡線的調整
//================================================================================
- (void)updateSeparation {
    
    // 分線的顏色
    self.topStackBackgroundView.backgroundColor = self.separationColor;
    self.bottomStackBackgroundView.backgroundColor = self.separationColor;
    
    // 匡線的顯示
    switch (self.separationMode) {
        case SeparationMode_None:
            
            self.topStackView.spacing = 0;
            self.bottomStackView.spacing = 0;
            break;
        case SeparationMode_Vertical:
            
            self.topStackView.spacing = 1;
            self.bottomStackView.spacing = 1;
            break;
        default:
            break;
    }
}

@end
