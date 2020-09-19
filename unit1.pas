unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, CheckLst, ExtCtrls, Grids,
  RegExpr;

type

  { TForm1 }

  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    TSG: TStringGrid;
    ToggleBox1: TToggleBox;
    procedure CheckBox1Change(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TSGClick(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  Pos_H, Pos_E : Integer;
  Result       : String;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ToggleBox1Change(Sender: TObject);
var
  RegexObj_H, RegexObj_E : TRegExpr;
begin
  RegexObj_H := TRegExpr.Create;
  RegexObj_H.Expression:= Edit1.Text;
  RegexObj_E := TRegExpr.Create;
  RegexObj_E.Expression:= Edit3.Text;
  if RegexObj_H.Exec(Edit2.Text) then Begin
    Pos_H:=RegexObj_H.MatchPos[0]+RegexObj_H.MatchLen[0];
    Label1.Caption:=IntToStr(Pos_H);
    Edit4.Text:=RegexObj_H.Match[0];
    If CheckBox1.Checked then Begin
      RegexObj_H.ExecNext;
      Pos_E:=RegexObj_H.MatchPos[0];
      Label2.Caption:=IntToStr(Pos_E);
      Edit5.Text:=RegexObj_H.Match[0];
    end;
  end;
  If CheckBox1.Checked=False then Begin
    if RegexObj_E.Exec(Edit2.Text) then Begin
      Pos_E:=RegexObj_E.MatchPos[0];
      Label2.Caption:=IntToStr(Pos_E);
      Edit5.Text:=RegexObj_E.Match[0];
    end;
    RegexObj_H.Free;
  end;
  RegexObj_E.Free;
  Result:=Copy(Edit2.Text, Pos_H, Pos_E-Pos_H);
  Edit6.Text:=Result;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked=True then Edit3.Enabled:=False;
  if CheckBox1.Checked=False then Edit3.Enabled:=True;
end;

procedure TForm1.FormClick(Sender: TObject);
begin

end;


procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.TSGClick(Sender: TObject);
begin
  If TSG.Selection.Left=1 Then Begin
    If TSG.Cells[TSG.Selection.left, TSG.Selection.top]='0'
      Then TSG.Cells[TSG.Selection.left, TSG.Selection.top]:='1'
      else TSG.Cells[TSG.Selection.left, TSG.Selection.top]:='0';
  end;
end;

end.

