//ищет все строки в CSV-файла, с разделителем в виде ";" или "," (настраивается вручную в шаблоне регулярного выражения)
//каждое поле - в кавычках

#Использовать cmdline

Перем РегЭксп;

Функция НайтиВсеСтроки(ПолноеИмяФайла)
	мФайлы = НайтиФайлы(ПолноеИмяФайла);
	//открываем исходный файл
	т = Новый ТекстовыйДокумент;
	т.Прочитать(ПолноеИмяФайла, КодировкаТекста.ANSI);
	тт = т.получитьТекст();
	//поля таблицы (39)
	//DATESTAMP;INSTRUMENT_ID;LIST_SECTION;RN;SUPERTYPE;INSTRUMENT_TYPE;INSTRUMENT_CATEGORY;TRADE_CODE;ISIN;REGISTRY_NUMBER;REGISTRY_DATE;EMITENT_FULL_NAME;INN;NOMINAL;CURRENCY;ISSUE_AMOUNT;DECISION_DATE;OKSM_EDR;ONLY_EMITENT_FULL_NAME;REG_COUNTRY;QUALIFIED_INVESTOR;HAS_PROSPECTUS;IS_CONCESSION_AGREEMENT;IS_MORTGAGE_AGENT;INCLUDED_DURING_CREATION;SECURITY_HAS_DEFAULT;SECURITY_HAS_TECH_DEFAULT;INCLUDED_WITHOUT_COMPLIANCE;RETAINED_WITHOUT_COMPLIANCE;HAS_RESTRICTION_CIRCULATION;LISTING_LEVEL_HIST;OBLIGATION_PROGRAM_RN;COUPON_PERCENT;EARLY_REPAYMENT;EARLY_REDEMPTION;ISS_BOARDS;OTHER_SECURITIES;DISCLOSURE_PART_PAGE;DISCLOSURE_RF_INFO_PAGE;
	//пример строки
	//"27.11.2017 0:00:00";"5771";"Первый уровень";"1";"Акции";"Акция обыкновенная";"акции обыкновенные";"CBOM";"RU000A0JUG31";"10101978B";"18.08.1999 0:00:00";"""МОСКОВСКИЙ КРЕДИТНЫЙ БАНК"" (публичное акционерное общество)";"7734202860";"1";"Рубль";"27079709866";"11.03.2014 0:00:00";"";"";"";"";"+";"";"";"";"";"";"";"";"";"22.06.2015 Включение в Первый уровень 09.06.2014 Включение в Второй уровень 11.03.2014 Включение в Котировальный список ""В""";"";"";"";"";"РПС : Акции РЕПО c акциями Т+ Неполные лоты (акции) РЕПО с ЦК 1 день РЕПО с ЦК Адресное Т+ Акции и ДР РПС с ЦК: Акции и ДР РЕПО с ЦК 1 день (расч. в USD) РЕПО с ЦК 1 день (расч. в EUR) РЕПО с ЦК 7 дн. РЕПО с ЦК адр. (расч. в USD) РЕПО с ЦК адр.(расч. в EUR) РЕПО c акциями(расч.в USD) РЕПО с ЦК 7 дней c расчетами в долларах США РЕПО с ЦК 7 дней c расчетами в евро";"Облигация корпоративная, 41101978B, RU000A0JTF50 Облигация корпоративная, 41201978B, RU000A0JTPD7 Облигация биржевая, 4B020601978B, RU000A0JU880 Облигация биржевая, 4B020701978B, RU000A0JU8W1 Облигация биржевая, 4B020801978B, RU000A0JV3K6 Облигация биржевая, 4B020901978B, RU000A0JU898 Облигация биржевая, 4B021001978B, RU000A0JUQQ5 Облигация биржевая, 4B021101978B, RU000A0JUQR3 Облигация биржевая, 4B021201978B Облигация биржевая, 4B021301978B Облигация биржевая, 4B021401978B Облигация биржевая, 4B021501978B";"http://www.mkb.ru";"http://www.e-disclosure.ru/portal/company.aspx?id=202";
	к = Символ(34);
	ШаблонПоля = к + ".*?" + к;
	Шаблон = "^";
	Для сч = 1 по 39 Цикл Шаблон = Шаблон + ШаблонПоля + "," ; КонецЦикла;
	Сообщить(Шаблон);

	РегЭксп = Новый Regex(Шаблон); 
	РегЭксп.IgnoreCase = Истина;
	РегЭксп.Multiline = Истина;

	РегЭкспПоля = Новый Regex(ШаблонПоля + ";");
	РегЭкспПоля.IgnoreCase = Истина;
	РегЭкспПоля.Multiline = Ложь;

	//ищем совпадения
	Совпадения = РегЭксп.НайтиСовпадения(тт);
	Сообщить("Всего совпадений "+Совпадения.Количество() );

	сч=0;
	Для каждого Совпадение Из Совпадения Цикл Поля = РегЭкспПоля.НайтиСовпадения(Совпадение.Значение); сч=сч+1;КонецЦикла;	
		
КонецФункции

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Сообщить("------------------------------------------------------------------");

Парсер = Новый ПарсерАргументовКоманднойСтроки();
Парсер.ДобавитьПараметр("ПутьКФайлу");
Параметры = Парсер.Разобрать(АргументыКоманднойСтроки);
//Сообщить(Параметры["ПутьКФайлу"]);
ИмяФайла = Параметры["ПутьКФайлу"];

НайтиВсеСтроки(ИмяФайла);

