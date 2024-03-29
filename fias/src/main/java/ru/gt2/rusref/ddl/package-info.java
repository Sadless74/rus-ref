/**
 * Пакет для создания sql-запросов для генерации структуры таблиц.
 *
 * Хотя, с другой стороны, нужно ли нам это особо писать руками, если есть openjpa, в котором это всё есть.
 * Ну не всё, комментариев там нет. Но большая часть всё-таки имеется. Может удасться обойтись простым расширением.
 * Сначала нужно провести сверку структуры из описания с тем что есть на самом деле.
 *
 * Хотя нет, сверку структуры мы в процесс обработки проведём. Главное не падать при обнаружении ошибки,
 * а писать её в журнал и продолжлать обработку.
 *
 * Дальше собственно только создание структуры и запись самих данных,
 * http://java-persistence-performance.blogspot.com/2011/06/how-to-improve-jpa-performance-by-1825.html
 *
 * Да уж, openjpa как-то не особо хорошо разбирает поля. Ни комментариев, ни правильной длины строк.
 * Фигня какая-то получается. наверное всё-таки лучше писать свой велосипед.hg
 *
 * FIXME Добавить аннотацию @Temporal в список обязательных для даты.
 *
 * Особо задерживаться не хочется, пусть будет схема на базе той, что сгенерирована openjpa'шным генератором.
 * Нужно только будет её подкорректировать так, чтобы все данные влезли. Пройдёмся по таблицам в SQL и сравним
 * с тем что записано в отчёте по чтению.
 */
package ru.gt2.rusref.ddl;