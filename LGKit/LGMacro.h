//
//  LGMacro.h
//  LGKit
//
//  Created by lg on 2019/12/26.
//  Copyright © 2019 lg. All rights reserved.
//

#ifndef LGMacro_h
#define LGMacro_h

#define lg_weakObj(obj) __weak type(obj) weak_##obj=obj
#define lg_strongObj(obj) __strong type(obj) strong_##obj=obj

#define lg_weakSelf __weak type(self) weakSelf=self
#define lg_strongSelf __strong type(weakSelf) strongSelf=weakSelf

#endif /* LGMacro_h */
