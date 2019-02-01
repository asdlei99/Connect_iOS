////  CNCTranslateModel.m
//  Connect
//
//  Created by iizvv on 2018/11/28.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCTranslateModel.h"
#import "CNCSentencesModel.h"

@interface CNCTranslateModel ()

@end

@implementation CNCTranslateModel

- (void)cnc_translateWithString:(NSString *)string callBack:(void (^)(NSString *htmlString))sentences {
    [CNCNetwork getUrl:CNCGoogleTranslate(string) callBack:^(id success) {
        if (sentences) {
           NSArray<CNCSentencesModel *> *arr = [NSArray yy_modelArrayWithClass:[CNCSentencesModel class] json:success[@"sentences"]];
            NSMutableString *temp = [NSMutableString string];
            [arr enumerateObjectsUsingBlock:^(CNCSentencesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [temp appendString:obj.trans];
            }];
            sentences(temp);
        }
    }];
}

@end

