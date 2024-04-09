﻿
Процедура Печать(ТабДок, Ссылка) Экспорт
	//{{_КОНСТРУКТОР_ПЕЧАТИ(Печать)
	Макет = Документы.ВыпускИзДетскогоСада.ПолучитьМакет("Печать");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ВыпускИзДетскогоСада.Воспитанник,
	|	ВыпускИзДетскогоСада.Группа,
	|	ВыпускИзДетскогоСада.Дата,
	|	ВыпускИзДетскогоСада.ДатаВыпуска,
	|	ВыпускИзДетскогоСада.Номер,
	|	ВыпускИзДетскогоСада.ТЧ_Дети.(
	|		НомерСтроки,
	|		Ребенок,
	|		ДатаРождения,
	|		ДатаЗачисления,
	|		ДатаВыпуска
	|	)
	|ИЗ
	|	Документ.ВыпускИзДетскогоСада КАК ВыпускИзДетскогоСада
	|ГДЕ
	|	ВыпускИзДетскогоСада.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ОбластьТЧ_ДетиШапка = Макет.ПолучитьОбласть("ТЧ_ДетиШапка");
	ОбластьТЧ_Дети = Макет.ПолучитьОбласть("ТЧ_Дети");
	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

		ТабДок.Вывести(ОбластьЗаголовок);

		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка, Выборка.Уровень());

		ТабДок.Вывести(ОбластьТЧ_ДетиШапка);
		ВыборкаТЧ_Дети = Выборка.ТЧ_Дети.Выбрать();
		Пока ВыборкаТЧ_Дети.Следующий() Цикл
			ОбластьТЧ_Дети.Параметры.Заполнить(ВыборкаТЧ_Дети);
			ТабДок.Вывести(ОбластьТЧ_Дети, ВыборкаТЧ_Дети.Уровень());
		КонецЦикла;

		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	//}}
КонецПроцедуры
