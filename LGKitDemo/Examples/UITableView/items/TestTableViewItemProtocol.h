//
//  TestTableViewItemProtocol.h
//  LGKitDemo
//
//  Created by lg on 2019/12/26.
//  Copyright © 2019 lg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TestTableViewItemProtocol <NSObject>

@property(nonatomic,readonly) Class cellClass;

@end

NS_ASSUME_NONNULL_END
