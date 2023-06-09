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

Процедура ТЕСТ_СправочникОбъект_ПриЗаписи(Источник, Отказ) Экспорт
		
	Если ТипЗнч(Источник) = Тип("СправочникОбъект.ТЕСТ_Номенклатура") Тогда
		
		ОтправлениеСтруктура = Новый Структура;
		ОтправлениеСтруктура.Вставить("Маршрут",			Неопределено);
		ОтправлениеСтруктура.Вставить("ДвоичныеДанные",		Неопределено);
		ОтправлениеСтруктура.Вставить("ТекстовыеДанные",	Неопределено);
		
		СОД_Обмен = СОД_Синхронизация.ПолучитьМодульСистемы();
		СОД_Обмен.Инициализировать(СОД_МаршрутизацияВызовСервераПовтИсп.ОбработкаОтладкиПравил());
                                                                                                                        
		Если Не СОД_Обмен.МодульПравил.Справочник_ТЕСТ_Номенклатура_Регистрация(Источник) Тогда
			Возврат;
		КонецЕсли;
		
		ОтправлениеСтруктура.ТекстовыеДанные = СОД_Обмен.МодульПравил.Справочник_ТЕСТ_Номенклатура_Чтение(Источник);
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		               |	СОД_Узлы.Ссылка КАК Ссылка
		               |ИЗ
		               |	ПланОбмена.СОД_Узлы КАК СОД_Узлы
		               |ГДЕ
		               |	НЕ СОД_Узлы.ЭтотУзел";
		
		Узлы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
		
		Для Каждого Узел Из Узлы Цикл  
			
			Если Не ЗначениеЗаполнено(СОД_Синхронизация.Зарегистрировать(Узел, Источник.Ссылка, ОтправлениеСтруктура)) Тогда
				ВызватьИсключение "Пояснение СОД: Не удалось зарегистрировать объект для отправки. Запись отменена.";
			КонецЕсли;	
			
		КонецЦикла;
			
	КонецЕсли;
		 
КонецПроцедуры

#КонецОбласти
