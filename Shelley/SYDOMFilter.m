//
//  SYDOMFilter.m
//  Shelley
//
//  Created by Karl Krukow on 21/06/12.
//  Copyright (c) 2012 LessPainful. All rights reserved.
//

#import "SYDOMFilter.h"

//see https://github.com/calabash/calabash-js
static NSString *LP_QUERY_JS = @"(function(){function isHostMethod(object,property){var t=typeof object[property];return t==='function'||(!!(t==='object'&&object[property]))||t==='unknown';}var NODE_TYPES={1:'ELEMENT_NODE',2:'ATTRIBUTE_NODE',3:'TEXT_NODE',9:'DOCUMENT_NODE'};function computeRectForNode(object){var res={},boundingBox;if(isHostMethod(object,'getBoundingClientRect')){boundingBox=object.getBoundingClientRect();res['rect']=boundingBox;res['rect'].center_x=boundingBox.left+Math.floor(boundingBox.width/2);res['rect'].center_y=boundingBox.top+Math.floor(boundingBox.height/2);}res.nodeType=NODE_TYPES[object.nodeType]||res.nodeType+' (Unexpected)';res.nodeName=object.nodeName;res.id=object.id||'';res['class']=object.className||'';if(object.href){res.href=object.href;}if(res.nodeName.toLowerCase()==='input'){res.value=object.value;}res.html=object.outerHTML||'';res.textContent=object.textContent;return res;}function toJSON(object){var res,i,N,spanEl,parentEl;if(typeof object==='undefined'){throw {message:'Calling toJSON with undefined'};}else{if(object instanceof Text){parentEl=object.parentElement;if(parentEl){spanEl=document.createElement('calabash');spanEl.style.display='inline';spanEl.innerHTML=object.textContent;parentEl.replaceChild(spanEl,object);res=computeRectForNode(spanEl);res.nodeType=NODE_TYPES[object.nodeType];delete res.nodeName;delete res.id;delete res['class'];parentEl.replaceChild(object,spanEl);}else{res=object;}}else{if(object instanceof Node){res=computeRectForNode(object);}else{if(object instanceof NodeList||(typeof object=='object'&&object&&typeof object.length==='number'&&object.length>0&&typeof object[0]!=='undefined')){res=[];for(i=0,N=object.length;i<N;i++){res[i]=toJSON(object[i]);}}else{res=object;}}}}return res;}var exp='%@',queryType='%@',nodes=null,res=[],i,N;try{if(queryType==='xpath'){nodes=document.evaluate(exp,document,null,XPathResult.ORDERED_NODE_SNAPSHOT_TYPE,null);for(i=0,N=nodes.snapshotLength;i<N;i++){res[i]=nodes.snapshotItem(i);}}else{res=document.querySelectorAll(exp);}}catch(e){return JSON.stringify({error:'Exception while running query: '+exp,details:e.toString()});}return JSON.stringify(toJSON(res));})();";


@implementation SYDOMFilter

@synthesize type=_type;
@synthesize query=_query;


-(id)initWithType:(NSString *)type query:(NSString *)query
{
    self = [super init];
    if (self) {
        _type = [type copy];
        _query = [query copy];
    }
    return self;   
}

-(NSArray *)applyToView:(UIView *)view{
    if (![view isKindOfClass:[UIWebView class]])
    {
        return [NSArray array];
    }
    UIWebView *webView = (UIWebView *)view;
    
    NSString *jsString = LP_QUERY_JS;
    if ([_type isEqualToString:@"xpath"])
    {
        jsString = [NSString stringWithFormat:jsString, 
                    _query, 
                    @"xpath"];                        
    }
    else if ([_type isEqualToString:@"css"])
    {
        jsString = [NSString stringWithFormat:jsString, 
                    _query, 
                    @"css"];                        
    }
    NSMutableArray *res = [NSMutableArray arrayWithCapacity:32];
    BOOL found = [self resultsForWebView: webView query:jsString result:res];
    if (!found)
    {
        //TODO you may want to handle this in a special way
        //e.g., searching for text in some cases
    }      
    return res;    
}

-(BOOL) resultsForWebView:(UIWebView *)webView query:(NSString *)jsString result:(NSMutableArray *)res
{
    NSString *output = [webView stringByEvaluatingJavaScriptFromString:jsString];
    //This is actually JSON, is it ok to add a JSON parser dependency?
    //TODO: Pete advise.
    //NSArray *query = ...
    
    NSLog(@"DOM query output:\n%@",output);
    /*
    CGPoint webViewPoint = [webView convertPoint:webView.bounds.origin 
                                          toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
    
    BOOL anyResults = NO;
    NSLog(@"%@", CGPointCreateDictionaryRepresentation(webViewPoint));
    for (NSDictionary *d in query) 
    {
     //This also requires that shelly can handle Dictionary results
        NSMutableDictionary *dres = [NSMutableDictionary dictionaryWithDictionary:d];
        CGFloat left = [[dres valueForKeyPath:@"rect.left"] floatValue];
        CGFloat top = [[dres valueForKeyPath:@"rect.top"] floatValue];
        CGFloat width =  [[dres valueForKeyPath:@"rect.width"] floatValue];
        CGFloat height =  [[dres valueForKeyPath:@"rect.height"] floatValue];
        
        
        CGPoint center = CGPointMake(left+width/2.0, top+height/2.0);            
        CGPoint screenCenter = CGPointMake(webViewPoint.x + center.x, webViewPoint.y + center.y);            
        if (!CGPointEqualToPoint(CGPointZero, center) && [webView pointInside:center withEvent:nil])
        {
            anyResults = YES;
            NSDictionary *centerDict = (NSDictionary*)CGPointCreateDictionaryRepresentation(screenCenter);
            [dres setValue:[centerDict autorelease] forKey:@"center"];
            [dres setValue:webView forKey:@"webView"];
            [res addObject:dres];                
        }
    }
     */
//    return anyResults;
    return NO;
}



@end
