#import "VViewController.h"

@implementation VViewController

- (void)viewDidLoad{
    self.maskTextFieldTelephone.mask = @"(##) ####-####";
    self.maskTextFieldDateAndHour.mask = @"##/##/#### ##:##:##";
    self.maskTextFieldDate.mask = @"##/##/####";
    self.maskTextFieldHour.mask = @"##:##:##";
    //[self.maskTextFieldDate setTextWithMask:@"12122012"];
    //[self.maskTextFieldTelephone setTextWithMask:@"1111111111111111111"];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    VMaskTextField * maskTextField = (VMaskTextField*) textField;
   return  [maskTextField shouldChangeCharactersInRange:range replacementString:string];
}

@end
