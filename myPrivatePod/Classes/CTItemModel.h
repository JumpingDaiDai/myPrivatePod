//
//  CTItemModel.h
//  CTItemListComponentSample
//
//  Created by Jason on 2017/1/16.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, StyleType) {
    
    StyleType_Normal = 0, // image and text
    StyleType_ImageOnly,
    StyleType_TextOnly,
};

typedef NS_ENUM(NSUInteger, ContentType) {
    
    ContentType_Image = 0,
    ContentType_Button
};

typedef void (^ButtonActionBlock)(void);

@interface CTItemModel : NSObject

@property (nonatomic, assign) StyleType styleType;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) ContentType contentType;
@property (nonatomic, copy) ButtonActionBlock buttonActionBlock;

- (instancetype)initWithStyleType:(StyleType)styleType contentType:(ContentType)contentType;

@end
