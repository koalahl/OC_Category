//
//  UITextView+Placehold.h
//  TTTextView
//
//  Created by HanLiu on 15/12/27.
//  Copyright © 2015年 HanLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Placehold)

@property (nonatomic,strong)UILabel * placeholdLabel;
@property (nonatomic,copy)NSString *placehold;

@end
