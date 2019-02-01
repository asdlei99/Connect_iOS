////  CNCAsymptoticLabel.m
//  Connect
//
//  Created by Dwang on 2018/9/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCAsymptoticLabel.h"

@interface CNCAsymptoticLabel ()

@end

@implementation CNCAsymptoticLabel

- (void)cnc_show {
   [[[NSThread alloc]initWithTarget:self selector:@selector(cnc_asymptoticLabel) object:nil] start];
}

- (void)cnc_asymptoticLabel {
    for (int i = 0; i < self.message.length; i ++) {
        [self performSelectorOnMainThread:@selector(cnc_refershText:) withObject:[self.message substringWithRange:NSMakeRange(0, i+1)] waitUntilDone:YES];
        [NSThread sleepForTimeInterval:(self.timeInterval>0?self.timeInterval:.3f)];
    }
}

- (void)cnc_refershText:(NSString *)text {
    self.text = text;
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((self.timeInterval>0?self.timeInterval:.3f) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (ISEqualToString(weakSelf.text, weakSelf.message)) {
            if (weakSelf.cnc_endCallBack) {
                weakSelf.cnc_endCallBack(weakSelf);
            }
        }
    });
}

@end
