#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	ОбновитьПовторноИспользуемыеЗначения();	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОтправитьТестовоеПисьмо(Команда)
	
	СОД_Синхронизация.ОтправитьЭлектронноеПисьмоБрокера("Тестовое письмо монитора брокера СОД.");
	
КонецПроцедуры

#КонецОбласти