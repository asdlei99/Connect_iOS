////  CNCCollectionNormalLayout.m
//  Connect
//
//  Created by Dwang on 2018/10/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCCollectionNormalLayout.h"

@implementation CNCCollectionNormalLayout

- (instancetype)initWithSize:(CGSize)size {
    self = [super init];
    if (self) {
        self.itemSize = size;
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = CGFLOAT_MIN;
        self.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    return self;
}

@end
