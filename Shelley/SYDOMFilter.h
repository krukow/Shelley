//
//  SYDOMFilter.h
//  Shelley
//
//  Created by Karl Krukow on 21/06/12.
//  Copyright (c) 2012 LessPainful. All rights reserved.
//

#import "SYArrayFilterTemplate.h"

@interface SYDOMFilter : SYArrayFilterTemplate

@property (strong,readonly) NSString *type;
@property (strong,readonly) NSString *query;


-(id)initWithType:(NSString *)type query:(NSString *)query;
@end
