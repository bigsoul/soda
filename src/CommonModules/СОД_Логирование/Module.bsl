////////////////////////////////////////////////////////////////////////////////
// Клиентские процедуры и функции общего назначения:
// - для работы со списками в формах;
// - для работы с журналом регистрации;
// - для обработки действий пользователя в процессе редактирования
//   многострочного текста, например комментария в документах;
// - прочее.
//  
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Функция СоздатьНовыйФайл() Экспорт
	
	Если Не СОД_СинхронизацияВызовСервераПовтИсп.СоздаватьФайлLog() Тогда
		Возврат "";
	КонецЕсли;
	
	ПолноеИмяФайла = СОД_СинхронизацияВызовСервераПовтИсп.ПутьККаталогуФайлаLog() + "\" + СтрЗаменить(УниверсальноеВремя( ТекущаяДатаСеанса() ), ":", "-") + ".txt";
	
	ТекДок = Новый ТекстовыйДокумент;
	ТекДок.Записать(ПолноеИмяФайла);
	
	ДобавитьСтроку(ПолноеИмяФайла, " Файл создан в: " + УниверсальноеВремя( ТекущаяДатаСеанса() )); 
	
	Возврат ПолноеИмяФайла; 
	
КонецФункции

Процедура ДобавитьСтроку(ПолноеИмяФайла, Текст) Экспорт
	
	Если Не СОД_СинхронизацияВызовСервераПовтИсп.СоздаватьФайлLog() Тогда
		Возврат;
	КонецЕсли;
	
	ТекДок = Новый ТекстовыйДокумент;
	ТекДок.Прочитать(ПолноеИмяФайла);
	ТекДок.ДобавитьСтроку(Текст);
	ТекДок.Записать(ПолноеИмяФайла);

КонецПроцедуры

#КонецОбласти