//
//  CTItem.m
//  CTItemListComponentSample
//
//  Created by Jason on 2017/1/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "CTItem.h"

@interface CTItem()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UIButton *button;

@property (nonatomic, copy) ButtonActionBlock buttonActionBlock;

@end

@implementation CTItem

#pragma mark -
#pragma mark - Life-cycle methods
#pragma mark -
//================================================================================
//
//================================================================================
- (instancetype)initWithItemModel:(CTItemModel *)itemModel {
    
    self = [super init];
    if (self) {
        
        [self viewInitWithItemModel:itemModel];
        [self updateItemModel:itemModel];
    }
    
    return self;
}


#pragma mark -
#pragma mark - Instance methods
#pragma mark -
//================================================================================
// 視圖初始化
//================================================================================
- (void)viewInitWithItemModel:(CTItemModel *)itemModel {
    
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Xib_resource" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    CTItem *itemView;
    switch (itemModel.styleType) {
        case StyleType_Normal:
            // 取得xibView 使用Name來取得
            
            itemView = [[bundle loadNibNamed:@"CTItemNormal"
                                                                         owner:self
                                                                       options:nil]
                        objectAtIndex:0];
            break;
        case StyleType_ImageOnly:
            // 取得xibView 使用Name來取得
            itemView = [[bundle loadNibNamed:@"CTItemImage"
                                                                         owner:self
                                                                       options:nil]
                        objectAtIndex:0];
            break;
        case StyleType_TextOnly:
            // 取得xibView 使用Name來取得
            itemView = [[bundle loadNibNamed:@"CTItemText"
                                                                         owner:self
                                                                       options:nil]
                        objectAtIndex:0];
            break;
            
        default:
            break;
    }
    
    // 設定該xibView的Frame
    itemView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    itemView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // 將xibView加入
    [self addSubview:itemView];
}

//================================================================================
// 外部資料注入
//================================================================================
- (void)updateItemModel:(CTItemModel*)itemModel {
    
    self.imageView.image = itemModel.image;
    self.title.text = itemModel.title;
    self.title.font = itemModel.font;
    self.buttonActionBlock = itemModel.buttonActionBlock;

    // 調整Item的類型
    [self updateContentType:itemModel.contentType];
}

//================================================================================
// 調整Item的類型
//================================================================================
- (void)updateContentType:(ContentType)contentType {
    
    switch (contentType) {
        case ContentType_Image:
            
            self.button.hidden = YES;
            break;
        case ContentType_Button:
            
            self.button.hidden = NO;
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark - Button action
#pragma mark -
//================================================================================
//
//================================================================================
- (IBAction)itemIsPressed:(id)sender {
    
    self.buttonActionBlock();
}

@end
