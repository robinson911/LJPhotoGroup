//
//  LJPhotoInfo.h
//  CommonDemo
//
//  Created by 孙伟伟 on 2017/7/26.
//  Copyright © 2017年 孙伟伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LJPhotoInfo : NSObject

//图片的Url数组
@property (nonatomic, strong) NSArray *ljUrlArray;

//图片总个数
@property (nonatomic, assign) NSInteger totalCount;

//当前选择项
@property (nonatomic, assign) NSInteger currentSelectIndex;

//全部ljImageview数组
@property (nonatomic, strong) NSArray *ljImageviewArray;

//当前的url
@property (nonatomic, copy)   NSString *ljUrlStr;
@property (nonatomic, strong) UIImageView *ljImageview;
@property (nonatomic, strong) UIImage *ljimage;

@end
