object Form1: TForm1
  Left = 724
  Top = 135
  Width = 461
  Height = 534
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    445
    496)
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 16
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 0
    OnClick = btn1Click
  end
  object mmo1: TMemo
    Left = 16
    Top = 40
    Width = 241
    Height = 145
    TabOrder = 1
  end
  object edt1: TEdit
    Left = 104
    Top = 8
    Width = 249
    Height = 21
    TabOrder = 2
    Text = 'https://www.baidu.com'
  end
  object btn2: TButton
    Left = 360
    Top = 8
    Width = 75
    Height = 25
    Caption = 'GetTitle'
    TabOrder = 3
    OnClick = btn2Click
  end
  object scrlbx1: TScrollBox
    Left = 8
    Top = 304
    Width = 425
    Height = 185
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 4
    object img1: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      AutoSize = True
    end
  end
  object btn3: TButton
    Left = 360
    Top = 48
    Width = 75
    Height = 25
    Caption = 'AutoGetImg'
    TabOrder = 5
    OnClick = btn3Click
  end
  object edt2: TEdit
    Left = 264
    Top = 88
    Width = 169
    Height = 21
    TabOrder = 6
    Text = 
      'void((function(){var css="<style>._d_box{font-size:14px; backgro' +
      'und:#fff; z-index:9999; height:385px; width:45%; border:1px #ccc' +
      ' solid; padding:1px; overflow:hidden; position:absolute; right:2' +
      'px; bottom:2px; box-shadow:1px 3px 50px rgba(0,0,0,0.4);}._d_box' +
      ' h5{DISPLAY:block;cursor:cell; height:25px; line-height:25px; ma' +
      'rgin: 0; padding:0 10px; background: #5077A2;color: #fff;}._d_bo' +
      'x textarea{width:98%;height:45%;margin:0 auto}._d_box h5 i{float' +
      ':right;font-style: normal;width:50px; height:25px; text-align: c' +
      'enter;margin-right: -9px;margin-left: 10px;+margin-right: -9px;+' +
      'z-index:99999;+margin-top:-25px;line-height: 25px;background: #4' +
      '6729B;}._d_box h5 i:hover{cursor:pointer;background: #34567A;}</' +
      'style>",box="<div id=box class=_d_box><h5>JsDebug<i onclick=docu' +
      'ment.getElementById('#39'box'#39').parentNode.removeChild(document.getEl' +
      'ementById('#39'box'#39'))>Close</i><i onclick=eval(document.getElementBy' +
      'Id('#39'console'#39').value)>Run</i></h5><textarea id=console>alert(docu' +
      'ment.referrer);</textarea><br><textarea id=returnBox></textarea>' +
      '</div>";function getId(id){return document.getElementById(id)}if' +
      '(getId("box")==null){document.body.innerHTML+=css+box}var $box=g' +
      'etId("box"),$moveBox=$box.getElementsByTagName("h5")[0];$moveBox' +
      '.onmousedown=function(){var offsetX=$box.offsetLeft,offsetY=$box' +
      '.offsetTop,mouseX=event.pageX,mouseY=event.pageY;if(!document.on' +
      'mousemove){document.onmousemove=function(){var moveX=event.pageX' +
      '-mouseX,moveY=event.pageY-mouseY,newX=(offsetX+moveX)+"px",newY=' +
      '(offsetY+moveY)+"px";$box.style.left=newX;$box.style.top=newY}}}' +
      ';document.onmouseup=function(){document.onmousemove=null};_alert' +
      '=window.alert;window.alert=function(tt){document.getElementById(' +
      '"returnBox").value+="\nalert>"+tt}})());'
  end
  object btn4: TButton
    Left = 360
    Top = 112
    Width = 75
    Height = 25
    Caption = 'RunJs'
    TabOrder = 7
    OnClick = btn4Click
  end
  object btn5: TButton
    Left = 272
    Top = 48
    Width = 75
    Height = 25
    Caption = 'GetImg'
    TabOrder = 8
    OnClick = btn5Click
  end
  object Button1: TButton
    Left = 264
    Top = 144
    Width = 25
    Height = 20
    Caption = '1'
    TabOrder = 9
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 296
    Top = 144
    Width = 25
    Height = 20
    Caption = '2'
    TabOrder = 10
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 328
    Top = 144
    Width = 25
    Height = 20
    Caption = '3'
    TabOrder = 11
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 264
    Top = 168
    Width = 25
    Height = 20
    Caption = '4'
    TabOrder = 12
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 296
    Top = 168
    Width = 25
    Height = 20
    Caption = '5'
    TabOrder = 13
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 328
    Top = 168
    Width = 25
    Height = 20
    Caption = '6'
    TabOrder = 14
    OnClick = Button6Click
  end
  object CheckBox1: TCheckBox
    Left = 264
    Top = 120
    Width = 81
    Height = 17
    Caption = #32534#36753#39029#38754
    TabOrder = 15
    OnClick = CheckBox1Click
  end
  object Button7: TButton
    Left = 16
    Top = 200
    Width = 75
    Height = 25
    Caption = 'malert(string)'
    TabOrder = 16
    OnClick = Button7Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 240
    Width = 417
    Height = 21
    TabOrder = 17
    Text = 'nalert(document.body.innerHTML);'
  end
  object Button8: TButton
    Left = 168
    Top = 272
    Width = 75
    Height = 25
    Caption = 'RunJs'
    TabOrder = 18
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 112
    Top = 200
    Width = 75
    Height = 25
    Caption = 'nalert()'
    TabOrder = 19
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 360
    Top = 144
    Width = 75
    Height = 41
    Caption = 'MacOS'
    TabOrder = 20
    OnClick = Button10Click
  end
  object tmr1: TTimer
    Enabled = False
    OnTimer = tmr1Timer
    Left = 224
    Top = 120
  end
  object tmr2: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmr2Timer
    Left = 224
    Top = 152
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 224
    Top = 192
  end
end
