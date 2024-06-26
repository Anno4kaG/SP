﻿
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПолеВыбораТипаДиаграммы=ТипДиаграммы.Гистограмма;
	Диаграмма.ТипДиаграммы=ПолеВыбораТипаДиаграммы;
КонецПроцедуры

&НаКлиенте
Процедура ПолеВыбораТипаДиаграммыПриИзменении(Элемент)
	Диаграмма.ТипДиаграммы=ПолеВыбораТипаДиаграммы;
КонецПроцедуры

&НаСервере
Процедура КомандаСформироватьДиаграммуНаСервере()
	ЗапросДанных=Новый Запрос;
	ЗапросДанных.Текст=
	"ВЫБРАТЬ
	|	ЗачислениеВДетскийСад.Группа КАК Группа,
	|	КОЛИЧЕСТВО(ЗачислениеВДетскийСад.Воспитанник) КАК Заполненность
	|ИЗ
	|	Документ.ЗачислениеВДетскийСад КАК ЗачислениеВДетскийСад
	|
	|СГРУППИРОВАТЬ ПО
	|	ЗачислениеВДетскийСад.Группа
	|
	|УПОРЯДОЧИТЬ ПО
	|	Заполненность УБЫВ";
	ВыборкаДанных=ЗапросДанных.Выполнить().Выбрать();
	
	Диаграмма.Обновление=Ложь;
	Диаграмма.АвтоТранспонирование=Ложь;
	
	ТочкаДиаграммы=Диаграмма.УстановитьТочку("Заполненность");
	
	Пока ВыборкаДанных.Следующий()Цикл
		ТекущаяСерияДиаграммы=Диаграмма.УстановитьСерию(ВыборкаДанных.Группа);
		Диаграмма.УстановитьЗначение(ТочкаДиаграммы, ТекущаяСерияДиаграммы, ВыборкаДанных.Заполненность);
	КонецЦикла;
	Диаграмма.Обновление=Истина;
	Диаграмма.АвтоТранспонирование=Истина;
КонецПроцедуры

&НаКлиенте
Процедура КомандаСформироватьДиаграмму(Команда)
	КомандаСформироватьДиаграммуНаСервере();
КонецПроцедуры
