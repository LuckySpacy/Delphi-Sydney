unit Json.YahooFinance.QuotedSummery;

interface

uses
  Generics.Collections, Rest.Json;

type

  TAnnualHoldingsTurnoverClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TAnnualHoldingsTurnoverClass;
  end;

  TLastCapGainClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TLastCapGainClass;
  end;

  TLastDividendDateClass = class
  private
    FFmt: TDate;
    FRaw: Extended;
  public
    property fmt: TDate read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TLastDividendDateClass;
  end;

  TLastDividendValueClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TLastDividendValueClass;
  end;

  TSandP52WeekChangeClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSandP52WeekChangeClass;
  end;

  T52WeekChangeClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): T52WeekChangeClass;
  end;

  TEnterpriseToEbitdaClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TEnterpriseToEbitdaClass;
  end;

  TEnterpriseToRevenueClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TEnterpriseToRevenueClass;
  end;

  TLastSplitDateClass = class
  private
    FFmt: TDate;
    FRaw: Extended;
  public
    property fmt: TDate read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TLastSplitDateClass;
  end;

  TPegRatioClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TPegRatioClass;
  end;

  TForwardEpsClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TForwardEpsClass;
  end;

  TTrailingEpsClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TTrailingEpsClass;
  end;

  TNetIncomeToCommonClass = class
  private
    FFmt: String;
    FLongFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property longFmt: String read FLongFmt write FLongFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TNetIncomeToCommonClass;
  end;

  TRevenueQuarterlyGrowthClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRevenueQuarterlyGrowthClass;
  end;

  TEarningsQuarterlyGrowthClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TEarningsQuarterlyGrowthClass;
  end;

  TMostRecentQuarterClass = class
  private
    FFmt: TDate;
    FRaw: Extended;
  public
    property fmt: TDate read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TMostRecentQuarterClass;
  end;

  TNextFiscalYearEndClass = class
  private
    FFmt: TDate;
    FRaw: Extended;
  public
    property fmt: TDate read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TNextFiscalYearEndClass;
  end;

  TLastFiscalYearEndClass = class
  private
    FFmt: TDate;
    FRaw: Extended;
  public
    property fmt: TDate read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TLastFiscalYearEndClass;
  end;

  TPriceToSalesTrailing12MonthsClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TPriceToSalesTrailing12MonthsClass;
  end;

  TFiveYearAverageReturnClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TFiveYearAverageReturnClass;
  end;

  TThreeYearAverageReturnClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TThreeYearAverageReturnClass;
  end;

  TFundInceptionDateClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TFundInceptionDateClass;
  end;

  TYieldClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TYieldClass;
  end;

  TTotalAssetsClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TTotalAssetsClass;
  end;

  TBeta3YearClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TBeta3YearClass;
  end;

  TYtdReturnClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TYtdReturnClass;
  end;

  TAnnualReportExpenseRatioClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TAnnualReportExpenseRatioClass;
  end;

  TPriceToBookClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TPriceToBookClass;
  end;

  TBookValueClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TBookValueClass;
  end;

  TMorningStarRiskRatingClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TMorningStarRiskRatingClass;
  end;

  TMorningStarOverallRatingClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TMorningStarOverallRatingClass;
  end;

  TImpliedSharesOutstandingClass = class
  private
    FFmt: String;
    FLongFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property longFmt: String read FLongFmt write FLongFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TImpliedSharesOutstandingClass;
  end;

  TBetaClass = class
  private
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TBetaClass;
  end;

  TShortPercentOfFloatClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TShortPercentOfFloatClass;
  end;

  TShortRatioClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TShortRatioClass;
  end;

  THeldPercentInstitutionsClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): THeldPercentInstitutionsClass;
  end;

  THeldPercentInsidersClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): THeldPercentInsidersClass;
  end;

  TSharesPercentSharesOutClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSharesPercentSharesOutClass;
  end;

  TDateShortInterestClass = class
  private
    FFmt: TDate;
    FRaw: Extended;
  public
    property fmt: TDate read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TDateShortInterestClass;
  end;

  TSharesShortPreviousMonthDateClass = class
  private
    FFmt: TDate;
    FRaw: Extended;
  public
    property fmt: TDate read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSharesShortPreviousMonthDateClass;
  end;

  TSharesShortPriorMonthClass = class
  private
    FFmt: String;
    FLongFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property longFmt: String read FLongFmt write FLongFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSharesShortPriorMonthClass;
  end;

  TSharesShortClass = class
  private
    FFmt: String;
    FLongFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property longFmt: String read FLongFmt write FLongFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSharesShortClass;
  end;

  TSharesOutstandingClass = class
  private
    FFmt: String;
    FLongFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property longFmt: String read FLongFmt write FLongFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSharesOutstandingClass;
  end;

  TFloatSharesClass = class
  private
    FFmt: String;
    FLongFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property longFmt: String read FLongFmt write FLongFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TFloatSharesClass;
  end;

  TProfitMarginsClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TProfitMarginsClass;
  end;

  TForwardPEClass = class
  private
    FFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TForwardPEClass;
  end;

  TEnterpriseValueClass = class
  private
    FFmt: String;
    FLongFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property longFmt: String read FLongFmt write FLongFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TEnterpriseValueClass;
  end;

  TPriceHintClass = class
  private
    FFmt: String;
    FLongFmt: String;
    FRaw: Extended;
  public
    property fmt: String read FFmt write FFmt;
    property longFmt: String read FLongFmt write FLongFmt;
    property raw: Extended read FRaw write FRaw;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TPriceHintClass;
  end;

  TDefaultKeyStatisticsClass = class
  private
    F52WeekChange: T52WeekChangeClass;
    FSandP52WeekChange: TSandP52WeekChangeClass;
    FAnnualHoldingsTurnover: TAnnualHoldingsTurnoverClass;
    FAnnualReportExpenseRatio: TAnnualReportExpenseRatioClass;
    FBeta: TBetaClass;
    FBeta3Year: TBeta3YearClass;
    FBookValue: TBookValueClass;
    FDateShortInterest: TDateShortInterestClass;
    FEarningsQuarterlyGrowth: TEarningsQuarterlyGrowthClass;
    FEnterpriseToEbitda: TEnterpriseToEbitdaClass;
    FEnterpriseToRevenue: TEnterpriseToRevenueClass;
    FEnterpriseValue: TEnterpriseValueClass;
    FFiveYearAverageReturn: TFiveYearAverageReturnClass;
    FFloatShares: TFloatSharesClass;
    FForwardEps: TForwardEpsClass;
    FForwardPE: TForwardPEClass;
    FFundInceptionDate: TFundInceptionDateClass;
    FHeldPercentInsiders: THeldPercentInsidersClass;
    FHeldPercentInstitutions: THeldPercentInstitutionsClass;
    FImpliedSharesOutstanding: TImpliedSharesOutstandingClass;
    FLastCapGain: TLastCapGainClass;
    FLastDividendDate: TLastDividendDateClass;
    FLastDividendValue: TLastDividendValueClass;
    FLastFiscalYearEnd: TLastFiscalYearEndClass;
    FLastSplitDate: TLastSplitDateClass;
    FLastSplitFactor: String;
    FMaxAge: Extended;
    FMorningStarOverallRating: TMorningStarOverallRatingClass;
    FMorningStarRiskRating: TMorningStarRiskRatingClass;
    FMostRecentQuarter: TMostRecentQuarterClass;
    FNetIncomeToCommon: TNetIncomeToCommonClass;
    FNextFiscalYearEnd: TNextFiscalYearEndClass;
    FPegRatio: TPegRatioClass;
    FPriceHint: TPriceHintClass;
    FPriceToBook: TPriceToBookClass;
    FPriceToSalesTrailing12Months: TPriceToSalesTrailing12MonthsClass;
    FProfitMargins: TProfitMarginsClass;
    FRevenueQuarterlyGrowth: TRevenueQuarterlyGrowthClass;
    FSharesOutstanding: TSharesOutstandingClass;
    FSharesPercentSharesOut: TSharesPercentSharesOutClass;
    FSharesShort: TSharesShortClass;
    FSharesShortPreviousMonthDate: TSharesShortPreviousMonthDateClass;
    FSharesShortPriorMonth: TSharesShortPriorMonthClass;
    FShortPercentOfFloat: TShortPercentOfFloatClass;
    FShortRatio: TShortRatioClass;
    FThreeYearAverageReturn: TThreeYearAverageReturnClass;
    FTotalAssets: TTotalAssetsClass;
    FTrailingEps: TTrailingEpsClass;
    FYield: TYieldClass;
    FYtdReturn: TYtdReturnClass;
  public
    property x52WeekChange: T52WeekChangeClass read F52WeekChange write F52WeekChange;
    property SandP52WeekChange: TSandP52WeekChangeClass read FSandP52WeekChange write FSandP52WeekChange;
    property annualHoldingsTurnover: TAnnualHoldingsTurnoverClass read FAnnualHoldingsTurnover write FAnnualHoldingsTurnover;
    property annualReportExpenseRatio: TAnnualReportExpenseRatioClass read FAnnualReportExpenseRatio write FAnnualReportExpenseRatio;
    property beta: TBetaClass read FBeta write FBeta;
    property beta3Year: TBeta3YearClass read FBeta3Year write FBeta3Year;
    property bookValue: TBookValueClass read FBookValue write FBookValue;
    property dateShortInterest: TDateShortInterestClass read FDateShortInterest write FDateShortInterest;
    property earningsQuarterlyGrowth: TEarningsQuarterlyGrowthClass read FEarningsQuarterlyGrowth write FEarningsQuarterlyGrowth;
    property enterpriseToEbitda: TEnterpriseToEbitdaClass read FEnterpriseToEbitda write FEnterpriseToEbitda;
    property enterpriseToRevenue: TEnterpriseToRevenueClass read FEnterpriseToRevenue write FEnterpriseToRevenue;
    property enterpriseValue: TEnterpriseValueClass read FEnterpriseValue write FEnterpriseValue;
    property fiveYearAverageReturn: TFiveYearAverageReturnClass read FFiveYearAverageReturn write FFiveYearAverageReturn;
    property floatShares: TFloatSharesClass read FFloatShares write FFloatShares;
    property forwardEps: TForwardEpsClass read FForwardEps write FForwardEps;
    property forwardPE: TForwardPEClass read FForwardPE write FForwardPE;
    property fundInceptionDate: TFundInceptionDateClass read FFundInceptionDate write FFundInceptionDate;
    property heldPercentInsiders: THeldPercentInsidersClass read FHeldPercentInsiders write FHeldPercentInsiders;
    property heldPercentInstitutions: THeldPercentInstitutionsClass read FHeldPercentInstitutions write FHeldPercentInstitutions;
    property impliedSharesOutstanding: TImpliedSharesOutstandingClass read FImpliedSharesOutstanding write FImpliedSharesOutstanding;
    property lastCapGain: TLastCapGainClass read FLastCapGain write FLastCapGain;
    property lastDividendDate: TLastDividendDateClass read FLastDividendDate write FLastDividendDate;
    property lastDividendValue: TLastDividendValueClass read FLastDividendValue write FLastDividendValue;
    property lastFiscalYearEnd: TLastFiscalYearEndClass read FLastFiscalYearEnd write FLastFiscalYearEnd;
    property lastSplitDate: TLastSplitDateClass read FLastSplitDate write FLastSplitDate;
    property lastSplitFactor: String read FLastSplitFactor write FLastSplitFactor;
    property maxAge: Extended read FMaxAge write FMaxAge;
    property morningStarOverallRating: TMorningStarOverallRatingClass read FMorningStarOverallRating write FMorningStarOverallRating;
    property morningStarRiskRating: TMorningStarRiskRatingClass read FMorningStarRiskRating write FMorningStarRiskRating;
    property mostRecentQuarter: TMostRecentQuarterClass read FMostRecentQuarter write FMostRecentQuarter;
    property netIncomeToCommon: TNetIncomeToCommonClass read FNetIncomeToCommon write FNetIncomeToCommon;
    property nextFiscalYearEnd: TNextFiscalYearEndClass read FNextFiscalYearEnd write FNextFiscalYearEnd;
    property pegRatio: TPegRatioClass read FPegRatio write FPegRatio;
    property priceHint: TPriceHintClass read FPriceHint write FPriceHint;
    property priceToBook: TPriceToBookClass read FPriceToBook write FPriceToBook;
    property priceToSalesTrailing12Months: TPriceToSalesTrailing12MonthsClass read FPriceToSalesTrailing12Months write FPriceToSalesTrailing12Months;
    property profitMargins: TProfitMarginsClass read FProfitMargins write FProfitMargins;
    property revenueQuarterlyGrowth: TRevenueQuarterlyGrowthClass read FRevenueQuarterlyGrowth write FRevenueQuarterlyGrowth;
    property sharesOutstanding: TSharesOutstandingClass read FSharesOutstanding write FSharesOutstanding;
    property sharesPercentSharesOut: TSharesPercentSharesOutClass read FSharesPercentSharesOut write FSharesPercentSharesOut;
    property sharesShort: TSharesShortClass read FSharesShort write FSharesShort;
    property sharesShortPreviousMonthDate: TSharesShortPreviousMonthDateClass read FSharesShortPreviousMonthDate write FSharesShortPreviousMonthDate;
    property sharesShortPriorMonth: TSharesShortPriorMonthClass read FSharesShortPriorMonth write FSharesShortPriorMonth;
    property shortPercentOfFloat: TShortPercentOfFloatClass read FShortPercentOfFloat write FShortPercentOfFloat;
    property shortRatio: TShortRatioClass read FShortRatio write FShortRatio;
    property threeYearAverageReturn: TThreeYearAverageReturnClass read FThreeYearAverageReturn write FThreeYearAverageReturn;
    property totalAssets: TTotalAssetsClass read FTotalAssets write FTotalAssets;
    property trailingEps: TTrailingEpsClass read FTrailingEps write FTrailingEps;
    property yield: TYieldClass read FYield write FYield;
    property ytdReturn: TYtdReturnClass read FYtdReturn write FYtdReturn;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TDefaultKeyStatisticsClass;
  end;

  TResultClass = class
  private
    FDefaultKeyStatistics: TDefaultKeyStatisticsClass;
  public
    property defaultKeyStatistics: TDefaultKeyStatisticsClass read FDefaultKeyStatistics write FDefaultKeyStatistics;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TResultClass;
  end;

  TQuoteSummaryClass = class
  private
    FResult: TArray<TResultClass>;
  public
    property result: TArray<TResultClass> read FResult write FResult;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TQuoteSummaryClass;
  end;

  TJYahooFinanceQuotedSummery = class
  private
    FQuoteSummary: TQuoteSummaryClass;
  public
    property quoteSummary: TQuoteSummaryClass read FQuoteSummary write FQuoteSummary;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TJYahooFinanceQuotedSummery;
  end;

implementation

{TAnnualHoldingsTurnoverClass}


function TAnnualHoldingsTurnoverClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TAnnualHoldingsTurnoverClass.FromJsonString(AJsonString: string): TAnnualHoldingsTurnoverClass;
begin
  result := TJson.JsonToObject<TAnnualHoldingsTurnoverClass>(AJsonString)
end;

{TLastCapGainClass}


function TLastCapGainClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TLastCapGainClass.FromJsonString(AJsonString: string): TLastCapGainClass;
begin
  result := TJson.JsonToObject<TLastCapGainClass>(AJsonString)
end;

{TLastDividendDateClass}


function TLastDividendDateClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TLastDividendDateClass.FromJsonString(AJsonString: string): TLastDividendDateClass;
begin
  result := TJson.JsonToObject<TLastDividendDateClass>(AJsonString)
end;

{TLastDividendValueClass}


function TLastDividendValueClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TLastDividendValueClass.FromJsonString(AJsonString: string): TLastDividendValueClass;
begin
  result := TJson.JsonToObject<TLastDividendValueClass>(AJsonString)
end;

{TSandP52WeekChangeClass}


function TSandP52WeekChangeClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSandP52WeekChangeClass.FromJsonString(AJsonString: string): TSandP52WeekChangeClass;
begin
  result := TJson.JsonToObject<TSandP52WeekChangeClass>(AJsonString)
end;

{T52WeekChangeClass}


function T52WeekChangeClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function T52WeekChangeClass.FromJsonString(AJsonString: string): T52WeekChangeClass;
begin
  result := TJson.JsonToObject<T52WeekChangeClass>(AJsonString)
end;

{TEnterpriseToEbitdaClass}


function TEnterpriseToEbitdaClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TEnterpriseToEbitdaClass.FromJsonString(AJsonString: string): TEnterpriseToEbitdaClass;
begin
  result := TJson.JsonToObject<TEnterpriseToEbitdaClass>(AJsonString)
end;

{TEnterpriseToRevenueClass}


function TEnterpriseToRevenueClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TEnterpriseToRevenueClass.FromJsonString(AJsonString: string): TEnterpriseToRevenueClass;
begin
  result := TJson.JsonToObject<TEnterpriseToRevenueClass>(AJsonString)
end;

{TLastSplitDateClass}


function TLastSplitDateClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TLastSplitDateClass.FromJsonString(AJsonString: string): TLastSplitDateClass;
begin
  result := TJson.JsonToObject<TLastSplitDateClass>(AJsonString)
end;

{TPegRatioClass}


function TPegRatioClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TPegRatioClass.FromJsonString(AJsonString: string): TPegRatioClass;
begin
  result := TJson.JsonToObject<TPegRatioClass>(AJsonString)
end;

{TForwardEpsClass}


function TForwardEpsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TForwardEpsClass.FromJsonString(AJsonString: string): TForwardEpsClass;
begin
  result := TJson.JsonToObject<TForwardEpsClass>(AJsonString)
end;

{TTrailingEpsClass}


function TTrailingEpsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TTrailingEpsClass.FromJsonString(AJsonString: string): TTrailingEpsClass;
begin
  result := TJson.JsonToObject<TTrailingEpsClass>(AJsonString)
end;

{TNetIncomeToCommonClass}


function TNetIncomeToCommonClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TNetIncomeToCommonClass.FromJsonString(AJsonString: string): TNetIncomeToCommonClass;
begin
  result := TJson.JsonToObject<TNetIncomeToCommonClass>(AJsonString)
end;

{TRevenueQuarterlyGrowthClass}


function TRevenueQuarterlyGrowthClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRevenueQuarterlyGrowthClass.FromJsonString(AJsonString: string): TRevenueQuarterlyGrowthClass;
begin
  result := TJson.JsonToObject<TRevenueQuarterlyGrowthClass>(AJsonString)
end;

{TEarningsQuarterlyGrowthClass}


function TEarningsQuarterlyGrowthClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TEarningsQuarterlyGrowthClass.FromJsonString(AJsonString: string): TEarningsQuarterlyGrowthClass;
begin
  result := TJson.JsonToObject<TEarningsQuarterlyGrowthClass>(AJsonString)
end;

{TMostRecentQuarterClass}


function TMostRecentQuarterClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TMostRecentQuarterClass.FromJsonString(AJsonString: string): TMostRecentQuarterClass;
begin
  result := TJson.JsonToObject<TMostRecentQuarterClass>(AJsonString)
end;

{TNextFiscalYearEndClass}


function TNextFiscalYearEndClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TNextFiscalYearEndClass.FromJsonString(AJsonString: string): TNextFiscalYearEndClass;
begin
  result := TJson.JsonToObject<TNextFiscalYearEndClass>(AJsonString)
end;

{TLastFiscalYearEndClass}


function TLastFiscalYearEndClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TLastFiscalYearEndClass.FromJsonString(AJsonString: string): TLastFiscalYearEndClass;
begin
  result := TJson.JsonToObject<TLastFiscalYearEndClass>(AJsonString)
end;

{TPriceToSalesTrailing12MonthsClass}


function TPriceToSalesTrailing12MonthsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TPriceToSalesTrailing12MonthsClass.FromJsonString(AJsonString: string): TPriceToSalesTrailing12MonthsClass;
begin
  result := TJson.JsonToObject<TPriceToSalesTrailing12MonthsClass>(AJsonString)
end;

{TFiveYearAverageReturnClass}


function TFiveYearAverageReturnClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TFiveYearAverageReturnClass.FromJsonString(AJsonString: string): TFiveYearAverageReturnClass;
begin
  result := TJson.JsonToObject<TFiveYearAverageReturnClass>(AJsonString)
end;

{TThreeYearAverageReturnClass}


function TThreeYearAverageReturnClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TThreeYearAverageReturnClass.FromJsonString(AJsonString: string): TThreeYearAverageReturnClass;
begin
  result := TJson.JsonToObject<TThreeYearAverageReturnClass>(AJsonString)
end;

{TFundInceptionDateClass}


function TFundInceptionDateClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TFundInceptionDateClass.FromJsonString(AJsonString: string): TFundInceptionDateClass;
begin
  result := TJson.JsonToObject<TFundInceptionDateClass>(AJsonString)
end;

{TYieldClass}


function TYieldClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TYieldClass.FromJsonString(AJsonString: string): TYieldClass;
begin
  result := TJson.JsonToObject<TYieldClass>(AJsonString)
end;

{TTotalAssetsClass}


function TTotalAssetsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TTotalAssetsClass.FromJsonString(AJsonString: string): TTotalAssetsClass;
begin
  result := TJson.JsonToObject<TTotalAssetsClass>(AJsonString)
end;

{TBeta3YearClass}


function TBeta3YearClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TBeta3YearClass.FromJsonString(AJsonString: string): TBeta3YearClass;
begin
  result := TJson.JsonToObject<TBeta3YearClass>(AJsonString)
end;

{TYtdReturnClass}


function TYtdReturnClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TYtdReturnClass.FromJsonString(AJsonString: string): TYtdReturnClass;
begin
  result := TJson.JsonToObject<TYtdReturnClass>(AJsonString)
end;

{TAnnualReportExpenseRatioClass}


function TAnnualReportExpenseRatioClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TAnnualReportExpenseRatioClass.FromJsonString(AJsonString: string): TAnnualReportExpenseRatioClass;
begin
  result := TJson.JsonToObject<TAnnualReportExpenseRatioClass>(AJsonString)
end;

{TPriceToBookClass}


function TPriceToBookClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TPriceToBookClass.FromJsonString(AJsonString: string): TPriceToBookClass;
begin
  result := TJson.JsonToObject<TPriceToBookClass>(AJsonString)
end;

{TBookValueClass}


function TBookValueClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TBookValueClass.FromJsonString(AJsonString: string): TBookValueClass;
begin
  result := TJson.JsonToObject<TBookValueClass>(AJsonString)
end;

{TMorningStarRiskRatingClass}


function TMorningStarRiskRatingClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TMorningStarRiskRatingClass.FromJsonString(AJsonString: string): TMorningStarRiskRatingClass;
begin
  result := TJson.JsonToObject<TMorningStarRiskRatingClass>(AJsonString)
end;

{TMorningStarOverallRatingClass}


function TMorningStarOverallRatingClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TMorningStarOverallRatingClass.FromJsonString(AJsonString: string): TMorningStarOverallRatingClass;
begin
  result := TJson.JsonToObject<TMorningStarOverallRatingClass>(AJsonString)
end;

{TImpliedSharesOutstandingClass}


function TImpliedSharesOutstandingClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TImpliedSharesOutstandingClass.FromJsonString(AJsonString: string): TImpliedSharesOutstandingClass;
begin
  result := TJson.JsonToObject<TImpliedSharesOutstandingClass>(AJsonString)
end;

{TBetaClass}


function TBetaClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TBetaClass.FromJsonString(AJsonString: string): TBetaClass;
begin
  result := TJson.JsonToObject<TBetaClass>(AJsonString)
end;

{TShortPercentOfFloatClass}


function TShortPercentOfFloatClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TShortPercentOfFloatClass.FromJsonString(AJsonString: string): TShortPercentOfFloatClass;
begin
  result := TJson.JsonToObject<TShortPercentOfFloatClass>(AJsonString)
end;

{TShortRatioClass}


function TShortRatioClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TShortRatioClass.FromJsonString(AJsonString: string): TShortRatioClass;
begin
  result := TJson.JsonToObject<TShortRatioClass>(AJsonString)
end;

{THeldPercentInstitutionsClass}


function THeldPercentInstitutionsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function THeldPercentInstitutionsClass.FromJsonString(AJsonString: string): THeldPercentInstitutionsClass;
begin
  result := TJson.JsonToObject<THeldPercentInstitutionsClass>(AJsonString)
end;

{THeldPercentInsidersClass}


function THeldPercentInsidersClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function THeldPercentInsidersClass.FromJsonString(AJsonString: string): THeldPercentInsidersClass;
begin
  result := TJson.JsonToObject<THeldPercentInsidersClass>(AJsonString)
end;

{TSharesPercentSharesOutClass}


function TSharesPercentSharesOutClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSharesPercentSharesOutClass.FromJsonString(AJsonString: string): TSharesPercentSharesOutClass;
begin
  result := TJson.JsonToObject<TSharesPercentSharesOutClass>(AJsonString)
end;

{TDateShortInterestClass}


function TDateShortInterestClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TDateShortInterestClass.FromJsonString(AJsonString: string): TDateShortInterestClass;
begin
  result := TJson.JsonToObject<TDateShortInterestClass>(AJsonString)
end;

{TSharesShortPreviousMonthDateClass}


function TSharesShortPreviousMonthDateClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSharesShortPreviousMonthDateClass.FromJsonString(AJsonString: string): TSharesShortPreviousMonthDateClass;
begin
  result := TJson.JsonToObject<TSharesShortPreviousMonthDateClass>(AJsonString)
end;

{TSharesShortPriorMonthClass}


function TSharesShortPriorMonthClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSharesShortPriorMonthClass.FromJsonString(AJsonString: string): TSharesShortPriorMonthClass;
begin
  result := TJson.JsonToObject<TSharesShortPriorMonthClass>(AJsonString)
end;

{TSharesShortClass}


function TSharesShortClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSharesShortClass.FromJsonString(AJsonString: string): TSharesShortClass;
begin
  result := TJson.JsonToObject<TSharesShortClass>(AJsonString)
end;

{TSharesOutstandingClass}


function TSharesOutstandingClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSharesOutstandingClass.FromJsonString(AJsonString: string): TSharesOutstandingClass;
begin
  result := TJson.JsonToObject<TSharesOutstandingClass>(AJsonString)
end;

{TFloatSharesClass}


function TFloatSharesClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TFloatSharesClass.FromJsonString(AJsonString: string): TFloatSharesClass;
begin
  result := TJson.JsonToObject<TFloatSharesClass>(AJsonString)
end;

{TProfitMarginsClass}


function TProfitMarginsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TProfitMarginsClass.FromJsonString(AJsonString: string): TProfitMarginsClass;
begin
  result := TJson.JsonToObject<TProfitMarginsClass>(AJsonString)
end;

{TForwardPEClass}


function TForwardPEClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TForwardPEClass.FromJsonString(AJsonString: string): TForwardPEClass;
begin
  result := TJson.JsonToObject<TForwardPEClass>(AJsonString)
end;

{TEnterpriseValueClass}


function TEnterpriseValueClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TEnterpriseValueClass.FromJsonString(AJsonString: string): TEnterpriseValueClass;
begin
  result := TJson.JsonToObject<TEnterpriseValueClass>(AJsonString)
end;

{TPriceHintClass}


function TPriceHintClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TPriceHintClass.FromJsonString(AJsonString: string): TPriceHintClass;
begin
  result := TJson.JsonToObject<TPriceHintClass>(AJsonString)
end;

{TDefaultKeyStatisticsClass}

constructor TDefaultKeyStatisticsClass.Create;
begin
  inherited;
  FPriceHint := TPriceHintClass.Create();
  FEnterpriseValue := TEnterpriseValueClass.Create();
  FForwardPE := TForwardPEClass.Create();
  FProfitMargins := TProfitMarginsClass.Create();
  FFloatShares := TFloatSharesClass.Create();
  FSharesOutstanding := TSharesOutstandingClass.Create();
  FSharesShort := TSharesShortClass.Create();
  FSharesShortPriorMonth := TSharesShortPriorMonthClass.Create();
  FSharesShortPreviousMonthDate := TSharesShortPreviousMonthDateClass.Create();
  FDateShortInterest := TDateShortInterestClass.Create();
  FSharesPercentSharesOut := TSharesPercentSharesOutClass.Create();
  FHeldPercentInsiders := THeldPercentInsidersClass.Create();
  FHeldPercentInstitutions := THeldPercentInstitutionsClass.Create();
  FShortRatio := TShortRatioClass.Create();
  FShortPercentOfFloat := TShortPercentOfFloatClass.Create();
  FBeta := TBetaClass.Create();
  FImpliedSharesOutstanding := TImpliedSharesOutstandingClass.Create();
  FMorningStarOverallRating := TMorningStarOverallRatingClass.Create();
  FMorningStarRiskRating := TMorningStarRiskRatingClass.Create();
  FBookValue := TBookValueClass.Create();
  FPriceToBook := TPriceToBookClass.Create();
  FAnnualReportExpenseRatio := TAnnualReportExpenseRatioClass.Create();
  FYtdReturn := TYtdReturnClass.Create();
  FBeta3Year := TBeta3YearClass.Create();
  FTotalAssets := TTotalAssetsClass.Create();
  FYield := TYieldClass.Create();
  FFundInceptionDate := TFundInceptionDateClass.Create();
  FThreeYearAverageReturn := TThreeYearAverageReturnClass.Create();
  FFiveYearAverageReturn := TFiveYearAverageReturnClass.Create();
  FPriceToSalesTrailing12Months := TPriceToSalesTrailing12MonthsClass.Create();
  FLastFiscalYearEnd := TLastFiscalYearEndClass.Create();
  FNextFiscalYearEnd := TNextFiscalYearEndClass.Create();
  FMostRecentQuarter := TMostRecentQuarterClass.Create();
  FEarningsQuarterlyGrowth := TEarningsQuarterlyGrowthClass.Create();
  FRevenueQuarterlyGrowth := TRevenueQuarterlyGrowthClass.Create();
  FNetIncomeToCommon := TNetIncomeToCommonClass.Create();
  FTrailingEps := TTrailingEpsClass.Create();
  FForwardEps := TForwardEpsClass.Create();
  FPegRatio := TPegRatioClass.Create();
  FLastSplitDate := TLastSplitDateClass.Create();
  FEnterpriseToRevenue := TEnterpriseToRevenueClass.Create();
  FEnterpriseToEbitda := TEnterpriseToEbitdaClass.Create();
  F52WeekChange := T52WeekChangeClass.Create();
  FSandP52WeekChange := TSandP52WeekChangeClass.Create();
  FLastDividendValue := TLastDividendValueClass.Create();
  FLastDividendDate := TLastDividendDateClass.Create();
  FLastCapGain := TLastCapGainClass.Create();
  FAnnualHoldingsTurnover := TAnnualHoldingsTurnoverClass.Create();
end;

destructor TDefaultKeyStatisticsClass.Destroy;
begin
  FPriceHint.free;
  FEnterpriseValue.free;
  FForwardPE.free;
  FProfitMargins.free;
  FFloatShares.free;
  FSharesOutstanding.free;
  FSharesShort.free;
  FSharesShortPriorMonth.free;
  FSharesShortPreviousMonthDate.free;
  FDateShortInterest.free;
  FSharesPercentSharesOut.free;
  FHeldPercentInsiders.free;
  FHeldPercentInstitutions.free;
  FShortRatio.free;
  FShortPercentOfFloat.free;
  FBeta.free;
  FImpliedSharesOutstanding.free;
  FMorningStarOverallRating.free;
  FMorningStarRiskRating.free;
  FBookValue.free;
  FPriceToBook.free;
  FAnnualReportExpenseRatio.free;
  FYtdReturn.free;
  FBeta3Year.free;
  FTotalAssets.free;
  FYield.free;
  FFundInceptionDate.free;
  FThreeYearAverageReturn.free;
  FFiveYearAverageReturn.free;
  FPriceToSalesTrailing12Months.free;
  FLastFiscalYearEnd.free;
  FNextFiscalYearEnd.free;
  FMostRecentQuarter.free;
  FEarningsQuarterlyGrowth.free;
  FRevenueQuarterlyGrowth.free;
  FNetIncomeToCommon.free;
  FTrailingEps.free;
  FForwardEps.free;
  FPegRatio.free;
  FLastSplitDate.free;
  FEnterpriseToRevenue.free;
  FEnterpriseToEbitda.free;
  F52WeekChange.free;
  FSandP52WeekChange.free;
  FLastDividendValue.free;
  FLastDividendDate.free;
  FLastCapGain.free;
  FAnnualHoldingsTurnover.free;
  inherited;
end;

function TDefaultKeyStatisticsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TDefaultKeyStatisticsClass.FromJsonString(AJsonString: string): TDefaultKeyStatisticsClass;
begin
  result := TJson.JsonToObject<TDefaultKeyStatisticsClass>(AJsonString)
end;

{TResultClass}

constructor TResultClass.Create;
begin
  inherited;
  FDefaultKeyStatistics := TDefaultKeyStatisticsClass.Create();
end;

destructor TResultClass.Destroy;
begin
  FDefaultKeyStatistics.free;
  inherited;
end;

function TResultClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TResultClass.FromJsonString(AJsonString: string): TResultClass;
begin
  result := TJson.JsonToObject<TResultClass>(AJsonString)
end;

{TQuoteSummaryClass}

destructor TQuoteSummaryClass.Destroy;
var
  LresultItem: TResultClass;
begin

 for LresultItem in FResult do
   LresultItem.free;

  inherited;
end;

function TQuoteSummaryClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TQuoteSummaryClass.FromJsonString(AJsonString: string): TQuoteSummaryClass;
begin
  result := TJson.JsonToObject<TQuoteSummaryClass>(AJsonString)
end;

{TJYahooFinanceQuotedSummery}

constructor TJYahooFinanceQuotedSummery.Create;
begin
  inherited;
  FQuoteSummary := TQuoteSummaryClass.Create();
end;

destructor TJYahooFinanceQuotedSummery.Destroy;
begin
  FQuoteSummary.free;
  inherited;
end;

function TJYahooFinanceQuotedSummery.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TJYahooFinanceQuotedSummery.FromJsonString(AJsonString: string): TJYahooFinanceQuotedSummery;
begin
  result := TJson.JsonToObject<TJYahooFinanceQuotedSummery>(AJsonString)
end;

end.

