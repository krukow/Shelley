//
//  SYDOMFilter.h
//  Shelley
//
//  Created by Karl Krukow on 21/06/12.
//  Copyright (c) 2012 LessPainful. All rights reserved.
//

#import "SYArrayFilterTemplate.h"
#import "LPWebQuery.h"

@interface SYDOMFilter : SYArrayFilterTemplate

@property (assign,readonly) LPWebQueryType type;
@property (strong,readonly) NSString *query;


-(id)initWithType:(NSString *)type query:(NSString *)query;
@end
