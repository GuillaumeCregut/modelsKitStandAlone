program ModelKit;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, sqlite3laz, Ppale, UPeriod, UBuilder, UBrand, UCategory,
  UScale, uCountries, uModels
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFPpale, FPpale);
  Application.CreateForm(TFPeriod, FPeriod);
  Application.CreateForm(TFBuilder, FBuilder);
  Application.CreateForm(TFBrand, FBrand);
  Application.CreateForm(TFCategories, FCategories);
  Application.CreateForm(TFScales, FScales);
  Application.CreateForm(TFCountries, FCountries);
  Application.CreateForm(TFModels, FModels);
  Application.Run;
end.

