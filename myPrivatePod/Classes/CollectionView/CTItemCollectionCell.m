//
//  CTItemCollectionCell.m
//  CTItemListComponentSample
//
//  Created by Jason on 2017/1/18.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "CTItemCollectionCell.h"

@interface CTItemCollectionCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UIButton *button;

@property (nonatomic, copy) ButtonActionBlock buttonActionBlock;

@end

@implementation CTItemCollectionCell

//================================================================================
// 外部資料注入
//================================================================================
- (void)setItemModel:(CTItemModel *)itemModel {
    
    _imageView.image = itemModel.image;
    _title.text = itemModel.title;
    _title.font = itemModel.font;
    _buttonActionBlock = itemModel.buttonActionBlock;
    
    // 調整Item的類型
    [self updateContentType:itemModel.contentType];
}

#pragma mark -
#pragma mark - Instance methods
#pragma mark -
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
