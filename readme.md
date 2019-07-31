# DT Class

Classes for works with date or datetime. 
* Convert date/datetime to string
* Convert string to date/datetime
* Set Format and InputMask form textbox
* Autofill date/datetime


## Examples for date
```
LOCAL m.lcPath, m.ldDate, m.lcDate, m.loDT, m.loTXT, m.liSelStart, m.liSelLength, m.luDate, m.lcFN, m.lcSETDATE
m.lcPath=SYS(16)
m.lcPath=IIF(RAT("\", m.lcPath)>0, LEFT(m.lcPath, RAT("\", m.lcPath)), m.lcPath)

m.lcSETDATE=SET("DATE")
SET DATE TO "GERMAN"

m.lcFN=_Screen.FontName
_Screen.FontName="Courier New"

SET PROCEDURE TO (m.lcPath+"..\src\DTCLASS.prg")
CLEAR
m.loDT=CREATEOBJECT("_DATE")


m.ldDate=DATE()
m.lcDate=m.loDT.ToString(.NULL., m.ldDate)
?'ToString         ', m.lcDate
?'ToDate           ', m.loDT.ToDate(.NULL., m.lcDate)
?'Format String    ', m.loDT.GetShortDateFormatString(.NULL.)
?'Empty Date String', "'"+m.loDT.GetStringBlankDate(.NULL.)+"'"
?'DateFormat       ', m.loDT.GetDateFormat(m.loDT.DateFormat), m.loDT.DateFormat
?
m.loDT.SetFormatString(.NULL.)
?"InputMask,Format", m.loDT.InputMask, m.loDT.Format
?
m.loDT.AutoFillDate=1
?'Monday-current week', "M         ", m.loDT.ToDate(.NULL., "M")
?'Today-current week ', "T         ", m.loDT.ToDate(.NULL., "T")
?'Autofill month,year', "01.  .    ", m.loDT.ToDate(.NULL., "01.  .    ")
?'Autofill year      ', "01.05.    ", m.loDT.ToDate(.NULL., "01.05.    ")
?'Autofill day,year  ', "  .05.    ", m.loDT.ToDate(.NULL., "  .05.    ")
?'Autofill day       ', "  .05.2011", m.loDT.ToDate(.NULL., "  .05.2011")
?'Autofill day,month ', "  .  .2011", m.loDT.ToDate(.NULL., "  .  .2011")


?
m.loTXT=CREATEOBJECT("Textbox")

m.loTXT.Value=DATE()
?"Date Type", m.loTXT.Value

STORE 0 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Day  ", m.luDate, m.liSelStart, m.liSelLength

STORE 3 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Month", m.luDate, m.liSelStart, m.liSelLength

STORE 6 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Year ", m.luDate, m.liSelStart, m.liSelLength

?
m.loTXT.Value=m.loDT.ToString(m.loTXT, DATE())
?"String Type", m.loTXT.Value

STORE 0 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Day    ", m.luDate, m.liSelStart, m.liSelLength

STORE 3 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Month  ", m.luDate, m.liSelStart, m.liSelLength

STORE 6 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Year   ", m.luDate, m.liSelStart, m.liSelLength


SET PROCEDURE TO

SET DATE TO &lcSETDATE.
_Screen.FontName=m.lcFN
``` 

## Examples for date time
```
LOCAL m.lcPath, m.ldDate, m.lcDate, m.loDT, m.loTXT, m.liSelStart, m.liSelLength, m.luDate, m.lcFN, m.lcSETDATE
m.lcPath=SYS(16)
m.lcPath=IIF(RAT("\", m.lcPath)>0, LEFT(m.lcPath, RAT("\",m.lcPath)), m.lcPath)

m.lcSETDATE=SET("DATE")
SET DATE TO "GERMAN"

m.lcFN=_Screen.FontName
_Screen.FontName="Courier New"

SET PROCEDURE TO (m.lcPath+"..\src\DTCLASS.prg")
CLEAR
m.loDT=CREATEOBJECT("_DATETIME")


m.ldDate=DATETIME()
m.lcDate=m.loDT.ToString(.NULL., m.ldDate)
?'ToString         ', m.lcDate
?'ToDate           ', m.loDT.ToDate(.NULL., m.lcDate)
?'Format String    ', m.loDT.GetShortDateFormatString(.NULL.)
?'Empty Date String', "'"+m.loDT.GetStringBlankDate(.NULL.)+"'"
?'DateFormat       ', m.loDT.GetDateFormat(m.loDT.DateFormat)
?
m.loDT.SetFormatString(.NULL.)
?"InputMask,Format", m.loDT.InputMask, m.loDT.Format
?
m.loDT.AutoFillDate=1
?'Monday-current week', "M         ", m.loDT.ToDate(.NULL., "M")
?'Today-current week ', "T         ", m.loDT.ToDate(.NULL., "T")
?'Autofill month,year', "01.  .    ", m.loDT.ToDate(.NULL., "01.  .    ")
?'Autofill year      ', "01.05.    ", m.loDT.ToDate(.NULL., "01.05.    ")
?'Autofill day,year  ', "  .05.    ", m.loDT.ToDate(.NULL., "  .05.    ")
?'Autofill day       ', "  .05.2011", m.loDT.ToDate(.NULL., "  .05.2011")
?'Autofill day,month ', "  .  .2011", m.loDT.ToDate(.NULL., "  .  .2011")


?
m.loTXT=CREATEOBJECT("Textbox")

m.loTXT.Value=DATETIME()
?"Date Type", m.loTXT.Value

STORE 0 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec( m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Day  ", m.luDate, m.liSelStart, m.liSelLength

STORE 3 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Month", m.luDate, m.liSelStart, m.liSelLength

STORE 6 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Year ", m.luDate, m.liSelStart, m.liSelLength

STORE 12 TO m.loTXT.SelStart, m.liSelStart
luDate=loDT.IncDec(loTXT,1,@liSelStart,@liSelLength)
?"Inc hour   ",luDate,liSelStart,liSelLength

STORE 15 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc minute ", m.luDate, m.liSelStart, m.liSelLength

STORE 18 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc second ", m.luDate, m.liSelStart, m.liSelLength


?
m.loTXT.Value=m.loDT.ToString(m.loTXT, DATETIME())
?"String Type", m.loTXT.Value

STORE 0 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Day    ", m.luDate, m.liSelStart, m.liSelLength

STORE 3 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Month  ", m.luDate, m.liSelStart, m.liSelLength

STORE 6 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc Year   ", m.luDate, m.liSelStart, m.liSelLength


STORE 12 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc hour   ", m.luDate, m.liSelStart, m.liSelLength

STORE 15 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc minute ", m.luDate, m.liSelStart, m.liSelLength

STORE 18 TO m.loTXT.SelStart, m.liSelStart
m.luDate=m.loDT.IncDec(m.loTXT, 1, @m.liSelStart, @m.liSelLength)
?"Inc second ", m.luDate, m.liSelStart, m.liSelLength


SET PROCEDURE TO

SET DATE TO &lcSETDATE.
_Screen.FontName=m.lcFN
``` 

