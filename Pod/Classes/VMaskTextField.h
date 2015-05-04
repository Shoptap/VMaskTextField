#import <UIKit/UIKit.h>

@interface VMaskTextField : UITextField

@property (nonatomic,strong) NSString * mask;
@property (nonatomic,strong) NSString * placeholderMask;
@property (nonatomic,strong) UIColor * placeholderColor;
@property (nonatomic,strong) NSString * raw;
@property (nonatomic,strong) NSString * defaultCharMask;
@property (nonatomic,assign) NSInteger lastMaskLocation;

-(double) rawToDouble;
-(float) rawToFloat;
-(NSInteger) rawToInteger;
-(NSDate *)rawToDate:(NSDateFormatter *)formatter;

- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
-(void) setTextWithMask:(NSString *) text;

- (void)setSelectedRange:(NSRange)range;
- (NSRange)endOfEnteredText;

@end
