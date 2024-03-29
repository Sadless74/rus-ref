CREATE DATABASE IF NOT EXISTS `fias`
    COLLATE 'utf8_unicode_ci';
USE `fias`;

CREATE TABLE `AddressObjectGuid` (
  `aoGuid` BINARY(16) NOT NULL COMMENT "Уникальный идентификатор адресного объекта (улицы, города, населенного пункта и т.п.)",
  PRIMARY KEY (`aoGuid`)
) ENGINE = InnoDB, COMMENT "Уникальные идентификаторы адресных объектов для ссылок";

CREATE TABLE `NormativeDocumentType` (
  `docType` INT(10) NOT NULL COMMENT "Тип документа",
  PRIMARY KEY (`docType`)
) ENGINE = InnoDB, COMMENT "Тип документа";

CREATE TABLE `NormativeDocument` (
  `normDoc` BINARY(16) NOT NULL COMMENT "Внешний ключ на нормативный документ",
  `docName` TEXT COMMENT "Наименование документа",
  `docDate` DATETIME COMMENT "Дата документа",
  `docNum` VARCHAR(20) COMMENT "Номер документа",
  `docType` INT(10) NOT NULL COMMENT "Тип документа",
  `docImgId` INT(10) COMMENT "Идентификатор образа (внешний ключ)",
  PRIMARY KEY (`normDoc`),
  FOREIGN KEY (`docType`) REFERENCES `NormativeDocumentType` (`docType`)
) ENGINE = InnoDB, COMMENT "Cведения по нормативным документам, являющимся основанием присвоения адресному элементу наименования";

CREATE TABLE `Landmark` (
  `location` VARCHAR(500) NOT NULL COMMENT "Месторасположение ориентира",
  `postalCode` VARCHAR(6) COMMENT "Почтовый индекс",
  `ifnsFl` VARCHAR(4) COMMENT "Код ИФНС ФЛ",
  `terrIfnsFl` VARCHAR(4) COMMENT "Код территориального участка ИФНС ФЛ",
  `ifnsUl` VARCHAR(4) COMMENT "Код ИФНС ЮЛ",
  `terrIfnsUl` VARCHAR(4) COMMENT "Код территориального участка ИФНС ЮЛ",
  `okato` VARCHAR(11) COMMENT "ОКАТО",
  `oktmo` VARCHAR(8) COMMENT "ОКТМО",
  `updateDate` DATETIME NOT NULL COMMENT "Дата внесения записи",
  `landId` BINARY(16) NOT NULL COMMENT "Уникальный идентификатор записи ориентира",
  `landGuid` BINARY(16) NOT NULL COMMENT "Глобальный уникальный идентификатор ориентира",
  `aoGuid` BINARY(16) NOT NULL COMMENT "Уникальный идентификатор родителшьского объекта (улицы, города, населенного пункта и т.п.)",
  `startDate` DATETIME NOT NULL COMMENT "Начало действия записи",
  `endDate` DATETIME NOT NULL COMMENT "Окончание действия записи",
  `normDoc` BINARY(16) COMMENT "Внешний ключ на нормативный документ",
  PRIMARY KEY (`landId`),
  FOREIGN KEY (`aoGuid`) REFERENCES `AddressObjectGuid` (`aoGuid`),
  FOREIGN KEY (`normDoc`) REFERENCES `NormativeDocument` (`normDoc`)
) ENGINE = InnoDB, COMMENT "Описание места расположения имущественных объектов";

CREATE TABLE `AddressObjectLevel` (
  `level` INT(10) NOT NULL COMMENT "Уровень адресного объекта",
  PRIMARY KEY (`level`)
) ENGINE = InnoDB, COMMENT "Уровень адресного объекта";

CREATE TABLE `AddressObjectType` (
  `level` INT(10) NOT NULL COMMENT "Уровень адресного объекта",
  `scName` VARCHAR(10) COMMENT "Краткое наименование типа объекта",
  `socrName` VARCHAR(31) NOT NULL COMMENT "Полное наименование типа объекта",
  `kodTSt` VARCHAR(4) NOT NULL COMMENT "Ключевое поле",
  PRIMARY KEY (`kodTSt`),
  UNIQUE KEY (`level`, `scName`),
  FOREIGN KEY (`level`) REFERENCES `AddressObjectLevel` (`level`)
) ENGINE = InnoDB, COMMENT "Тип адресного объекта";

CREATE TABLE `CurrentStatus` (
  `curentStId` INT(10) NOT NULL COMMENT "Идентификатор статуса (ключ)",
  `name` VARCHAR(100) NOT NULL COMMENT "Наименование",
  PRIMARY KEY (`curentStId`)
) ENGINE = InnoDB, COMMENT "Статус актуальности КЛАДР 4.0";

CREATE TABLE `ActualStatus` (
  `actStatId` INT(10) NOT NULL COMMENT "Идентификатор статуса (ключ)",
  `name` VARCHAR(100) NOT NULL COMMENT "Наименование",
  PRIMARY KEY (`actStatId`)
) ENGINE = InnoDB, COMMENT "Статус актуальности";

CREATE TABLE `OperationStatus` (
  `operStatId` INT(10) NOT NULL COMMENT "Идентификатор статуса (ключ)",
  `name` VARCHAR(100) NOT NULL COMMENT "Наименование",
  PRIMARY KEY (`operStatId`)
) ENGINE = InnoDB, COMMENT "Статус действия";

CREATE TABLE `CenterStatus` (
  `centerStId` INT(10) NOT NULL COMMENT "Идентификатор статуса (ключ)",
  `name` VARCHAR(100) NOT NULL COMMENT "Наименование",
  PRIMARY KEY (`centerStId`)
) ENGINE = InnoDB, COMMENT "Статус центра";

CREATE TABLE `AddressObject` (
  `aoGuid` BINARY(16) NOT NULL COMMENT "Глобальный уникальный идентификатор адресного объекта",
  `formalName` VARCHAR(120) NOT NULL COMMENT "Формализованное наименование",
  `regionCode` VARCHAR(2) NOT NULL COMMENT "Код региона",
  `autoCode` VARCHAR(1) NOT NULL COMMENT "Код автономии",
  `areaCode` VARCHAR(3) NOT NULL COMMENT "Код района",
  `cityCode` VARCHAR(3) NOT NULL COMMENT "Код города",
  `ctarCode` VARCHAR(3) NOT NULL COMMENT "Код внутригородского района",
  `placeCode` VARCHAR(3) NOT NULL COMMENT "Код насленного пункта",
  `streetCode` VARCHAR(4) COMMENT "Код улицы",
  `extrCode` VARCHAR(4) NOT NULL COMMENT "Код дополнительного адресообразующего элемента",
  `sextCode` VARCHAR(3) NOT NULL COMMENT "Код подчиненного дополнительного адресообразующего элемента",
  `offName` VARCHAR(120) COMMENT "Официальное наименование",
  `postalCode` VARCHAR(6) COMMENT "Почтовый индекс",
  `ifnsFl` VARCHAR(4) COMMENT "Код ИФНС ФЛ",
  `terrIfnsFl` VARCHAR(4) COMMENT "Код территориального участка ИФНС ФЛ",
  `ifnsUl` VARCHAR(4) COMMENT "Код ИФНС ЮЛ",
  `terrIfnsUl` VARCHAR(4) COMMENT "Код территориального участка ИФНС ЮЛ",
  `okato` VARCHAR(11) COMMENT "ОКАТО",
  `oktmo` VARCHAR(8) COMMENT "ОКТМО",
  `updateDate` DATETIME NOT NULL COMMENT "Дата внесения записи",
  `shortName` VARCHAR(10) COMMENT "Краткое наименование типа объекта",
  `aoLevel` INT(10) NOT NULL COMMENT "Уровень адресного объекта",
  `parentGuid` BINARY(16) COMMENT "Идентификатор объекта родительского объекта",
  `aoId` BINARY(16) NOT NULL COMMENT "Уникальный идентификатор записи. Ключевое поле",
  `prevId` BINARY(16) COMMENT "Идентификатор записи связывания с предыдушей исторической записью",
  `nextId` BINARY(16) COMMENT "Идентификатор записи  связывания с последующей исторической записью",
  `code` VARCHAR(17) COMMENT "Код адресного объекта одной строкой с признаком актуальности из КЛАДР 4.0",
  `plainCode` VARCHAR(15) COMMENT "Код адресного объекта из КЛАДР 4.0 одной строкой без признака актуальности (последних двух цифр)",
  `actStatus` INT(10) NOT NULL COMMENT "Статус актуальности адресного объекта ФИАС",
  `centStatus` INT(10) NOT NULL COMMENT "Статус центра",
  `operStatus` INT(10) NOT NULL COMMENT "Статус действия над записью – причина появления записи",
  `currStatus` INT(10) NOT NULL COMMENT "Статус актуальности КЛАДР 4 (последние две цифры в коде)",
  `startDate` DATETIME NOT NULL COMMENT "Начало действия записи",
  `endDate` DATETIME NOT NULL COMMENT "Окончание действия записи",
  `normDoc` BINARY(16) COMMENT "Внешний ключ на нормативный документ",
  PRIMARY KEY (`aoId`),
  FOREIGN KEY (`aoLevel`, `shortName`) REFERENCES `AddressObjectType` (`level`, `scName`),
  FOREIGN KEY (`parentGuid`) REFERENCES `AddressObjectGuid` (`aoGuid`),
  FOREIGN KEY (`prevId`) REFERENCES `AddressObject` (`aoId`),
  FOREIGN KEY (`nextId`) REFERENCES `AddressObject` (`aoId`),
  FOREIGN KEY (`actStatus`) REFERENCES `ActualStatus` (`actStatId`),
  FOREIGN KEY (`centStatus`) REFERENCES `CenterStatus` (`centerStId`),
  FOREIGN KEY (`operStatus`) REFERENCES `OperationStatus` (`operStatId`),
  FOREIGN KEY (`currStatus`) REFERENCES `CurrentStatus` (`curentStId`),
  FOREIGN KEY (`normDoc`) REFERENCES `NormativeDocument` (`normDoc`)
) ENGINE = InnoDB, COMMENT "Классификатор адресообразующих элементов";

CREATE TABLE `IntervalStatus` (
  `intStatId` INT(10) NOT NULL COMMENT "Идентификатор статуса",
  `name` VARCHAR(60) NOT NULL COMMENT "Наименование",
  PRIMARY KEY (`intStatId`)
) ENGINE = InnoDB, COMMENT "Статус интервалов домов";

CREATE TABLE `HouseInterval` (
  `postalCode` VARCHAR(6) COMMENT "Почтовый индекс",
  `ifnsFl` VARCHAR(4) COMMENT "Код ИФНС ФЛ",
  `terrIfnsFl` VARCHAR(4) COMMENT "Код территориального участка ИФНС ФЛ",
  `ifnsUl` VARCHAR(4) COMMENT "Код ИФНС ЮЛ",
  `terrIfnsUl` VARCHAR(4) COMMENT "Код территориального участка ИФНС ЮЛ",
  `okato` VARCHAR(11) COMMENT "ОКАТО",
  `oktmo` VARCHAR(8) COMMENT "ОКТМО",
  `updateDate` DATETIME NOT NULL COMMENT "Дата внесения записи",
  `intStart` INT(10) NOT NULL COMMENT "Значение начала интервала",
  `intEnd` INT(10) NOT NULL COMMENT "Значение окончания интервала",
  `houseIntId` BINARY(16) NOT NULL COMMENT "Иидентификатор записи интервала домов",
  `intGuid` BINARY(16) NOT NULL COMMENT "Глобальный уникальный идентификатор интервала домов",
  `aoGuid` BINARY(16) NOT NULL COMMENT "Уникальный идентификатор родителшьского объекта (улицы, города, населенного пункта и т.п.)",
  `startDate` DATETIME NOT NULL COMMENT "Начало действия записи",
  `endDate` DATETIME NOT NULL COMMENT "Окончание действия записи",
  `intStatus` INT(10) NOT NULL COMMENT "Статус интервала (обычный, четный, нечетный)",
  `normDoc` BINARY(16) COMMENT "Внешний ключ на нормативный документ",
  PRIMARY KEY (`houseIntId`),
  FOREIGN KEY (`aoGuid`) REFERENCES `AddressObjectGuid` (`aoGuid`),
  FOREIGN KEY (`intStatus`) REFERENCES `IntervalStatus` (`intStatId`),
  FOREIGN KEY (`normDoc`) REFERENCES `NormativeDocument` (`normDoc`)
) ENGINE = InnoDB, COMMENT "Интервал домов";

CREATE TABLE `HouseStateStatus` (
  `houseStId` INT(10) NOT NULL COMMENT "Признак строения",
  `name` VARCHAR(60) NOT NULL COMMENT "Наименование",
  PRIMARY KEY (`houseStId`)
) ENGINE = InnoDB, COMMENT "Статус состояния домов";

CREATE TABLE `EstateStatus` (
  `estStatId` INT(10) NOT NULL COMMENT "Признак строения",
  `name` VARCHAR(20) NOT NULL COMMENT "Наименование",
  `shortName` VARCHAR(20) COMMENT "Краткое наименование",
  PRIMARY KEY (`estStatId`)
) ENGINE = InnoDB, COMMENT "Признак владения";

CREATE TABLE `StructureStatus` (
  `strStatId` INT(10) NOT NULL COMMENT "Признак строения",
  `name` VARCHAR(20) NOT NULL COMMENT "Наименование",
  `shortName` VARCHAR(20) COMMENT "Краткое наименование",
  PRIMARY KEY (`strStatId`)
) ENGINE = InnoDB, COMMENT "Признак строения";

CREATE TABLE `House` (
  `postalCode` VARCHAR(6) COMMENT "Почтовый индекс",
  `ifnsFl` VARCHAR(4) COMMENT "Код ИФНС ФЛ",
  `terrIfnsFl` VARCHAR(4) COMMENT "Код территориального участка ИФНС ФЛ",
  `ifnsUl` VARCHAR(4) COMMENT "Код ИФНС ЮЛ",
  `terrIfnsUl` VARCHAR(4) COMMENT "Код территориального участка ИФНС ЮЛ",
  `okato` VARCHAR(11) COMMENT "ОКАТО",
  `oktmo` VARCHAR(8) COMMENT "ОКТМО",
  `updateDate` DATETIME NOT NULL COMMENT "Дата внесения записи",
  `houseNum` VARCHAR(10) COMMENT "Номер дома",
  `estStatus` INT(10) NOT NULL COMMENT "Признак владения",
  `buildNum` VARCHAR(10) COMMENT "Номер корпуса",
  `structNum` VARCHAR(10) COMMENT "Номер строения",
  `strStatus` INT(10) COMMENT "Признак строения",
  `houseId` BINARY(16) NOT NULL COMMENT "Уникальный идентификатор записи дома",
  `houseGuid` BINARY(16) NOT NULL COMMENT "Глобальный уникальный идентификатор дома",
  `aoGuid` BINARY(16) NOT NULL COMMENT "Уникальный идентификатор родителшьского объекта (улицы, города, населенного пункта и т.п.)",
  `startDate` DATETIME NOT NULL COMMENT "Начало действия записи",
  `endDate` DATETIME NOT NULL COMMENT "Окончание действия записи",
  `statStatus` INT(10) NOT NULL COMMENT "Состояние дома",
  `normDoc` BINARY(16) COMMENT "Внешний ключ на нормативный документ",
  `counter` INT(10) NOT NULL COMMENT "Счётчик записей домов для КЛАДР 4",
  PRIMARY KEY (`houseId`),
  FOREIGN KEY (`estStatus`) REFERENCES `EstateStatus` (`estStatId`),
  FOREIGN KEY (`strStatus`) REFERENCES `StructureStatus` (`strStatId`),
  FOREIGN KEY (`aoGuid`) REFERENCES `AddressObjectGuid` (`aoGuid`),
  FOREIGN KEY (`statStatus`) REFERENCES `HouseStateStatus` (`houseStId`),
  FOREIGN KEY (`normDoc`) REFERENCES `NormativeDocument` (`normDoc`)
) ENGINE = InnoDB, COMMENT "Сведения по номерам домов улиц городов и населенных пунктов, номера земельных участков и т.п.";

-- Обновление схемы

ALTER TABLE `AddressObject`
  MODIFY `updateDate` DATE NOT NULL,
  MODIFY `startDate` DATE NOT NULL,
  MODIFY `endDate` DATE NOT NULL,
  ADD `liveStatus` TINYINT(1) NOT NULL COMMENT "Признак действующего адресного объекта";

ALTER TABLE `House`
  MODIFY `updateDate` DATE NOT NULL,
  MODIFY `houseNum` VARCHAR(20),
  MODIFY `startDate` DATE NOT NULL,
  MODIFY `endDate` DATE NOT NULL;

ALTER TABLE `HouseInterval`
  MODIFY `updateDate` DATE NOT NULL,
  MODIFY `startDate` DATE NOT NULL,
  MODIFY `endDate` DATE NOT NULL;

ALTER TABLE `IntervalStatus`
  CHANGE `intStatId` `intvStatId` INT(10) NOT NULL;

ALTER TABLE `Landmark`
  MODIFY `updateDate` DATE NOT NULL,
  MODIFY `startDate` DATE NOT NULL,
  MODIFY `endDate` DATE NOT NULL;

ALTER TABLE `NormativeDocument`
  MODIFY `docDate` DATE NOT NULL;

ALTER TABLE `AddressObjectType`
  MODIFY `socrName` VARCHAR(50) NOT NULL;


