//
//  Emoji.m
//  Emoji
//
//  Created by Aliksandr Andrashuk on 26.10.12.
//  Copyright (c) 2012 Aliksandr Andrashuk. All rights reserved.
//

#import "Emoji.h"
#import "EmojiEmoticons.h"
#import "EmojiMapSymbols.h"
#import "EmojiPictographs.h"
#import "EmojiTransport.h"

@implementation Emoji
+ (NSString *)emojiWithCode:(int)code {
    int sym = EMOJI_CODE_TO_SYMBOL(code);
    return [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
}
+ (NSArray *)allEmoji {
    NSMutableArray *array = [NSMutableArray new];
    [array addObjectsFromArray:[EmojiEmoticons allEmoticons]];
    [array addObjectsFromArray:[EmojiMapSymbols allMapSymbols]];
    [array addObjectsFromArray:[EmojiPictographs allPictographs]];
    [array addObjectsFromArray:[EmojiTransport allTransport]];
    
    return array;
}

+ (BOOL)isEmojStr:(NSString *)emojStr{
    //    for(NSInteger i=0; i<emojStrs.count; i++){
    //        if ([emojStr isEqualToString:[emojStrs objectAtIndex:i]]) {
    //            return YES;
    //        }
    //    }
    
    const unichar hs = [emojStr characterAtIndex:0];
    // surrogate pair
    BOOL returnValue = NO;
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (emojStr.length > 1) {
            const unichar ls = [emojStr characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    } else if (emojStr.length > 1) {
        const unichar ls = [emojStr characterAtIndex:1];
        if (ls == 0x20e3) {
            returnValue = YES;
        }
        
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        }
    }
    return returnValue;
}

/*
 - (void)emojDelete
 {
 NSString *chatText = self.textInputView.text;
 if (chatText.length >= 2){
 NSString *subStr = [chatText substringFromIndex:chatText.length-2];
 if ([EmojHelper isEmojStr:subStr]) {
 self.textInputView.text = [chatText substringToIndex:chatText.length-2];
 [self textViewDidChange:self.textInputView];
 return;
 }
 }
 
 if (chatText.length > 0) {
 self.textInputView.text = [chatText substringToIndex:chatText.length-1];
 }
 }

 */

@end
