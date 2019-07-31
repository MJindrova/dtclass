#INCLUDE dtclass.h

DEFINE CLASS _DATE AS CUSTOM
   Name="_DATE"
   
   PROTECTED oTXT

   Century=1
   DateFormat=0
   DateMark="."
   Format=""
   InputMask=""
   
   AutoFillDate=0
   AutoFillDateMode=1
   AutoFillDateMode=_AFD_VFP
   DIME AutoFillDate_Data(2)
   AutoFillDate_Data(_AFD_VFP)=_AFD_VFP_LIST
   AutoFillDate_Data(_AFD_NAV)=_AFD_NAV_LIST

   oTXT=.NULL.

   PROCEDURE DateFormat_Access
      *
      * _DATE::DateFormat_Access()
      *
      RETURN IIF(ISNULL(This.oTXT), This.DateFormat, This.oTXT.DateFormat)
   ENDPROC


   PROCEDURE DateFormat_Assign
      *
      * _DATE::DateFormat_Assign()
      *
      LPARAMETERS m.luValue

      This.DateFormat=m.luValue
      IF NOT ISNULL(This.oTXT)
         This.oTXT.DateFormat=m.luValue
      ENDIF
   ENDPROC

    
   PROCEDURE DateMark_Access
      *
      * _DATE::DateMark_Access()
      *
      RETURN IIF(ISNULL(This.oTXT), This.DateMark, This.oTXT.DateMark)
   ENDPROC


   PROCEDURE DateMark_Assign
      *
      * _DATE::DateMark_Assign()
      *
      LPARAMETERS m.luValue

      This.DateMark=m.luValue
      IF NOT ISNULL(This.oTXT)
         This.oTXT.DateMark=m.luValue
      ENDIF
   ENDPROC


   PROCEDURE Format_Access
      *
      * _DATE::Format_Access()
      *
      RETURN IIF(ISNULL(This.oTXT), This.Format, This.oTXT.Format)
   ENDPROC


   PROCEDURE Format_Assign
      *
      * _DATE::Format_Assign()
      *
      LPARAMETERS m.luValue
      
      This.Format=m.luValue
      IF NOT ISNULL(This.oTXT)
         This.oTXT.Format=m.luValue
      ENDIF
   ENDPROC

   PROCEDURE InputMask_Access
      *
      * _DATE::InputMask_Access()
      *
      RETURN IIF(ISNULL(This.oTXT), This.InputMask, This.oTXT.InputMask)
   ENDPROC


   PROCEDURE InputMask_Assign
      *
      * _DATE::InputMask_Assign()
      *
      LPARAMETERS m.luValue
      
      This.InputMask=m.luValue
      IF NOT ISNULL(This.oTXT)
         This.oTXT.InputMask=m.luValue
      ENDIF
   ENDPROC


   PROCEDURE Century_Access
      *
      * _DATE::Century_Access()
      *
      RETURN IIF(ISNULL(This.oTXT), This.Century, This.oTXT.Century)
   ENDPROC


   PROCEDURE Century_Assign
      *
      * _DATE::Century_Assign()
      *
      LPARAMETERS m.luValue
      
      This.Century=m.luValue
      IF NOT ISNULL(This.oTXT)
         This.oTXT.Century=m.luValue
      ENDIF
   ENDPROC

   PROCEDURE Init
      *
      * _DATE::Init()
      *
      DECLARE INTEGER GetThreadLocale IN kernel32.dll AS __DTCLASS_GetThreadLocale
      DECLARE INTEGER GetLocaleInfo IN KERNEL32.DLL AS __DTCLASS_GetLocaleInfo INTEGER, INTEGER, STRING @, INTEGER 
   ENDPROC
   
   PROCEDURE ToDate && Convert string to date
      *
      * _DATE::ToDate()
      *
      LPARAMETERS m.loTXT, m.lcDate
      
      * loTXT  - .NULL. or reference on textbox s date value (Date/string)
      * lcDate - date in string expression

      This.oTXT=m.loTXT
      LOCAL m.luDateFormat, m.ldDate, m.lcMask, m.lcDateStr, m.liLen, m.liD, m.liM, m.liY, m.lcND, m.llAutoFill, m.lcED, m.liCentury
      m.luDateFormat=This.GetDateFormat(This.DateFormat)
      m.liCentury=This.GetCentury(This.Century)
      This.oTXT=.NULL.

      DO CASE
         CASE m.luDateFormat=DateTF_Long && long

         CASE m.luDateFormat=DateTF_Short && short
              m.lcDateStr=This.GetShortDateFormatString(m.loTXT)

              m.liY=AT(IIF(m.liCentury=1, "YYYY", "YY"), m.lcDateStr)
              m.liM=AT("MM", m.lcDateStr)
              m.liD=AT("DD" ,m.lcDateStr)
              m.lcDateStr="^"+STR(m.liY, 1)+STR(m.liY+1, 1)+IIF(m.liCentury=1, STR(m.liY+2, 1)+STR(m.liY+3, 1), "")+"-"+STR(m.liM, 1)+STR(m.liM+1, 1)+"-"+STR(m.liD, 1)+STR(m.liD+1, 1)

         CASE INLIST(m.luDateFormat, DateTF_American,DateTF_USA, DateTF_MDY)
              m.liY=7
              m.liM=1
              m.liD=4
              m.lcDateStr=IIF(m.liCentury=1, "^7890-12-45", "^78-12-45")

         CASE INLIST(m.luDateFormat,DateTF_Ansi,DateTF_Japan,DateTF_Taiwan,DateTF_YMD)
              m.liY=1
              m.liM=IIF(m.liCentury=1, 6, 4)
              m.liD=IIF(m.liCentury=1, 9, 7)
              m.lcDateStr=IIF(m.liCentury=1, "^1234-67-90", "^12-45-78")

         OTHERWISE
              m.liY=7
              m.liM=4
              m.liD=1
              m.lcDateStr=IIF(m.liCentury=1, "^7890-45-12", "^78-45-12")

      ENDCASE

      IF This.AutoFillDate=1
         m.lcED=This.GetStringBlankDate(m.loTXT)
         IF m.lcED#m.lcDate
            m.lcND=This.GetAutomaticDate(m.lcDate, m.liY, m.liM, m.liD)
            IF !ISNULL(m.lcND)
               m.lcDate=m.lcND
            ELSE
               m.llAutoFill=.T.
            ENDIF
         ELSE
            m.llAutoFill=m.lcED#m.lcDate
         ENDIF

         IF m.llAutoFill
            * Check empty space
            IF EMPTY(SUBS(m.lcDate, m.liY, IIF(m.liCentury=1, 4 ,2)))
               m.lcDate=STUFF(m.lcDate, m.liY, IIF(m.liCentury=1, 4, 2), STR(YEAR(DATE()), IIF(m.liCentury=1, 4, 2)))
            ENDIF
            IF EMPTY(SUBS(m.lcDate, m.liM, 2))
               m.lcDate=STUFF(m.lcDate, m.liM, 2, PADL(LTRIM(STR(MONTH(DATE()),2)), 2, "0"))
            ENDIF
            IF EMPTY(SUBS(m.lcDate, m.liD, 2))
               m.lcDate=STUFF(m.lcDate, m.liD, 2, PADL(LTRIM(STR(DAY(DATE()), 2)), 2, "0"))  && "01"
            ENDIF
         ENDIF
      ENDIF
      RETURN CTOD(CHRTRAN(m.lcDateStr, IIF(m.liCentury=1, "1234567890", "12345678"), m.lcDate))
   ENDPROC
   
   
   PROCEDURE ToString && Convert date to string
      *
      * _DATE::ToString()
      *
      LPARAMETERS m.loTXT, m.ldDate
      
      * loTXT  - .NULL. or reference on textbox s date value (Date/string)
      * ldDate - Date expression

      This.oTXT=m.loTXT
      LOCAL m.luDateFormat, m.lcDateMark, m.lcDate, m.liCentury
      m.luDateFormat=This.GetDateFormat(This.DateFormat)
      m.lcDateMark=IIF(EMPTY(This.DateMark), SET("MARK"), This.DateMark)
      m.liCentury=This.GetCentury(This.Century)
      This.oTXT=.NULL.

      IF m.luDateFormat=DateTF_Short && short
         m.lcDate=STRTRAN(This.GetShortDateFormatString(m.loTXT), "#", m.lcDateMark)

         m.lcDate=STRTRAN(m.lcDate,REPL("D", OCCURS("D", m.lcDate)), STR(DAY(m.ldDate), 2))
         m.lcDate=STRTRAN(m.lcDate,REPL("M", OCCURS("M", m.lcDate)), STR(MONTH(m.ldDate), 2))
         m.lcDate=STRTRAN(m.lcDate,REPL("Y", OCCURS("Y", m.lcDate)), STR(YEAR(m.ldDate), IIF(m.liCentury=1, 4, 2)))
      ELSE
         IF m.luDateFormat=DateTF_Long
         ELSE
            * mm/dd/yy   MDY
            * yy.mm.dd   YMD
            * dd/mm/yy   DMY
            IF m.liCentury=1
               m.lcDate=CHRTRAN(;
                               IIF(INLIST(m.luDateFormat, DateTF_American, DateTF_USA, DateTF_MDY), "56"+m.lcDateMark+"78"+m.lcDateMark+"1234",;
                               IIF(INLIST(m.luDateFormat, DateTF_Ansi, DateTF_Japan, DateTF_Taiwan, DateTF_YMD), "1234"+m.lcDateMark+"56"+m.lcDateMark+"78", "78"+lcDateMark+"56"+lcDateMark+"1234")),;
                               "12345678", DTOS(m.ldDate))
            ELSE
               m.lcDate=CHRTRAN(;
                               IIF(INLIST(m.luDateFormat, DateTF_American, DateTF_USA, DateTF_MDY), "56"+m.lcDateMark+"78"+m.lcDateMark+"34",;
                               IIF(INLIST(m.luDateFormat, DateTF_Ansi, DateTF_Japan, DateTF_Taiwan, DateTF_YMD), "34"+m.lcDateMark+"56"+m.lcDateMark+"78", "78"+lcDateMark+"56"+lcDateMark+"34")),;
                               "12345678", DTOS(m.ldDate))
            ENDIF          
         ENDIF
      ENDIF
      RETURN m.lcDate   
   ENDPROC
   
   
   PROCEDURE GetCentury
      *
      * _DATE::GetCentury()
      *
      LPARAMETERS m.liCentury
      RETURN IIF(m.liCentury<>2, m.liCentury, IIF(SET("CENTURY")="OFF", 0, 1))
   ENDPROC

   
   PROCEDURE GetDateFormat
      *
      * _DATE::GetDateFormat()
      *
      LPARAMETERS m.luDateFormat
      
      IF m.luDateFormat<>DateTF_Default
         RETURN m.luDateFormat
      ENDIF   
      
      m.luDateFormat=SET("DATE")

      RETURN IIF(m.luDateFormat=DateTF_American_Name, DateTF_American,;
             IIF(m.luDateFormat=DateTF_Ansi_Name, DateTF_Ansi,;
             IIF(m.luDateFormat=DateTF_British_Name, DateTF_British,;
             IIF(m.luDateFormat=DateTF_Italian_Name, DateTF_Italian,;
             IIF(m.luDateFormat=DateTF_French_Name, DateTF_French,;
             IIF(m.luDateFormat=DateTF_German_Name, DateTF_German,;
             IIF(m.luDateFormat=DateTF_Japan_Name, DateTF_Japan,;
             IIF(m.luDateFormat=DateTF_Taiwan_Name, DateTF_Taiwan,;
             IIF(m.luDateFormat=DateTF_USA_Name, DateTF_USA,;
             IIF(m.luDateFormat=DateTF_MDY_Name, DateTF_MDY,;
             IIF(m.luDateFormat=DateTF_DMY_Name, DateTF_DMY,;
             IIF(m.luDateFormat=DateTF_YMD_Name, DateTF_YMD,;
             IIF(m.luDateFormat=DateTF_Short_Name, DateTF_Short,;
             IIF(m.luDateFormat=DateTF_Long_Name, DateTF_Long, m.luDateFormat))))))))))))))
   ENDPROC

   PROCEDURE GetShortDateFormatString
      *
      * _DATE::GetShortDateFormatString()
      *
      LPARAMETERS m.loTXT
      
      * loTXT  - .NULL. or reference on textbox s date value (Date/string)
      This.oTXT=loTXT
      LOCAL m.luDateFormat, m.lcDateMark, m.lcMask, m.lcDateStr, m.liLen, m.liCentury
      m.lcDateMark=IIF(EMPTY(This.DateMark), SET("MARK"), This.DateMark)
      m.liCentury=This.GetCentury(This.Century)
      This.oTXT=.NULL.
      m.lcMask=IIF(m.liCentury=1, "99#99#9999", "99#99#99")

      m.lcDateMark=SPACE(254)+CHR(0)
      m.lcDateStr=SPACE(254)+CHR(0)

      m.liLen=__DTCLASS_GetLocaleInfo(__DTCLASS_GetThreadLocale(), LOCALE_SSHORTDATE, @m.lcDateStr, LEN(m.lcDateStr))
      m.lcDateStr=LEFT(m.lcDateStr, m.liLen-1) 

      m.liLen=__DTCLASS_GetLocaleInfo(__DTCLASS_GetThreadLocale(), LOCALE_SDATE, @m.lcDateMark, LEN(m.lcDateMark))
      m.lcDateMark=LEFT(m.lcDateMark, m.liLen-1)
  
      m.lcMask=UPPER(m.lcDateStr)
      m.lcMask=STRTRAN(m.lcMask, REPL("D", OCCURS("D", m.lcMask)), "99")
      m.lcMask=STRTRAN(m.lcMask, REPL("M", OCCURS("M", m.lcMask)), "99")
      m.lcMask=STRTRAN(m.lcMask, REPL("Y", OCCURS("Y", m.lcMask)), IIF(m.liCentury=1, "9999", "99"))
      m.lcMask=STRTRAN(m.lcMask, m.lcDateMark, "#")
      RETURN m.lcMask
   ENDPROC

   PROCEDURE GetStringBlankDate && Convert empty date to string
      *
      * _DATE::GetStringBlankDate()
      *
      LPARAMETERS m.loTXT

      * loTXT  - .NULL. or reference on textbox s date value (Date/string)

      LOCAL m.luDateFormat, m.lcDateMark, m.lcDate, m.liLen, m.liCentury, m.lcCentury
      This.oTXT=m.loTXT
      m.luDateFormat=This.GetDateFormat(This.DateFormat)
      m.lcDateMark=IIF(EMPTY(This.DateMark), SET("MARK"), This.DateMark)
      m.liCentury=This.GetCentury(This.Century)
      This.oTXT=.NULL.

      m.lcCentury=IIF(m.liCentury=1, "    ", "  ")
      IF m.luDateFormat=DateTF_Short && short
         m.lcDate=STRTRAN(This.GetShortDateFormatString(), "#", m.lcDateMark)

         m.lcDate=STRTRAN(m.lcDate, REPL("D", OCCURS("D", m.lcDate)), "  ")
         m.lcDate=STRTRAN(m.lcDate, REPL("M", OCCURS("M", m.lcDate)), "  ")
         m.lcDate=STRTRAN(m.lcDate, REPL("Y", OCCURS("Y", m.lcDate)), m.lcCentury)
      ELSE
         IF m.luDateFormat=DateTF_Long
         ELSE
            * mm/dd/yy   MDY
            * yy.mm.dd   YMD
            * dd/mm/yy   DMY
            m.lcDate=IIF(INLIST(m.luDateFormat, DateTF_American, DateTF_USA, DateTF_MDY),"  "+m.lcDateMark+"  "+m.lcDateMark+m.lcCentury,;
                     IIF(INLIST(m.luDateFormat, DateTF_Ansi, DateTF_Japan, DateTF_Taiwan, DateTF_YMD), m.lcCentury+m.lcDateMark+"  "+m.lcDateMark+"  ", "  "+m.lcDateMark+"  "+m.lcDateMark+m.lcCentury))
             
         ENDIF
      ENDIF
      RETURN m.lcDate
   ENDPROC


   PROTECTED PROCEDURE GetAutomaticDate
      *
      * _DATE::GetAutomaticDate()
      *
      LPARAMETERS m.lcDate, m.liY, m.liM, m.liD

      * lcDate - Date in string expression
      * liY - index of year
      * liM - index of month
      * liD - inde xof day

      LOCAL m.lcPom, m.lii, m.lcAFD, m.ldDate, m.liCentury

      m.liCentury=This.GetCentury(This.Century)
      m.lcAFD=This.AutoFillDate_Data(This.AutoFillDateMode)
      m.lcPom=ALLT(LEFT(m.lcDate, 2))
      m.lii=ATC(","+m.lcPom+":", m.lcAFD)
      IF m.lii>0
         m.lcPom=SUBST(m.lcAFD, m.lii+LEN(","+m.lcPom+":"))
         m.lii=ATC(",", m.lcPom)
         IF m.lii>0
            m.lii=VAL(LEFT(m.lcPom, m.lii-1)) && 
            m.ldDate=IIF(m.lii=0, DATE(), DATE()- (DOW(DATE(),SET("FDOW"))-m.lii))
         ENDIF

         m.lcDate=STUFF(m.lcDate, m.liY, IIF(m.liCentury=1, 4, 2), STR(YEAR(m.ldDate), IIF(m.liCentury=1, 4, 2)))
         m.lcDate=STUFF(m.lcDate, m.liM, 2, STR(MONTH(m.ldDate), 2))
         m.lcDate=STUFF(m.lcDate, m.liD, 2, STR(DAY(m.ldDate), 2))
   
         RETURN CHRTRAN(m.lcDate, " ", "0")
      ENDIF
      RETURN .NULL.
   ENDPROC
   
   
   PROCEDURE SetFormatString && Set Format a InputString by reginal setings
      *
      * _DATE::SetFormatString()
      *
      LPARAMETERS m.loTXT

      * loTXT  - .NULL. or reference on textbox s date value (Date/string)
      LOCAL m.lcMask, m.luDateFormat, m.lcDateMark, m.liCentury
      This.oTXT=m.loTXT
      m.luDateFormat=This.GetDateFormat(This.DateFormat)
      m.lcDateMark=IIF(EMPTY(This.DateMark), SET("MARK"), This.DateMark)
      m.liCentury=This.GetCentury(This.Century)
      IF m.luDateFormat=DateTF_Short && short
         m.lcMask=This.GetShortDateFormatString()
      ELSE
         IF m.luDateFormat=DateTF_Long && long
            m.lcMask=""
         ELSE
            * mm/dd/yy   MDY
            * yy.mm.dd   YMD
            * dd/mm/yy   DMY
            m.lcMask=IIF(INLIST(m.luDateFormat, DateTF_American, DateTF_USA, DateTF_MDY), "99#99#99"+IIF(m.liCentury=1, "99", ""),;
                     IIF(INLIST(m.luDateFormat, DateTF_Ansi, DateTF_Japan, DateTF_Taiwan, DateTF_YMD), IIF(m.liCentury=1, "99", "")+"99#99#99","99#99#99"+IIF(m.liCentury=1, "99", "")))
         ENDIF
      ENDIF

      IF This.AutoFillDate=1
         This.Format="XX"+SUBST(m.lcMask, 3)
         This.InputMask="XX"+SUBST(STRTRAN(m.lcMask, "#", m.lcDateMark), 3)
      ELSE
         This.Format=m.lcMask
         This.InputMask=STRTRAN(m.lcMask, "#", m.lcDateMark)
      ENDIF
      This.oTXT=.NULL.
   ENDPROC

   PROCEDURE IncDec && Increase/decrease day/month/year
      *
      * _DATE::IncDec()
      *
      LPARAMETERS m.loTXT, m.liDelta, m.liSelStart, m.liSelLength
      
      * loTXT  - .NULL. or reference on textbox s date value (Date/string)
      IF m.loTXT.Text=This.GetStringBlankDate(m.loTXT)
         RETURN loTXT.Value
      ENDIF

      LOCAL m.luDateFormat, m.liY, m.liM, m.liD, m.liDelta, m.lcType, m.luValue, m.liCentury
      m.lcType=VARTYPE(m.loTXT.Value)
      This.oTXT=m.loTXT
      m.luDateFormat=This.GetDateFormat(m.loTXT.DateFormat)
      m.liCentury=This.GetCentury(This.Century)
      This.oTXT=.NULL.

      DO CASE
         CASE m.luDateFormat=DateTF_Long && long
              STORE 0 TO m.liY, m.liM, m.liD

         CASE m.luDateFormat=DateTF_Short && short
              m.lcDateStr=This.GetShortDateFormatString(m.loTXT)

              m.liY=AT(IIF(m.liCentury=1, "YYYY", 'YY'), m.lcDateStr)
              m.liM=AT("MM", m.lcDateStr)
              m.liD=AT("DD", m.lcDateStr)

         CASE INLIST(m.luDateFormat, DateTF_American, DateTF_USA, DateTF_MDY)
              m.liY=7
              m.liM=1
              m.liD=4

         CASE INLIST(m.luDateFormat, DateTF_Ansi, DateTF_Japan, DateTF_Taiwan, DateTF_YMD)
              m.liY=1
              m.liM=IIF(m.liCentury=1, 6, 4)
              m.liD=IIF(m.liCentury=1, 9, 7)

         OTHERWISE
              m.liY=7
              m.liM=4
              m.liD=1

     ENDCASE

     DO CASE
        CASE BETWEEN(m.liSelStart+1, m.liD, m.liD+1)
             IF m.lcType="C"
                m.luValue=This.ToString(m.loTXT, This.ToDate(m.loTXT, m.loTXT.Value)+m.liDelta*1)
             ELSE
                m.luValue=m.loTXT.Value+m.liDelta*1
             ENDIF
             m.liSelStart=m.liD-1
             m.liSelLength=2
     
        CASE BETWEEN(m.liSelStart+1, m.liM, m.liM+1)
             IF m.lcType="C"
                m.luValue=This.ToString(m.loTXT, GOMONTH(This.ToDate(m.loTXT, m.loTXT.Value), m.liDelta*1))
             ELSE
                m.luValue=GOMONTH(m.loTXT.Value, m.liDelta*1)
             ENDIF
             m.liSelStart=m.liM-1
             m.liSelLength=2
        
        CASE BETWEEN(m.liSelStart+1, m.liY, m.liY+IIF(m.liCentury=1, 3, 1))
             IF m.lcType="C"
                m.luValue=This.ToString(m.loTXT, GOMONTH(This.ToDate(m.loTXT, m.loTXT.Value), m.liDelta*12))
             ELSE
                luValue=GOMONTH(m.loTXT.Value,m.liDelta*12)
             ENDIF
             m.liSelStart=m.liY-1
             m.liSelLength=IIF(m.liCentury=1, 4, 2)

     ENDCASE
     RETURN m.luValue
   ENDPROC
ENDDEFINE






DEFINE CLASS _DATETIME AS _DATE
   Name="_DATETIME"

   TimeSeparator=.NULL.

   PROCEDURE TimeSeparator_Access
      *
      * _DATETIME::TimeSeparator_Access()
      *
      LOCAL m.lcTS, m.lii
      m.lcTS=REPLICATE(CHR(0),20)
      m.lii=__DTCLASS_GetLocaleInfo(__DTCLASS_GetThreadLocale(), LOCALE_STIME, @m.lcTS, LEN(m.lcTS))
      RETURN LEFT(m.lcTS, m.lii-1)
   ENDPROC


   PROCEDURE GoMonth
      *
      * _DATETIME::GoMonth()
      *
      LPARAMETERS m.ldDateTime, m.liDelta
      
      * ldDateTime - datetime
      LOCAL m.lcTime
      m.lcTime=RIGHT(TTOC(m.ldDateTime), 9)
      RETURN CTOT("^"+LEFT(TTOC(GOMONTH(m.ldDateTime, m.liDelta), 3), 10)+m.lcTime) 
   ENDPROC

   
   PROCEDURE ToDate && Convert string expression to datetime
      *
      * _DATETIME::ToDate()
      *
      LPARAMETERS m.loTXT, m.lcDate
      
      * loTXT  - .NULL. or reference on textbox s date value (Date/string)
      * lcDate - date and time in string expression
      LOCAL m.ldDate, m.liCentury
      m.liCentury=This.GetCentury(This.Century)
      m.ldDate=DODEFAULT(m.loTXT, LEFT(m.lcDate, IIF(m.liCentury=1, 10, 8)))
      RETURN CTOT("^"+LEFT(TTOC(m.ldDate, 3), 10)+SUBSTR(m.lcDate, IIF(m.liCentury=1, 11, 9))) 
   ENDPROC


   PROCEDURE ToString && Convert datetime to string
      *
      * _DATETIME::ToString()
      *
      LPARAMETERS m.loTXT, m.ldDateTime
      
      * loTXT  - .NULL. or reference on textbox s date value (Date/string)
      * ldDate - Datetime
      LOCAL m.lcDate, m.lcTime, m.lcTS
      m.lcDate=DODEFAULT(m.loTXT, TTOD(m.ldDateTime))
      m.lcTime=RIGHT(TTOC(m.ldDateTime, 1), 6)
      m.lcTS=This.TimeSeparator
      * pøidej k tomu èas
      RETURN m.lcDate+" "+LEFT(m.lcTime, 2)+m.lcTS+SUBST(m.lcTime, 3, 2)+m.lcTS+RIGHT(m.lcTime, 2)
   ENDPROC


   PROCEDURE GetShortDateFormatString
      *
      * _DATETIME::GetShortDateFormatString()
      *
      LPARAMETERS m.loTXT

      * loTXT  - .NULL. or reference on textbox s date value (Date/string)
      RETURN DODEFAULT(m.loTXT)+STRTRAN(" 99#99#99", "#", This.TimeSeparator)
   ENDPROC


   PROCEDURE SetFormatString && Set Format a InputString by reginal setings
      *
      * _DATETIME::SetFormatString()
      *
      LPARAMETERS m.loTXT
      
      * loTXT  - .NULL. or reference on textbox s date value (Date/string)
      DODEFAULT(m.loTXT)
      LOCAL m.lcMaskT, m.lcTS
      This.oTXT=m.loTXT
      m.lcMaskT=" 99#99#99"
      m.lcTS=This.TimeSeparator
      This.Format=This.Format+STRTRAN(m.lcMaskT, "#", m.lcTS)
      This.InputMask=This.InputMask+STRTRAN(m.lcMaskT, "#" ,m.lcTS)
      This.oTXT=.NULL.
   ENDPROC


   PROCEDURE IncDec && Increase/decrease day/month/year
      *
      * _DATETIME::IncDec()
      *
      LPARAMETERS m.loTXT, m.liDelta, m.liSelStart, m.liSelLength
       
      * loTXT  - .NULL. or reference on textbox s date value (Date/string)
      IF m.loTXT.Text=This.GetStringBlankDate(m.loTXT)
         RETURN m.loTXT.Value
      ENDIF

      LOCAL m.luDateFormat, m.liY, m.liM, m.liD, m.liDelta, m.lcType, m.luValue, m.liCentury, m.liHH, m.liMI, m.liSS
      m.lcType=VARTYPE(m.loTXT.Value)
      This.oTXT=loTXT
      m.luDateFormat=This.GetDateFormat(m.loTXT.DateFormat)
      m.liCentury=This.GetCentury(This.Century)
      This.oTXT=.NULL.

      DO CASE
         CASE m.luDateFormat=DateTF_Long && long
              STORE 0 TO m.liY, m.liM, m.liD

         CASE m.luDateFormat=DateTF_Short && short
              m.lcDateStr=This.GetShortDateFormatString(m.loTXT)

              m.liY=AT(IIF(m.liCentury=1, "YYYY", 'YY'), m.lcDateStr)
              m.liM=AT("MM", m.lcDateStr)
              m.liD=AT("DD", m.lcDateStr)

         CASE INLIST(m.luDateFormat, DateTF_American, DateTF_USA, DateTF_MDY)
              m.liY=7
              m.liM=1
              m.liD=4

         CASE INLIST(m.luDateFormat, DateTF_Ansi, DateTF_Japan, DateTF_Taiwan, DateTF_YMD)
              m.liY=1
              m.liM=IIF(m.liCentury=1, 6, 4)
              m.liD=IIF(m.liCentury=1, 9, 7)

         OTHERWISE && MDY     MM.DD.YYYY HH:MI:SS
              m.liY=7
              m.liM=4
              m.liD=1

     ENDCASE
     m.liHH=12-IIF(m.liCentury=1, 0, 2)
     m.liMI=15-IIF(m.liCentury=1, 0, 2)
     m.liSS=18-IIF(m.liCentury=1, 0, 2)

     DO CASE
        CASE BETWEEN(m.liSelStart+1, m.liD, m.liD+1)
             IF m.lcType="C"
                m.luValue=This.ToString(m.loTXT, This.ToDate(m.loTXT, m.loTXT.Value)+m.liDelta*1*60*60*24)
             ELSE
                m.luValue=m.loTXT.Value+m.liDelta*1*60*60*24
             ENDIF
             m.liSelStart=m.liD-1
             m.liSelLength=2
     
        CASE BETWEEN(m.liSelStart+1, m.liM, m.liM+1)
             IF m.lcType="C"
                m.luValue=This.ToString(m.loTXT, This.GOMONTH(This.ToDate(m.loTXT, m.loTXT.Value), m.liDelta*1))
             ELSE
                m.luValue=This.GOMONTH(m.loTXT.Value, m.liDelta*1)
             ENDIF
             m.liSelStart=m.liM-1
             m.liSelLength=2
        
        CASE BETWEEN(m.liSelStart+1, m.liY, m.liY+IIF(m.liCentury=1, 3, 1))
             IF m.lcType="C"
                m.luValue=This.ToString(m.loTXT, This.GOMONTH(This.ToDate(m.loTXT, m.loTXT.Value), m.liDelta*12))
             ELSE
                m.luValue=This.GOMONTH(m.loTXT.Value, m.liDelta*12)
             ENDIF
             m.liSelStart=m.liY-1
             m.liSelLength=IIF(m.liCentury=1, 4, 2)

        CASE BETWEEN(m.liSelStart+1, m.liHH, m.liHH+1) && Hours
             IF m.lcType="C"
                m.luValue=This.ToString(m.loTXT, This.ToDate(m.loTXT, m.loTXT.Value)+m.liDelta*1*60*60)
             ELSE
                m.luValue=m.loTXT.Value+m.liDelta*1*60*60
             ENDIF
             m.liSelStart=m.liHH-1
             m.liSelLength=2

        CASE BETWEEN(m.liSelStart+1, m.liMI, m.liMI+1) && Minutes
             IF m.lcType="C"
                m.luValue=This.ToString(m.loTXT, This.ToDate(m.loTXT, m.loTXT.Value)+m.liDelta*1*60)
             ELSE
                m.luValue=m.loTXT.Value+m.liDelta*1*60
             ENDIF
             m.liSelStart=m.liMI-1
             m.liSelLength=2

        CASE BETWEEN(m.liSelStart+1, m.liSS, m.liSS+1) && Seconds
             IF m.lcType="C"
                m.luValue=This.ToString(m.loTXT, This.ToDate(m.loTXT, m.loTXT.Value)+m.liDelta)
             ELSE
                m.luValue=m.loTXT.Value+m.liDelta
             ENDIF
             m.liSelStart=m.liSS-1
             m.liSelLength=2

     ENDCASE
     RETURN m.luValue
   ENDPROC

ENDDEFINE
