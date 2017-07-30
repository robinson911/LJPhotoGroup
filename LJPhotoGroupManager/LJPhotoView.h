//
//  LJPhotoView.h
//  CommonDemo
//
//  Created by 孙伟伟 on 2017/7/26.
//  Copyright © 2017年 孙伟伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJPhotoInfo.h"

@interface LJPhotoView:UIScrollView

@property (nonatomic, strong) UIImageView *ljImageview;

//在LJPhotoGroupView中切换图片时，重新设置info信息
- (void)setCurrentImageview:(LJPhotoInfo*)info;

@end


