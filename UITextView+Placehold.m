//
//  UITextView+Placehold.m
//  TTTextView
//
//  Created by HanLiu on 15/12/27.
//  Copyright © 2015年 HanLiu. All rights reserved.
//

#import "UITextView+Placehold.h"
#import <objc/runtime.h>

NSString const * kUITextViewPlaceholdLabel = @"kUITextViewPlaceholdLabel";
NSString const * kUITextViewPlacehold = @"kUITextViewPlacehold";

@interface UITextView ()

@end
@implementation UITextView (Placehold)

@dynamic placehold;

- (UILabel *)placeholdLabel{
    return  objc_getAssociatedObject(self, &kUITextViewPlaceholdLabel);

}
- (void)setPlaceholdLabel:(UILabel *)placeholdLabel{
    objc_setAssociatedObject(self, &kUITextViewPlaceholdLabel, placeholdLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (NSString *)placehold{
    return objc_getAssociatedObject(self, &kUITextViewPlacehold);

}

- (void)setPlacehold:(NSString *)placehold{
    objc_setAssociatedObject(self, &kUITextViewPlacehold, placehold, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([placehold isEqualToString:@""]) {
        [self removePlaceholdLabel];
    }
    else if (!self.placeholdLabel) {
        self.placeholdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
        self.placeholdLabel.textColor = [UIColor lightGrayColor];
        self.placeholdLabel.font = [UIFont systemFontOfSize:14];
        self.placeholdLabel.numberOfLines = 0;
        [self addSubview:self.placeholdLabel];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
        [self updatePlaceholdLabel];
    }else{
        [self updatePlaceholdLabel];
    }
    
   
    
}
- (void)updatePlaceholdLabel{
    self.placeholdLabel.text = self.placehold;

}
- (void)removePlaceholdLabel{
    [UIView animateWithDuration:0.2 animations:^{
        self.placeholdLabel.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.placeholdLabel removeFromSuperview];
        self.placeholdLabel = nil;
    }];
}
- (void)textViewDidBeginEditing:(NSNotification *)notify{
    NSLog(@"textViewDidBeginEditing");
    self.placeholdLabel.text = @"";
    NSLog(@"%@",self.placeholdLabel.text);
}

- (void)textViewDidEndEditing:(NSNotification *)notify{
    NSLog(@"textViewDidEndEditing");
    if (!self.text.length) {
        self.placeholdLabel.text = self.placehold;
    }

}
@end
