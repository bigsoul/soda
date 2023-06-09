#Если Сервер Тогда
	
#Область ОписаниеПеременных

Перем МодульСистемы Экспорт;

Перем СоответствиеМетаданных Экспорт;
Перем СоответствиеРегистраций Экспорт;

#КонецОбласти

#Область ПрограммныйИнтерфейс

// СПРАВОЧНИКИ

Функция Справочник_ТЕСТ_Номенклатура_Чтение(Ссылка, Ключи = Ложь, Метод = Неопределено) Экспорт
	
	ЭтаСтруктура = Новый Структура;
	
	// стандартные простые
	
	ЭтаСтруктура.Вставить("Ссылка",				МодульСистемы.ПолучитьПолнуюСсылку(Ссылка));
		
	ЭтаСтруктура.Ссылка.Вставить("Метод", 		Метод);
	
	Если Ключи Тогда
		Возврат ЭтаСтруктура;
	КонецЕсли;
	
	ЭтаСтруктура.Вставить("ЭтоГруппа",			Ссылка.ЭтоГруппа);
	ЭтаСтруктура.Вставить("Родитель",			Справочник_ТЕСТ_Номенклатура_Чтение(Ссылка.Родитель, Истина));
	ЭтаСтруктура.Вставить("Наименование",		Ссылка.Наименование);
	ЭтаСтруктура.Вставить("ПометкаУдаления",	Ссылка.ПометкаУдаления);
	
	Если Не ЭтаСтруктура.ЭтоГруппа Тогда
		ЭтаСтруктура.Вставить("ДатаОбновления",		Ссылка.ДатаОбновления);
		ЭтаСтруктура.Вставить("ВПродаже",			Ссылка.ВПродаже);
		ЭтаСтруктура.Вставить("Доступность",		Ссылка.Доступность);
	КонецЕсли;
	
	Возврат ЭтаСтруктура; 	
	
КонецФункции

Функция Справочник_ТЕСТ_Номенклатура_Запись(ЭтаСтруктура, Поиск = Ложь, Метод = Неопределено) Экспорт
					
	Ссылка = Справочники.ТЕСТ_Номенклатура.ПолучитьСсылку(Новый УникальныйИдентификатор(ЭтаСтруктура.Ссылка.ГУИД));
	
	Если Поиск Тогда
		Возврат Ссылка;
	КонецЕсли;
	
	ЭтиДанные = Ссылка.ПолучитьОбъект(); 
	
	Если ЭтиДанные = Неопределено Тогда
		Если ЭтаСтруктура.ЭтоГруппа Тогда
			ЭтиДанные = Справочники.ТЕСТ_Номенклатура.СоздатьГруппу();
		Иначе
			ЭтиДанные = Справочники.ТЕСТ_Номенклатура.СоздатьЭлемент();
		КонецЕсли;
		ЭтиДанные.УстановитьСсылкуНового(Ссылка); 		
	Иначе
		ЭтиДанные = Ссылка.ПолучитьОбъект();	
	КонецЕсли;   
	
	// стандартные простые
	
	ЭтиДанные.Родитель				= Справочник_ТЕСТ_Номенклатура_Запись(ЭтаСтруктура.Родитель, Истина);
	ЭтиДанные.Наименование			= ЭтаСтруктура.Наименование;
	ЭтиДанные.ПометкаУдаления		= ЭтаСтруктура.ПометкаУдаления;
	
	Если Не ЭтиДанные.ЭтоГруппа Тогда
		ЭтиДанные.ДатаОбновления		= ЭтаСтруктура.ДатаОбновления;
		ЭтиДанные.ВПродаже				= ЭтаСтруктура.ВПродаже;
		ЭтиДанные.Доступность			= ЭтаСтруктура.Доступность;
	КонецЕсли;
	
	ЭтиДанные.СОД_БезРегистрации	= Истина;
	
	ЭтиДанные.Записать();	

	Возврат ЭтиДанные.Ссылка;   

КонецФункции

// СПРАВОЧНИКИ: РЕГИСТРАЦИИ

Функция Справочник_ТЕСТ_Номенклатура_Регистрация(Ссылка, Метод = Неопределено) Экспорт
	
	Возврат Не Ссылка.СОД_БезРегистрации; 

КонецФункции

#КонецОбласти

#Область Инициализация

СоответствиеМетаданных = Новый Соответствие;

СоответствиеМетаданных["Справочник_ТЕСТ_Номенклатура"]	= "МодульПравил.Справочник_ТЕСТ_Номенклатура";

СоответствиеРегистраций = Новый Соответствие;

СоответствиеРегистраций["Справочник_ТЕСТ_Номенклатура"]	= Новый Структура("ИмяМетодаРегистрации, Включен", "МодульПравил.Справочник_ТЕСТ_Номенклатура", Истина);

#КонецОбласти

#КонецЕсли