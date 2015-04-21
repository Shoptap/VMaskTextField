#import "VMaskTextField.h"

NSString * kVMaskTextFieldDefaultChar = @"#";

@implementation VMaskTextField

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.defaultCharMask = kVMaskTextFieldDefaultChar;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.defaultCharMask = kVMaskTextFieldDefaultChar;
    }
    return self;
}

-(void) setTextWithMask:(NSString *) text{
    NSAssert(_mask!=nil, @"Mask is nil.");
    for (int i = 0; i < text.length; i++) {
        if (self.text.length == _mask.length) {
            break;
        }
        [self shouldChangeCharactersInRange:NSMakeRange(i, 0) replacementString:[NSString stringWithFormat:@"%c",[text characterAtIndex:i]]];
    }
}

- (void)setMask:(NSString *)mask {
    _mask = mask;
    self.text = mask;
}

- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // User deleted something
    NSString * currentTextDigited = [self.text stringByReplacingCharactersInRange:range withString:string];
    currentTextDigited = [currentTextDigited stringByReplacingCharactersInRange:NSMakeRange(currentTextDigited.length - _mask.length + self.lastMaskLocation, _mask.length - self.lastMaskLocation) withString:@""];

    if (string.length == 0) {
        while (currentTextDigited.length > 0 && !isnumber([currentTextDigited characterAtIndex:currentTextDigited.length-1])) {
            currentTextDigited = [currentTextDigited substringToIndex:[currentTextDigited length] - 1];
        }

        // Save the place we stopped so we can cut it off when we come back here
        self.lastMaskLocation = currentTextDigited.length;

        // Tack the rest of the mask on the end
        self.text = [currentTextDigited stringByAppendingString:[_mask substringWithRange:NSMakeRange(self.lastMaskLocation, _mask.length - self.lastMaskLocation)]];

        UITextPosition *start = [self positionFromPosition:[self beginningOfDocument] offset:self.lastMaskLocation];
        [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:[self positionFromPosition:start offset:0]]];

        return NO;
    }

    // User is trying to type more characters than the mask allows
    NSMutableString * returnText = [[NSMutableString alloc] init];
    if (currentTextDigited.length > _mask.length) {
        return NO;
    }

    // Build the return string using the mask
    int loc = 0;
    BOOL needAppend = NO;
    for (; loc < currentTextDigited.length; loc++) {
        unichar  currentCharMask = [_mask characterAtIndex:loc];
        unichar  currentChar = [currentTextDigited characterAtIndex:loc];

        if (isnumber(currentChar) && currentCharMask == '#') {
            [returnText appendString:[NSString stringWithFormat:@"%c",currentChar]];
        } else {
            if (currentCharMask == '#') {
                break;
            }
            if (isnumber(currentChar) && currentCharMask!= currentChar) {
                needAppend = YES;
            }
            [returnText appendString:[NSString stringWithFormat:@"%c",currentCharMask]];
        }
    }

    // Add any characters we need at the end (things that aren't a number)
    for (; loc < _mask.length; loc++) {
        unichar currentCharMask = [_mask characterAtIndex:loc];

        if (currentCharMask != '#') {
            [returnText appendString:[NSString stringWithFormat:@"%c",currentCharMask]];
        } else {
            break;
        }
    }

    // ???
    if (needAppend) {
        [returnText appendString:string];
    }

    // Tack the rest of the mask on the end
    [returnText appendString:[_mask substringWithRange:NSMakeRange(loc, _mask.length - loc)]];

    // Save the place we stopped so we can cut it off when we come back here
    self.lastMaskLocation = loc;

    self.text = returnText;
    UITextPosition *start = [self positionFromPosition:[self beginningOfDocument] offset:loc];
    [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:[self positionFromPosition:start offset:0]]];

    return NO;
}

-(double) rawToDouble{
    return [_raw doubleValue];
}

-(float) rawToFloat{
    return [_raw floatValue];
}

-(NSInteger) rawToInteger{
    return [_raw intValue];
}

-(NSDate *)rawToDate:(NSDateFormatter *)formatter{
    NSDate *date = [formatter dateFromString:_raw];
    return date;
}

@end
