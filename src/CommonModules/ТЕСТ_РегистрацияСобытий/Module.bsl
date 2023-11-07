

////////////////////////////////////////////////////////////////////////////////
// Клиентские процедуры и функции общего назначения:
// - для работы со списками в формах;
// - для работы с журналом регистрации;
// - для обработки действий пользователя в процессе редактирования
//   многострочного текста, например комментария в документах;
// - прочее.
//  
////////////////////////////////////////////////////////////////////////////////
#Область СлужебныеПроцедурыИФункции

Процедура ТЕСТ_СправочникОбъект_ПередЗаписью(Источник, Отказ) Экспорт
	
	Если ТипЗнч(Источник) = Тип("СправочникОбъект.ТЕСТ_Номенклатура") Или ТипЗнч(Источник) = Тип(
		"СправочникОбъект.ТЕСТ_ВидыНоменклатуры") Тогда

		Если Источник.ЭтоНовый() И Не ПараметрыСеанса.СОД_Обмен.СОД_БезРегистрации Тогда
			
			//ЗАПОЛНЕНИЕ ВНЕШНЕГО КЛЮЧА ЗНАЧЕНИЕМ GUID:
			УИД = Новый УникальныйИдентификатор;
			Имя = Источник.Метаданные().Имя;
			Источник.УстановитьСсылкуНового(Справочники[Имя].ПолучитьСсылку(УИД));
			Источник.ИНС_ВнешнийКлюч = Строка(УИД);

		КонецЕсли;

	КонецЕсли;
	
КонецПроцедуры

Процедура ТЕСТ_СправочникОбъект_ПриЗаписи(Источник, Отказ) Экспорт
	
	Если ТипЗнч(Источник) <> Тип("СправочникОбъект.ТЕСТ_Номенклатура") И ТипЗнч(Источник) <> Тип(
		"СправочникОбъект.ТЕСТ_ВидыНоменклатуры") Тогда
		Возврат;
	КонецЕсли;

	Если ПараметрыСеанса.СОД_Обмен.СОД_БезРегистрации Тогда
		Возврат;
	КонецЕсли;
	
	ОтправлениеСтруктура = Новый Структура;
	ОтправлениеСтруктура.Вставить("Маршрут", Неопределено);
	ОтправлениеСтруктура.Вставить("ДвоичныеДанные", Неопределено);
	ОтправлениеСтруктура.Вставить("ТекстовыеДанные", Неопределено);

	СОД_Обмен = СОД_Синхронизация.ПолучитьМодульСистемы();
	СОД_Обмен.Инициализировать(СОД_МаршрутизацияВызовСервераПовтИсп.ОбработкаОтладкиПравил());

	Если ТипЗнч(Источник) = Тип("СправочникОбъект.ТЕСТ_Номенклатура") Тогда

		Если Не СОД_Обмен.МодульПравил.Справочник_ТЕСТ_Номенклатура_Регистрация(Источник) Тогда
			Возврат;
		КонецЕсли;

		ОтправлениеСтруктура.ТекстовыеДанные = СОД_Обмен.МодульПравил.Справочник_ТЕСТ_Номенклатура_Чтение(Источник);

	ИначеЕсли ТипЗнч(Источник) = Тип("СправочникОбъект.ТЕСТ_ВидыНоменклатуры") Тогда

		Если Не СОД_Обмен.МодульПравил.Справочник_ТЕСТ_Номенклатура_Регистрация(Источник) Тогда
			Возврат;
		КонецЕсли;

		ОтправлениеСтруктура.ТекстовыеДанные = СОД_Обмен.МодульПравил.Справочник_ТЕСТ_ВидыНоменклатуры_Чтение(Источник);

	КонецЕсли;

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
				   |	СОД_Узлы.Ссылка КАК Ссылка
				   |ИЗ
				   |	ПланОбмена.СОД_Узлы КАК СОД_Узлы
				   |ГДЕ
				   |	НЕ СОД_Узлы.ЭтотУзел
				   |    И НЕ СОД_Узлы.Отключен";

	Узлы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");

	Для Каждого Узел Из Узлы Цикл

		Если Не ЗначениеЗаполнено(СОД_Синхронизация.Зарегистрировать(Узел, Источник.Ссылка, ОтправлениеСтруктура)) Тогда
			ВызватьИсключение "Пояснение СОД: Не удалось зарегистрировать объект для отправки. Запись отменена.";
		КонецЕсли;

	КонецЦикла;
КонецПроцедуры

Процедура ТЕСТ_ДокументОбъектПередЗаписью(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	Если ТипЗнч(Источник) = Тип("ДокументОбъект.ТЕСТ_ПриходныйОрдер") Тогда

		Если Источник.ЭтоНовый() И Не ПараметрыСеанса.СОД_Обмен.СОД_БезРегистрации Тогда
			
			//ЗАПОЛНЕНИЕ ВНЕШНЕГО КЛЮЧА ЗНАЧЕНИЕМ GUID:
			УИД = Новый УникальныйИдентификатор;
			Имя = Источник.Метаданные().Имя;
			Источник.УстановитьСсылкуНового(Документы[Имя].ПолучитьСсылку(УИД));
			Источник.ИНС_ВнешнийКлюч = Строка(УИД);

		КонецЕсли;

	КонецЕсли;

КонецПроцедуры

Процедура ТЕСТ_ДокументОбъектПриЗаписи(Источник, Отказ) Экспорт

	Если ТипЗнч(Источник) <> Тип("ДокументОбъект.ТЕСТ_ПриходныйОрдер") Тогда
		Возврат;
	КонецЕсли;
	
	Если ПараметрыСеанса.СОД_Обмен.СОД_БезРегистрации Тогда
		Возврат;
	КонецЕсли;

	ОтправлениеСтруктура = Новый Структура;
	ОтправлениеСтруктура.Вставить("Маршрут", Неопределено);
	ОтправлениеСтруктура.Вставить("ДвоичныеДанные", Неопределено);
	ОтправлениеСтруктура.Вставить("ТекстовыеДанные", Неопределено);

	СОД_Обмен = СОД_Синхронизация.ПолучитьМодульСистемы();
	СОД_Обмен.Инициализировать(СОД_МаршрутизацияВызовСервераПовтИсп.ОбработкаОтладкиПравил());

	Если ТипЗнч(Источник) = Тип("ДокументОбъект.ТЕСТ_ПриходныйОрдер") Тогда

		Если Не СОД_Обмен.МодульПравил.Документ_ТЕСТ_ПриходныйОрдер_Регистрация(Источник) Тогда
			Возврат;
		КонецЕсли;

		ОтправлениеСтруктура.ТекстовыеДанные = СОД_Обмен.МодульПравил.Документ_ТЕСТ_ПриходныйОрдер_Чтение(Источник);

	//ИначеЕсли ТипЗнч(Источник) = Тип("ДокументОбъект.ТЕСТ_.....") Тогда

	КонецЕсли;

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
				   |	СОД_Узлы.Ссылка КАК Ссылка
				   |ИЗ
				   |	ПланОбмена.СОД_Узлы КАК СОД_Узлы
				   |ГДЕ
				   |	НЕ СОД_Узлы.ЭтотУзел
				   |    И НЕ СОД_Узлы.Отключен";

	Узлы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");

	Для Каждого Узел Из Узлы Цикл

		Если Не ЗначениеЗаполнено(СОД_Синхронизация.Зарегистрировать(Узел, Источник.Ссылка, ОтправлениеСтруктура)) Тогда
			ВызватьИсключение "Пояснение СОД: Не удалось зарегистрировать объект для отправки. Запись отменена.";
		КонецЕсли;

	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти