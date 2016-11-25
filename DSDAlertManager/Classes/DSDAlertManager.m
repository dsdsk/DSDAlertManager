//
//  DSDAlertManager.m
//  Pods
//
//  Created by dsdsk on 2016/10/30.
//

#import "DSDAlertManager.h"

#define ALERT_BUTTON_OK @"OK"
#define ALERT_BUTTON_YES @"YES"
#define ALERT_BUTTON_NO @"NO"
#define ALERT_BUTTON_CANCEL @"Cancel"

@implementation DSDAlertManager

static UIAlertController *_alertController;
static void (^_okBlock)(void);
static void (^_cancelBlock)(void);
static void (^_yesBlock)(void);
static void (^_noBlock)(void);
static void (^_okValueBlock)(NSString *inputValue);

#pragma mark -

+ (void)dismiss
{
    [self dismissAlertController];
}

+ (void)showAlert:(UIViewController *)parent title:(NSString *)title message:(NSString *)message ok:(void (^)(void))ok
{
    _okBlock = ok;
    
    [self showAlertOkOnly:parent title:title message:message];
}

+ (void)showAlert:(UIViewController *)parent title:(NSString *)title message:(NSString *)message okLabel:(NSString *)okLabel ok:(void (^)(void))ok
{
    _okBlock = ok;
    
    [self showAlertCustomLabelOkOnly:parent title:title message:message okLabel:okLabel];
}

+ (void)showAlert:(UIViewController *)parent title:(NSString *)title message:(NSString *)message ok:(void (^)(void))ok cancel:(void (^)(void))cancel
{
    _okBlock = ok;
    _cancelBlock = cancel;
    
    [self showAlertOkAndCancel:parent title:title message:message];
}

+ (void)showAlert:(UIViewController *)parent title:(NSString *)title message:(NSString *)message yes:(void (^)(void))yes no:(void (^)(void))no
{
    _yesBlock = yes;
    _noBlock = no;
    
    [self showAlertYesAndNo:parent title:title message:message];
}

+ (void)showAlert:(UIViewController *)parent title:(NSString *)title message:(NSString *)message yesLabel:(NSString *)yesLabel yes:(void (^)(void))yes noLabel:(NSString *)noLabel no:(void (^)(void))no
{
    _yesBlock = yes;
    _noBlock = no;
    
    [self showAlertCustomLabelYesAndNo:parent title:title message:message yesLabel:yesLabel noLabel:noLabel];
}

+ (void)showEditAlert:(UIViewController *)parent title:(NSString *)title message:(NSString *)message value:(NSString *)value ok:(void (^)(NSString *value))ok cancel:(void (^)(void))cancel
{
    _okValueBlock = ok;
    _cancelBlock = cancel;
    
    [self showEditAlertOkAndCancel:parent title:title message:message value:value];
}

#pragma mark -

+ (void)dismissAlertController
{
    if(_alertController != nil){
        [_alertController dismissViewControllerAnimated:NO completion:nil];
        _alertController = nil;
    }
}

+ (void)showAlertOkOnly:(UIViewController *)parent title:(NSString *)title message:(NSString *)message
{
    _alertController = [UIAlertController alertControllerWithTitle:title
                                                           message:message
                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    [_alertController addAction:[UIAlertAction actionWithTitle:ALERT_BUTTON_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // okボタンが押された時の処理
        [self okButtonPushed];
    }]];
    
    [parent presentViewController:_alertController animated:YES completion:nil];
}

+ (void)showAlertCustomLabelOkOnly:(UIViewController *)parent title:(NSString *)title message:(NSString *)message okLabel:(NSString *)okLabel
{
    _alertController = [UIAlertController alertControllerWithTitle:title
                                                           message:message
                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    [_alertController addAction:[UIAlertAction actionWithTitle:okLabel style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // okボタンが押された時の処理
        [self okButtonPushed];
    }]];
    
    [parent presentViewController:_alertController animated:YES completion:nil];
}

+ (void)showAlertOkAndCancel:(UIViewController *)parent title:(NSString *)title message:(NSString *)message
{
    _alertController = [UIAlertController alertControllerWithTitle:title
                                                           message:message
                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    [_alertController addAction:[UIAlertAction actionWithTitle:ALERT_BUTTON_CANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
        [self cancelButtonPushed];
    }]];
    [_alertController addAction:[UIAlertAction actionWithTitle:ALERT_BUTTON_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // okボタンが押された時の処理
        [self okButtonPushed];
    }]];
    
    [parent presentViewController:_alertController animated:YES completion:nil];
}

+ (void)showAlertYesAndNo:(UIViewController *)parent title:(NSString *)title message:(NSString *)message
{
    _alertController = [UIAlertController alertControllerWithTitle:title
                                                           message:message
                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    [_alertController addAction:[UIAlertAction actionWithTitle:ALERT_BUTTON_NO style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // NOボタンが押された時の処理
        [self noButtonPushed];
    }]];
    [_alertController addAction:[UIAlertAction actionWithTitle:ALERT_BUTTON_YES style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // YESボタンが押された時の処理
        [self yesButtonPushed];
    }]];
    
    [parent presentViewController:_alertController animated:YES completion:nil];
}

+ (void)showAlertCustomLabelYesAndNo:(UIViewController *)parent title:(NSString *)title message:(NSString *)message yesLabel:(NSString *)yesLabel noLabel:(NSString *)noLabel
{
    _alertController = [UIAlertController alertControllerWithTitle:title
                                                           message:message
                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    [_alertController addAction:[UIAlertAction actionWithTitle:noLabel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // NOボタンが押された時の処理
        [self noButtonPushed];
    }]];
    [_alertController addAction:[UIAlertAction actionWithTitle:yesLabel style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // YESボタンが押された時の処理
        [self yesButtonPushed];
    }]];
    
    [parent presentViewController:_alertController animated:YES completion:nil];
}

+ (void)showEditAlertOkAndCancel:(UIViewController *)parent title:(NSString *)title message:(NSString *)message value:(NSString *)value
{
    _alertController = [UIAlertController alertControllerWithTitle:title
                                                           message:message
                                                    preferredStyle:UIAlertControllerStyleAlert];
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = value;
    }];
    
    [_alertController addAction:[UIAlertAction actionWithTitle:ALERT_BUTTON_CANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
        [self cancelButtonPushed];
    }]];
    [_alertController addAction:[UIAlertAction actionWithTitle:ALERT_BUTTON_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // okボタンが押された時の処理
        [self okValueButtonPushed:((UITextField *)[_alertController.textFields objectAtIndex:0]).text];
    }]];
    
    [parent presentViewController:_alertController animated:YES completion:nil];
}

#pragma mark - ボタンブロック

+ (void)okButtonPushed
{
    if(_okBlock != nil){
        // ダイアログの入れ子に対応するため、一旦バックグラウンドで処理を通してダイアログを閉じさせてから、ブロック処理をメインスレッドで実行
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^(){
            dispatch_async(dispatch_get_main_queue(), ^{
                _okBlock();
            });
        });
    }
    _alertController = nil;
}

+ (void)cancelButtonPushed
{
    if(_cancelBlock != nil){
        // ダイアログの入れ子に対応するため、一旦バックグラウンドで処理を通してダイアログを閉じさせてから、ブロック処理をメインスレッドで実行
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^(){
            dispatch_async(dispatch_get_main_queue(), ^{
                _cancelBlock();
            });
        });
    }
    _alertController = nil;
}

+ (void)yesButtonPushed
{
    if(_yesBlock != nil){
        // ダイアログの入れ子に対応するため、一旦バックグラウンドで処理を通してダイアログを閉じさせてから、ブロック処理をメインスレッドで実行
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^(){
            dispatch_async(dispatch_get_main_queue(), ^{
                _yesBlock();
            });
        });
    }
    _alertController = nil;
}

+ (void)noButtonPushed
{
    if(_noBlock != nil){
        // ダイアログの入れ子に対応するため、一旦バックグラウンドで処理を通してダイアログを閉じさせてから、ブロック処理をメインスレッドで実行
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^(){
            dispatch_async(dispatch_get_main_queue(), ^{
                _noBlock();
            });
        });
    }
    _alertController = nil;
}

+ (void)okValueButtonPushed:(NSString *)value
{
    if(_okValueBlock != nil){
        // ダイアログの入れ子に対応するため、一旦バックグラウンドで処理を通してダイアログを閉じさせてから、ブロック処理をメインスレッドで実行
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^(){
            dispatch_async(dispatch_get_main_queue(), ^{
                _okValueBlock(value);
            });
        });
    }
    _alertController = nil;
}

@end
