
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура УстановкаПараметровСеанса(ИменаПараметровСеанса)
	
	ПараметрыСеанса.СОД_Обмен = Новый ФиксированнаяСтруктура("СОД_БезРегистрации", Ложь);

КонецПроцедуры

#КонецОбласти

#КонецЕсли