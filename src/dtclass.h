#DEFINE __DTCLASS

* list date formats
#DEFINE DateTF_Default  0 && dle SET("DATE")
#DEFINE DateTF_American 1 && mm/dd/yy   MDY
#DEFINE DateTF_Ansi     2 && yy.mm.dd   YMD
#DEFINE DateTF_British  3 && dd/mm/yy   DMY
#DEFINE DateTF_Italian  4 && dd-mm-yy   DMY
#DEFINE DateTF_French   5 && dd/mm/yy   DMY
#DEFINE DateTF_German   6 && dd.mm.yy   DMY
#DEFINE DateTF_Japan    7 && yy/mm/dd   YMD
#DEFINE DateTF_Taiwan   8 && yy/mm/dd   YMD
#DEFINE DateTF_USA      9 && mm-dd-yy   MDY
#DEFINE DateTF_MDY     10 && mm/dd/yy   MDY
#DEFINE DateTF_DMY     11 && dd/mm/yy   DMY
#DEFINE DateTF_YMD     12 && yy/mm/dd   YMD
#DEFINE DateTF_Short   13 && Determined by the Windows Control Panel short date setting

* Unsuported
#DEFINE DateTF_Long    14 && Determined by the Windows Control Panel long date setting

#DEFINE DateTF_American_Name "AMERICAN"
#DEFINE DateTF_Ansi_Name     "ANSI"
#DEFINE DateTF_British_Name  "BRITISH"
#DEFINE DateTF_Italian_Name  "ITALIAN"
#DEFINE DateTF_French_Name   "FRENCH"
#DEFINE DateTF_German_Name   "GERMAN"
#DEFINE DateTF_Japan_Name    "JAPAN"
#DEFINE DateTF_Taiwan_Name   "TAIWAN"
#DEFINE DateTF_USA_Name      "UAS"
#DEFINE DateTF_MDY_Name      "MDY"
#DEFINE DateTF_DMY_Name      "DMY"
#DEFINE DateTF_YMD_Name      "YMD"
#DEFINE DateTF_Short_Name    "SHORT"
#DEFINE DateTF_Long_Name     "LONG"

#DEFINE LOCALE_SDATE              0x0000001D   &&  date separator
#DEFINE LOCALE_SSHORTDATE         0x0000001F   && short date format string
#DEFINE LOCALE_SLONGDATE          0x00000020   && long date format string
#DEFINE LOCALE_STIME	             30
#DEFINE LOCALE_STIMEFORMA         0x1003

#DEFINE _AFD_VFP  1
#DEFINE _AFD_NAV 2

#DEFINE _DTC_LANG_EN
*#DEFINE _DTC_LANG_CZ

* CZ
#IFDEF _DTC_LANG_CZ
 #DEFINE _AFD_VFP_LIST ",D:0,PO:1,ÚT:2,S:3,È:4,PÁ:5,SO:6,N:7,"
 #DEFINE _AFD_NAV_LIST ",P:0,D:0,PO:1,ÚT:2,S:3,È:4,PÁ:5,SO:6,N:7,"
#ENDIF

* EN
#IFDEF _DTC_LANG_EN 
 #DEFINE _AFD_VFP_LIST ",T:0,M:1,TU:2,WE:3,TH:4,F:5,SA:6,S:7,"
 #DEFINE _AFD_NAV_LIST ",W:0,T:0,M:1,TU:2,WE:3,TH:4,F:5,SA:6,S:7,"
#ENDIF