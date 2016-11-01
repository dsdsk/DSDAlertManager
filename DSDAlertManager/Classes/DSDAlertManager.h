//
//  DSDAlertManager.h
//  Pods
//
//  Created by dsdsk on 2016/10/30.
//

#import <UIKit/UIKit.h>

@interface DSDAlertManager : NSObject <UIAlertViewDelegate>

/**
 *  ダイアログ表示（OKボタンのみ）
 *
 *  @param parent  親のビューコントローラー
 *  @param title   ダイアログのタイトル
 *  @param message ダイアログのメッセージ
 *  @param ok      OKボタン押下時の処理ブロック
 */
+ (void)showAlert:(UIViewController *)parent title:(NSString *)title message:(NSString *)message ok:(void (^)(void))ok;

/**
 *  ダイアログ表示（OK、キャンセル）
 *
 *  @param parent  親のビューコントローラー
 *  @param title   ダイアログのタイトル
 *  @param message ダイアログのメッセージ
 *  @param ok      OKボタン押下時の処理ブロック
 *  @param cancel  キャンセルボタン押下時の処理ブロック
 */
+ (void)showAlert:(UIViewController *)parent title:(NSString *)title message:(NSString *)message ok:(void (^)(void))ok cancel:(void (^)(void))cancel;

/**
 *  ダイアログ表示（YES、NO）
 *
 *  @param parent  親のビューコントローラー
 *  @param title   ダイアログのタイトル
 *  @param message ダイアログのメッセージ
 *  @param yes     YESボタン押下時の処理ブロック
 *  @param no      NOボタン押下時の処理ブロック
 */
+ (void)showAlert:(UIViewController *)parent title:(NSString *)title message:(NSString *)message yes:(void (^)(void))yes no:(void (^)(void))no;

/**
 *  ダイアログ表示（YES、YESボタンのラベル、NO、NOボタンのラベル）
 *
 *  @param parent  親のビューコントローラー
 *  @param title   ダイアログのタイトル
 *  @param message ダイアログのメッセージ
 *  @param yesLabel YESボタンのラベル
 *  @param yes      YESボタン押下時の処理ブロック
 *  @param noLabel  NOボタンのラベル
 *  @param no       NOボタン押下時の処理ブロック
 */
+ (void)showAlert:(UIViewController *)parent title:(NSString *)title message:(NSString *)message yesLabel:(NSString *)yesLabel yes:(void (^)(void))yes noLabel:(NSString *)noLabel no:(void (^)(void))no;

/**
 *  入力ダイアログ表示（OK、キャンセル）
 *
 *  @param parent  親のビューコントローラー
 *  @param title   ダイアログのタイトル
 *  @param message ダイアログのメッセージ
 *  @param value   入力欄の初期値
 *  @param ok      OKボタン押下時の処理ブロック
 *  @param cancel  キャンセルボタン押下時の処理ブロック
 */
+ (void)showEditAlert:(UIViewController *)parent title:(NSString *)title message:(NSString *)message value:(NSString *)value ok:(void (^)(NSString *value))ok cancel:(void (^)(void))cancel;

/**
 *  ダイアログを閉じる
 */
+ (void)dismiss;

@end
