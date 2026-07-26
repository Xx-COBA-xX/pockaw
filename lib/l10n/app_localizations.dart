import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Pockaw'**
  String get appName;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @systemMode.
  ///
  /// In en, this message translates to:
  /// **'System Mode'**
  String get systemMode;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalance;

  /// No description provided for @myBalance.
  ///
  /// In en, this message translates to:
  /// **'My Balance'**
  String get myBalance;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @addTransaction.
  ///
  /// In en, this message translates to:
  /// **'New Transaction'**
  String get addTransaction;

  /// No description provided for @editTransaction.
  ///
  /// In en, this message translates to:
  /// **'Edit Transaction'**
  String get editTransaction;

  /// No description provided for @deleteTransaction.
  ///
  /// In en, this message translates to:
  /// **'Delete Transaction'**
  String get deleteTransaction;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get confirmDelete;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @monthlyReport.
  ///
  /// In en, this message translates to:
  /// **'Monthly Report'**
  String get monthlyReport;

  /// No description provided for @weeklyReport.
  ///
  /// In en, this message translates to:
  /// **'Weekly Report'**
  String get weeklyReport;

  /// No description provided for @yearlyReport.
  ///
  /// In en, this message translates to:
  /// **'Yearly Report'**
  String get yearlyReport;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @budgets.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get budgets;

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @backupAndRestore.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get backupAndRestore;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @developerPortal.
  ///
  /// In en, this message translates to:
  /// **'Developer Portal'**
  String get developerPortal;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning,'**
  String get goodMorning;

  /// No description provided for @noWalletSelected.
  ///
  /// In en, this message translates to:
  /// **'No wallet selected.'**
  String get noWalletSelected;

  /// No description provided for @noTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet.'**
  String get noTransactionsYet;

  /// No description provided for @cashFlow.
  ///
  /// In en, this message translates to:
  /// **'Cash Flow'**
  String get cashFlow;

  /// No description provided for @spendingByCategory.
  ///
  /// In en, this message translates to:
  /// **'Spending by Category'**
  String get spendingByCategory;

  /// No description provided for @detailedFinancesView.
  ///
  /// In en, this message translates to:
  /// **'Detailed view of your finances'**
  String get detailedFinancesView;

  /// No description provided for @breakdownByCategory.
  ///
  /// In en, this message translates to:
  /// **'Breakdown of your spending by category'**
  String get breakdownByCategory;

  /// No description provided for @totalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total Spent'**
  String get totalSpent;

  /// No description provided for @noTransactionToDisplay.
  ///
  /// In en, this message translates to:
  /// **'No transaction to display'**
  String get noTransactionToDisplay;

  /// No description provided for @weeklyCashFlow.
  ///
  /// In en, this message translates to:
  /// **'Weekly Cash Flow'**
  String get weeklyCashFlow;

  /// No description provided for @comparisonIncomeExpenseMonth.
  ///
  /// In en, this message translates to:
  /// **'Comparison of income and expenses this month'**
  String get comparisonIncomeExpenseMonth;

  /// No description provided for @noTransactionDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No transaction data available'**
  String get noTransactionDataAvailable;

  /// No description provided for @myBudgets.
  ///
  /// In en, this message translates to:
  /// **'My Budgets'**
  String get myBudgets;

  /// No description provided for @noBudgetsRecordedYet.
  ///
  /// In en, this message translates to:
  /// **'No budgets recorded yet.'**
  String get noBudgetsRecordedYet;

  /// No description provided for @noTransactionsValidDates.
  ///
  /// In en, this message translates to:
  /// **'No transactions with valid dates found.'**
  String get noTransactionsValidDates;

  /// No description provided for @topTransactions.
  ///
  /// In en, this message translates to:
  /// **'Top Transactions'**
  String get topTransactions;

  /// No description provided for @setBudgetPeriod.
  ///
  /// In en, this message translates to:
  /// **'Set a budget period'**
  String get setBudgetPeriod;

  /// No description provided for @createBudget.
  ///
  /// In en, this message translates to:
  /// **'Create Budget'**
  String get createBudget;

  /// No description provided for @editBudget.
  ///
  /// In en, this message translates to:
  /// **'Edit Budget'**
  String get editBudget;

  /// No description provided for @deleteBudget.
  ///
  /// In en, this message translates to:
  /// **'Delete Budget'**
  String get deleteBudget;

  /// No description provided for @markBudgetRoutine.
  ///
  /// In en, this message translates to:
  /// **'Mark this budget as routine'**
  String get markBudgetRoutine;

  /// No description provided for @noNeedCreateEveryTime.
  ///
  /// In en, this message translates to:
  /// **'No need to create this budget every time.'**
  String get noNeedCreateEveryTime;

  /// No description provided for @saveBudget.
  ///
  /// In en, this message translates to:
  /// **'Save Budget'**
  String get saveBudget;

  /// No description provided for @budgetNotFound.
  ///
  /// In en, this message translates to:
  /// **'Budget Not Found'**
  String get budgetNotFound;

  /// No description provided for @budgetDetailsCouldNotBeLoaded.
  ///
  /// In en, this message translates to:
  /// **'Budget details could not be loaded.'**
  String get budgetDetailsCouldNotBeLoaded;

  /// No description provided for @budgetReport.
  ///
  /// In en, this message translates to:
  /// **'Budget Report'**
  String get budgetReport;

  /// No description provided for @loadingBudget.
  ///
  /// In en, this message translates to:
  /// **'Loading Budget...'**
  String get loadingBudget;

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data'**
  String get errorLoadingData;

  /// No description provided for @savingsGoals.
  ///
  /// In en, this message translates to:
  /// **'Savings Goals'**
  String get savingsGoals;

  /// No description provided for @noSavingsGoalsSetUp.
  ///
  /// In en, this message translates to:
  /// **'No savings goals set up yet.'**
  String get noSavingsGoalsSetUp;

  /// No description provided for @createGoal.
  ///
  /// In en, this message translates to:
  /// **'Create Goal'**
  String get createGoal;

  /// No description provided for @editGoal.
  ///
  /// In en, this message translates to:
  /// **'Edit Goal'**
  String get editGoal;

  /// No description provided for @goalTitle.
  ///
  /// In en, this message translates to:
  /// **'Goal Title'**
  String get goalTitle;

  /// No description provided for @targetAmount.
  ///
  /// In en, this message translates to:
  /// **'Target Amount'**
  String get targetAmount;

  /// No description provided for @saveGoal.
  ///
  /// In en, this message translates to:
  /// **'Save Goal'**
  String get saveGoal;

  /// No description provided for @pinnedGoals.
  ///
  /// In en, this message translates to:
  /// **'Pinned Goals'**
  String get pinnedGoals;

  /// No description provided for @noPinnedGoals.
  ///
  /// In en, this message translates to:
  /// **'No pinned goals'**
  String get noPinnedGoals;

  /// No description provided for @allTransactions.
  ///
  /// In en, this message translates to:
  /// **'All Transactions'**
  String get allTransactions;

  /// No description provided for @noTransactionsFound.
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get noTransactionsFound;

  /// No description provided for @filterTransactions.
  ///
  /// In en, this message translates to:
  /// **'Filter Transactions'**
  String get filterTransactions;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @editAccount.
  ///
  /// In en, this message translates to:
  /// **'Edit Account'**
  String get editAccount;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountName;

  /// No description provided for @initialBalance.
  ///
  /// In en, this message translates to:
  /// **'Initial Balance'**
  String get initialBalance;

  /// No description provided for @saveAccount.
  ///
  /// In en, this message translates to:
  /// **'Save Account'**
  String get saveAccount;

  /// No description provided for @selectWallet.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get selectWallet;

  /// No description provided for @createNewWallet.
  ///
  /// In en, this message translates to:
  /// **'Create New Wallet'**
  String get createNewWallet;

  /// No description provided for @permanentlyDeleteData.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your data'**
  String get permanentlyDeleteData;

  /// No description provided for @confirmAccountDeletion.
  ///
  /// In en, this message translates to:
  /// **'Confirm Account Deletion'**
  String get confirmAccountDeletion;

  /// No description provided for @actionCannotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get actionCannotBeUndone;

  /// No description provided for @backupData.
  ///
  /// In en, this message translates to:
  /// **'Backup Data'**
  String get backupData;

  /// No description provided for @creatingLocalBackup.
  ///
  /// In en, this message translates to:
  /// **'Creating local backup...'**
  String get creatingLocalBackup;

  /// No description provided for @uploadingToDrive.
  ///
  /// In en, this message translates to:
  /// **'Uploading to Drive...'**
  String get uploadingToDrive;

  /// No description provided for @restoreData.
  ///
  /// In en, this message translates to:
  /// **'Restore Data'**
  String get restoreData;

  /// No description provided for @restoringFromZip.
  ///
  /// In en, this message translates to:
  /// **'Restoring from ZIP...'**
  String get restoringFromZip;

  /// No description provided for @restoreCompletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Restore completed successfully.'**
  String get restoreCompletedSuccessfully;

  /// No description provided for @pickImage.
  ///
  /// In en, this message translates to:
  /// **'Pick Image'**
  String get pickImage;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @noChecklistItems.
  ///
  /// In en, this message translates to:
  /// **'No checklist items.'**
  String get noChecklistItems;

  /// No description provided for @goalChecklist.
  ///
  /// In en, this message translates to:
  /// **'Goal Checklist'**
  String get goalChecklist;

  /// No description provided for @holdItemToShowOptions.
  ///
  /// In en, this message translates to:
  /// **'Hold item to show options'**
  String get holdItemToShowOptions;

  /// No description provided for @filterChecklist.
  ///
  /// In en, this message translates to:
  /// **'Filter Checklist'**
  String get filterChecklist;

  /// No description provided for @titleAsc.
  ///
  /// In en, this message translates to:
  /// **'Title (A-Z)'**
  String get titleAsc;

  /// No description provided for @titleDesc.
  ///
  /// In en, this message translates to:
  /// **'Title (Z-A)'**
  String get titleDesc;

  /// No description provided for @cheapest.
  ///
  /// In en, this message translates to:
  /// **'Cheapest'**
  String get cheapest;

  /// No description provided for @mostExpensive.
  ///
  /// In en, this message translates to:
  /// **'Most Expensive'**
  String get mostExpensive;

  /// No description provided for @completedChecklist.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedChecklist;

  /// No description provided for @addChecklistItem.
  ///
  /// In en, this message translates to:
  /// **'Add Checklist Item'**
  String get addChecklistItem;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @budgetDetails.
  ///
  /// In en, this message translates to:
  /// **'Budget Details'**
  String get budgetDetails;

  /// No description provided for @noBudgetFound.
  ///
  /// In en, this message translates to:
  /// **'Budget details could not be loaded.'**
  String get noBudgetFound;

  /// No description provided for @manageCategories.
  ///
  /// In en, this message translates to:
  /// **'Manage Categories'**
  String get manageCategories;

  /// No description provided for @noCategoriesFound.
  ///
  /// In en, this message translates to:
  /// **'No categories found. Add one!'**
  String get noCategoriesFound;

  /// No description provided for @chooseCurrency.
  ///
  /// In en, this message translates to:
  /// **'Choose Currency'**
  String get chooseCurrency;

  /// No description provided for @noCurrenciesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No currencies available.'**
  String get noCurrenciesAvailable;

  /// No description provided for @iconType.
  ///
  /// In en, this message translates to:
  /// **'Icon Type'**
  String get iconType;

  /// No description provided for @emoji.
  ///
  /// In en, this message translates to:
  /// **'Emoji'**
  String get emoji;

  /// No description provided for @asset.
  ///
  /// In en, this message translates to:
  /// **'Asset'**
  String get asset;

  /// No description provided for @initial.
  ///
  /// In en, this message translates to:
  /// **'Initial'**
  String get initial;

  /// No description provided for @selectCategoryIcon.
  ///
  /// In en, this message translates to:
  /// **'Select Category Icon'**
  String get selectCategoryIcon;

  /// No description provided for @noCategoryIconsFound.
  ///
  /// In en, this message translates to:
  /// **'No category icons found.'**
  String get noCategoryIconsFound;

  /// No description provided for @imagePickerPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Your selected image is used only to personalize your profile within this app. It is never transmitted, uploaded, or shared outside your device.'**
  String get imagePickerPrivacyNote;

  /// No description provided for @backupHistory.
  ///
  /// In en, this message translates to:
  /// **'Backup History'**
  String get backupHistory;

  /// No description provided for @backupFolder.
  ///
  /// In en, this message translates to:
  /// **'Backup folder'**
  String get backupFolder;

  /// No description provided for @lastAction.
  ///
  /// In en, this message translates to:
  /// **'Last action'**
  String get lastAction;

  /// No description provided for @lastBackup.
  ///
  /// In en, this message translates to:
  /// **'Last backup'**
  String get lastBackup;

  /// No description provided for @noBackupsYet.
  ///
  /// In en, this message translates to:
  /// **'No backups yet'**
  String get noBackupsYet;

  /// No description provided for @restoreHistory.
  ///
  /// In en, this message translates to:
  /// **'Restore History'**
  String get restoreHistory;

  /// No description provided for @sourceFolder.
  ///
  /// In en, this message translates to:
  /// **'Source folder'**
  String get sourceFolder;

  /// No description provided for @lastRestored.
  ///
  /// In en, this message translates to:
  /// **'Last restored'**
  String get lastRestored;

  /// No description provided for @noRestoresYet.
  ///
  /// In en, this message translates to:
  /// **'No restores yet'**
  String get noRestoresYet;

  /// No description provided for @backupNoticeFormat.
  ///
  /// In en, this message translates to:
  /// **'Backup data will only create a folder containing your backup files with this format:'**
  String get backupNoticeFormat;

  /// No description provided for @backupSecurityNote.
  ///
  /// In en, this message translates to:
  /// **'Nothing transmitted to the cloud. Your data remain secure during this process.'**
  String get backupSecurityNote;

  /// No description provided for @restoreNoticeFormat.
  ///
  /// In en, this message translates to:
  /// **'Restoring will overwrite all existing data. Restore data will only access and import the folder containing your backup files with this format:'**
  String get restoreNoticeFormat;

  /// No description provided for @writeNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Write a note (max. 500)'**
  String get writeNoteHint;

  /// No description provided for @writeHere.
  ///
  /// In en, this message translates to:
  /// **'Write here...'**
  String get writeHere;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @startJourney.
  ///
  /// In en, this message translates to:
  /// **'Start Journey'**
  String get startJourney;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @storeOrLink.
  ///
  /// In en, this message translates to:
  /// **'Offline store or link to buy'**
  String get storeOrLink;

  /// No description provided for @minAmount.
  ///
  /// In en, this message translates to:
  /// **'Min. Amount'**
  String get minAmount;

  /// No description provided for @maxAmount.
  ///
  /// In en, this message translates to:
  /// **'Max. Amount'**
  String get maxAmount;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @resetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset Filters'**
  String get resetFilters;

  /// No description provided for @targetAchievedDate.
  ///
  /// In en, this message translates to:
  /// **'Date to achieve goal'**
  String get targetAchievedDate;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @editChecklistItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Checklist Item'**
  String get editChecklistItem;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get dataManagement;

  /// No description provided for @appInfo.
  ///
  /// In en, this message translates to:
  /// **'App Info'**
  String get appInfo;

  /// No description provided for @session.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get session;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetails;

  /// No description provided for @deleteMyData.
  ///
  /// In en, this message translates to:
  /// **'Delete My Data'**
  String get deleteMyData;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @reportLogFile.
  ///
  /// In en, this message translates to:
  /// **'Report Log File'**
  String get reportLogFile;

  /// No description provided for @continueLogoutDevice.
  ///
  /// In en, this message translates to:
  /// **'Continue logging out from this device?'**
  String get continueLogoutDevice;

  /// No description provided for @mainCurrency.
  ///
  /// In en, this message translates to:
  /// **'Main Currency'**
  String get mainCurrency;

  /// No description provided for @selectMainCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Main Currency'**
  String get selectMainCurrency;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @setupWallet.
  ///
  /// In en, this message translates to:
  /// **'Setup Wallet'**
  String get setupWallet;

  /// No description provided for @tapToSetupFirstWallet.
  ///
  /// In en, this message translates to:
  /// **'Tap to setup your first wallet'**
  String get tapToSetupFirstWallet;

  /// No description provided for @savingsAccountHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Savings Account'**
  String get savingsAccountHint;

  /// No description provided for @mySpendingThisMonth.
  ///
  /// In en, this message translates to:
  /// **'My spending this month'**
  String get mySpendingThisMonth;

  /// No description provided for @viewReport.
  ///
  /// In en, this message translates to:
  /// **'View report'**
  String get viewReport;

  /// No description provided for @deleteWalletWarning.
  ///
  /// In en, this message translates to:
  /// **'All transactions, budgets, and goals will also be deleted. This action cannot be undone.'**
  String get deleteWalletWarning;

  /// No description provided for @deleteWalletComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Delete a wallet is coming soon...'**
  String get deleteWalletComingSoon;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// No description provided for @toFindOut.
  ///
  /// In en, this message translates to:
  /// **' to find out.'**
  String get toFindOut;

  /// No description provided for @localDataStorageNotice.
  ///
  /// In en, this message translates to:
  /// **'You can add more wallets later. We only store your data into local database on this device. So you are in charge! '**
  String get localDataStorageNotice;

  /// No description provided for @getStartedDescPart1.
  ///
  /// In en, this message translates to:
  /// **'Please enter your '**
  String get getStartedDescPart1;

  /// No description provided for @getStartedDescPart2.
  ///
  /// In en, this message translates to:
  /// **'name or brand name'**
  String get getStartedDescPart2;

  /// No description provided for @getStartedDescPart3.
  ///
  /// In en, this message translates to:
  /// **', pick your best '**
  String get getStartedDescPart3;

  /// No description provided for @getStartedDescPart4.
  ///
  /// In en, this message translates to:
  /// **'picture'**
  String get getStartedDescPart4;

  /// No description provided for @getStartedDescPart5.
  ///
  /// In en, this message translates to:
  /// **' and choose your '**
  String get getStartedDescPart5;

  /// No description provided for @getStartedDescPart6.
  ///
  /// In en, this message translates to:
  /// **'currency'**
  String get getStartedDescPart6;

  /// No description provided for @getStartedDescPart7.
  ///
  /// In en, this message translates to:
  /// **' to personalize your account.'**
  String get getStartedDescPart7;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @onboardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Simple and intuitive finance buddy. Track your expenses, set goals, organize your pocket and wallet sized finance — everything effortlessly. 🚀'**
  String get onboardingDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
