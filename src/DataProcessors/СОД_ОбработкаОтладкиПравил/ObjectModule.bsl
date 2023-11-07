#Если Сервер Тогда
	
#Область ОписаниеПеременных

Перем МодульСистемы Экспорт;

Перем СоответствиеМетаданных Экспорт;
Перем СоответствиеРегистраций Экспорт;

#КонецОбласти

#Область ПрограммныйИнтерфейс

// ПЕРЕЧИСЛЕНИЯ

Функция Перечисление_ТЕСТ_СтавкаНДС_Чтение(Ссылка, Ключи = Ложь, Регистрация = Неопределено) Экспорт

	Возврат МодульСистемы.ПолучитьПолнуюСсылку(Ссылка);

КонецФункции

Функция Перечисление_ТЕСТ_СтавкаНДС_Запись(ЭтаСтруктура, Поиск = Ложь, Регистрация = Неопределено) Экспорт
	
	Если Не ЗначениеЗаполнено(ЭтаСтруктура.Значение) Тогда
		ВызватьИсключение "Операция прервана ! Не заполнено значение объекта !";
	КонецЕсли;
	
	УстановитьБезопасныйРежим(Истина);
	ЭтиДанные = Вычислить("Перечисления.ТЕСТ_СтавкаНДС." + ЭтаСтруктура.Значение);
	УстановитьБезопасныйРежим(Ложь);
		
	Возврат ЭтиДанные;
	
КонецФункции
	
// СПРАВОЧНИКИ

Функция Справочник_ТЕСТ_Номенклатура_Чтение(Ссылка, Ключи = Ложь, Регистрация = Неопределено) Экспорт
	
	Возврат УниверсальнаяСтруктураИзОбъекта_Чтение(Ссылка, Ключи);
	
КонецФункции

Функция Справочник_ТЕСТ_Номенклатура_Запись(ЭтаСтруктура, Поиск = Ложь, Регистрация = Неопределено) Экспорт
	
	Возврат СправочникИзУниверсальнойСтруктуры_Запись(ЭтаСтруктура, Поиск, Регистрация); 
					
КонецФункции

Функция Справочник_ТЕСТ_ВидыНоменклатуры_Чтение(Ссылка, Ключи = Ложь, Регистрация = Неопределено) Экспорт
	
	Возврат УниверсальнаяСтруктураИзОбъекта_Чтение(Ссылка, Ключи);
	
КонецФункции

Функция Справочник_ТЕСТ_ВидыНоменклатуры_Запись(ЭтаСтруктура, Поиск = Ложь, Регистрация = Неопределено) Экспорт
	
	Возврат СправочникИзУниверсальнойСтруктуры_Запись(ЭтаСтруктура, Поиск, Регистрация); 
	
КонецФункции

// СПРАВОЧНИКИ: РЕГИСТРАЦИИ

Функция Справочник_ТЕСТ_Номенклатура_Регистрация(Ссылка, Регистрация = Неопределено) Экспорт
	
	Возврат Не ПараметрыСеанса.СОД_Обмен.СОД_БезРегистрации;  

КонецФункции

Функция Справочник_ТЕСТ_ВидыНоменклатуры_Регистрация(Ссылка, Регистрация = Неопределено) Экспорт

	Возврат Не ПараметрыСеанса.СОД_Обмен.СОД_БезРегистрации; 

КонецФункции

// ДОКУМЕНТЫ

Функция Документ_ТЕСТ_ПриходныйОрдер_Чтение(Ссылка, Ключи = Ложь, Регистрация = Неопределено) Экспорт
	
	Возврат УниверсальнаяСтруктураИзОбъекта_Чтение(Ссылка, Ключи);		
	
КонецФункции

Функция Документ_ТЕСТ_ПриходныйОрдер_Запись(ЭтаСтруктура, Поиск = Ложь, Регистрация = Неопределено) Экспорт
					
	Возврат ДокументИзУниверсальнойСтруктуры_Запись(ЭтаСтруктура, Поиск, Регистрация);

КонецФункции

// ДОКУМЕНТЫ: РЕГИСТРАЦИИ

Функция Документ_ТЕСТ_ПриходныйОрдер_Регистрация(Ссылка, Регистрация = Неопределено) Экспорт
	
	Возврат Не ПараметрыСеанса.СОД_Обмен.СОД_БезРегистрации; 

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция УниверсальнаяСтруктураИзОбъекта_Чтение(Ссылка, Ключи)

	ЭтаСтруктура = Новый Структура;

	Структура = МодульСистемы.ПолучитьПолнуюСсылку(Ссылка);
	
	ЭтаСтруктура.Вставить("Ссылка", Структура);
	
	Если Ключи Тогда
		ЭтаСтруктура.Вставить("ИНС_ВнешнийКлюч", Ссылка.ИНС_ВнешнийКлюч);
	Иначе
		МодульСистемы.УниверсальнаяСтруктураИзОбъекта_Чтение(Ссылка, ЭтаСтруктура);
	КонецЕсли;
	
	Возврат ЭтаСтруктура;	
	
КонецФункции

Функция СправочникИзУниверсальнойСтруктуры_Запись(ЭтаСтруктура, Поиск, Регистрация)
	
	Если Не ЗначениеЗаполнено(ЭтаСтруктура.ИНС_ВнешнийКлюч) Тогда
		ВызватьИсключение "Операция прервана ! Внешний ключ не может быть пустой !";
	КонецЕсли;

	Ссылка = Справочники[ЭтаСтруктура.Ссылка.Имя].НайтиПоРеквизиту("ИНС_ВнешнийКлюч", ЭтаСтруктура.ИНС_ВнешнийКлюч);

	Если Поиск Тогда
		Возврат Ссылка;
	КонецЕсли;

	Если Ссылка.Пустая() Тогда

		Если ЭтаСтруктура.Свойство("ЭтоГруппа") И ЭтаСтруктура.ЭтоГруппа Тогда
			ЭтиДанные = Справочники[ЭтаСтруктура.Ссылка.Имя].СоздатьГруппу();
		Иначе
			ЭтиДанные = Справочники[ЭтаСтруктура.Ссылка.Имя].СоздатьЭлемент();
		КонецЕсли;

		ЭтиДанные.УстановитьНовыйКод();

	Иначе
		ЭтиДанные = Ссылка.ПолучитьОбъект();
	КонецЕсли;

	МодульСистемы.ОбъектИзУниверсальнойСтруктуры_Запись(ЭтиДанные, ЭтаСтруктура);

	ПараметрыСеанса.СОД_Обмен = Новый ФиксированнаяСтруктура("СОД_БезРегистрации", Истина);

	ЭтиДанные.Записать();

	Возврат ЭтиДанные.Ссылка;

КонецФункции

Функция ДокументИзУниверсальнойСтруктуры_Запись(ЭтаСтруктура, Поиск, Регистрация)
	
	Если Не ЗначениеЗаполнено(ЭтаСтруктура.ИНС_ВнешнийКлюч) Тогда
		ВызватьИсключение "Операция прервана ! Внешний ключ не может быть пустой !";
	КонецЕсли;

	Ссылка = Документы[ЭтаСтруктура.Ссылка.Имя].НайтиПоРеквизиту("ИНС_ВнешнийКлюч", ЭтаСтруктура.ИНС_ВнешнийКлюч);

	Если Поиск Тогда
		Возврат Ссылка;
	КонецЕсли;

	Если Ссылка.Пустая() Тогда

		ЭтиДанные = Документы[ЭтаСтруктура.Ссылка.Имя].СоздатьДокумент();

		ЭтиДанные.УстановитьСсылкуНового(Ссылка);

	Иначе
		ЭтиДанные = Ссылка.ПолучитьОбъект();
	КонецЕсли;

	МодульСистемы.УниверсальнаяСтруктураИзОбъекта_Чтение(ЭтиДанные, ЭтаСтруктура);

	ПараметрыСеанса.СОД_Обмен = Новый ФиксированнаяСтруктура("СОД_БезРегистрации", Истина);

	РежимЗаписи = МодульСистемы.РежимЗаписи(ЭтиДанные, ЭтаСтруктура);
	ЭтиДанные.Записать(РежимЗаписи, РежимПроведенияДокумента.Неоперативный);

	Возврат ЭтиДанные.Ссылка;
	
КонецФункции

#КонецОбласти

#Область Инициализация

СоответствиеМетаданных = Новый Соответствие;

СоответствиеМетаданных["Перечисление_ТЕСТ_СтавкаНДС"]	= "МодульПравил.Перечисление_ТЕСТ_СтавкаНДС";
СоответствиеМетаданных["Справочник_ТЕСТ_Номенклатура"]	= "МодульПравил.Справочник_ТЕСТ_Номенклатура";
СоответствиеМетаданных["Справочник_ТЕСТ_ВидыНоменклатуры"]	= "МодульПравил.Справочник_ТЕСТ_ВидыНоменклатуры";
СоответствиеМетаданных["Документ_ТЕСТ_ПриходныйОрдер"]	= "МодульПравил.Документ_ТЕСТ_ПриходныйОрдер";

СоответствиеРегистраций = Новый Соответствие;

СоответствиеРегистраций["Справочник_ТЕСТ_Номенклатура"]	= Новый Структура("ИмяМетодаРегистрации, Включен", "МодульПравил.Справочник_ТЕСТ_Номенклатура", Истина);
СоответствиеРегистраций["Справочник_ТЕСТ_ВидыНоменклатуры"]	= Новый Структура("ИмяМетодаРегистрации, Включен", "МодульПравил.Справочник_ТЕСТ_ВидыНоменклатуры", Истина);
СоответствиеРегистраций["Документ_ТЕСТ_ПриходныйОрдер"]	= Новый Структура("ИмяМетодаРегистрации, Включен", "МодульПравил.Документ_ТЕСТ_ПриходныйОрдер", Истина);

#КонецОбласти

#КонецЕсли