//
//  CTItemListComponent.h
//  CTItemListComponentSample
//
//  Created by Jason on 2017/1/13.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTItemListModel.h"

@interface CTItemListComponent : UIView

@property (nonatomic, strong) NSArray *itemModelList;
@property (nonatomic, assign) NSInteger numberOfRow;
@property (nonatomic, assign) SeparationMode separationMode;
@property (nonatomic, strong) UIColor *separationColor;

@end
