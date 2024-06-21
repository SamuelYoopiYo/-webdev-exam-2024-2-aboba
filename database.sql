PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE role (
	id INTEGER NOT NULL, 
	name VARCHAR(255) NOT NULL, 
	description TEXT NOT NULL, 
	PRIMARY KEY (id)
);
INSERT INTO role VALUES(1,'Пользователь','Обычный пользователь с ограниченными правами');
INSERT INTO role VALUES(2,'Модератор','Управление контентом и пользователями');
INSERT INTO role VALUES(3,'Администратор','Полные права на управление системой');
CREATE TABLE genre (
	id INTEGER NOT NULL, 
	name VARCHAR(255) NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (name)
);
INSERT INTO genre VALUES(1,'Фантастика');
INSERT INTO genre VALUES(2,'Роман');
INSERT INTO genre VALUES(3,'Детектив');
INSERT INTO genre VALUES(4,'Приключения');
INSERT INTO genre VALUES(5,'Ужасы');
INSERT INTO genre VALUES(6,'Фэнтези');
INSERT INTO genre VALUES(7,'Драма');
INSERT INTO genre VALUES(8,'Научно-популярное');
INSERT INTO genre VALUES(9,'Биография');
INSERT INTO genre VALUES(10,'Историческая проза');
CREATE TABLE cover (
	id INTEGER NOT NULL, 
	filename VARCHAR(255) NOT NULL, 
	mime_type VARCHAR(255) NOT NULL, 
	md5_hash VARCHAR(255) NOT NULL, 
	PRIMARY KEY (id)
);
INSERT INTO cover VALUES(1,'cover1.jpg','image/jpeg','1a79a4d60de6718e8e5b326e338ae533');
INSERT INTO cover VALUES(2,'cover2.jpg','image/jpeg','6f8db599de986fab7a21625b7916589c');
INSERT INTO cover VALUES(3,'cover3.jpg','image/jpeg','6364d3f0f495b6ab9dcf8d3b5c6e0b01');
INSERT INTO cover VALUES(4,'cover4.jpg','image/jpeg','c4ca4238a0b923820dcc509a6f75849b');
INSERT INTO cover VALUES(5,'cover5.jpg','image/jpeg','c81e728d9d4c2f636f067f89cc14862c');
INSERT INTO cover VALUES(6,'cover6.jpg','image/jpeg','eccbc87e4b5ce2fe28308fd9f2a7baf3');
INSERT INTO cover VALUES(7,'cover7.jpg','image/jpeg','a87ff679a2f3e71d9181a67b7542122c');
INSERT INTO cover VALUES(8,'cover8.jpg','image/jpeg','e4da3b7fbbce2345d7772b0674a318d5');
INSERT INTO cover VALUES(9,'cover9.jpg','image/jpeg','1679091c5a880faf6fb5e6087eb1b2dc');
INSERT INTO cover VALUES(10,'cover10.jpg','image/jpeg','8f14e45fceea167a5a36dedd4bea2543');
INSERT INTO cover VALUES(11,'cover1.jpg','image/jpeg','1a79a4d60de6718e8e5b326e338ae533');
INSERT INTO cover VALUES(12,'cover2.jpg','image/jpeg','6f8db599de986fab7a21625b7916589c');
INSERT INTO cover VALUES(13,'cover3.jpg','image/jpeg','6364d3f0f495b6ab9dcf8d3b5c6e0b01');
INSERT INTO cover VALUES(14,'cover4.jpg','image/jpeg','c4ca4238a0b923820dcc509a6f75849b');
INSERT INTO cover VALUES(15,'cover5.jpg','image/jpeg','c81e728d9d4c2f636f067f89cc14862c');
INSERT INTO cover VALUES(16,'cover6.jpg','image/jpeg','eccbc87e4b5ce2fe28308fd9f2a7baf3');
INSERT INTO cover VALUES(17,'cover7.jpg','image/jpeg','a87ff679a2f3e71d9181a67b7542122c');
INSERT INTO cover VALUES(18,'cover8.jpg','image/jpeg','e4da3b7fbbce2345d7772b0674a318d5');
INSERT INTO cover VALUES(19,'cover9.jpg','image/jpeg','1679091c5a880faf6fb5e6087eb1b2dc');
INSERT INTO cover VALUES(20,'cover10.jpg','image/jpeg','8f14e45fceea167a5a36dedd4bea2543');
INSERT INTO cover VALUES(21,'cover1.jpg','image/jpeg','1a79a4d60de6718e8e5b326e338ae533');
INSERT INTO cover VALUES(22,'cover2.jpg','image/jpeg','6f8db599de986fab7a21625b7916589c');
INSERT INTO cover VALUES(23,'cover3.jpg','image/jpeg','6364d3f0f495b6ab9dcf8d3b5c6e0b01');
INSERT INTO cover VALUES(24,'cover4.jpg','image/jpeg','c4ca4238a0b923820dcc509a6f75849b');
INSERT INTO cover VALUES(25,'cover5.jpg','image/jpeg','c81e728d9d4c2f636f067f89cc14862c');
INSERT INTO cover VALUES(26,'cover6.jpg','image/jpeg','eccbc87e4b5ce2fe28308fd9f2a7baf3');
INSERT INTO cover VALUES(27,'cover7.jpg','image/jpeg','a87ff679a2f3e71d9181a67b7542122c');
INSERT INTO cover VALUES(28,'cover8.jpg','image/jpeg','e4da3b7fbbce2345d7772b0674a318d5');
INSERT INTO cover VALUES(29,'cover9.jpg','image/jpeg','1679091c5a880faf6fb5e6087eb1b2dc');
INSERT INTO cover VALUES(30,'cover10.jpg','image/jpeg','8f14e45fceea167a5a36dedd4bea2543');
INSERT INTO cover VALUES(31,'cover1.jpg','image/jpeg','1a79a4d60de6718e8e5b326e338ae533');
INSERT INTO cover VALUES(32,'cover2.jpg','image/jpeg','6f8db599de986fab7a21625b7916589c');
INSERT INTO cover VALUES(33,'cover3.jpg','image/jpeg','6364d3f0f495b6ab9dcf8d3b5c6e0b01');
INSERT INTO cover VALUES(34,'cover4.jpg','image/jpeg','c4ca4238a0b923820dcc509a6f75849b');
INSERT INTO cover VALUES(35,'cover5.jpg','image/jpeg','c81e728d9d4c2f636f067f89cc14862c');
INSERT INTO cover VALUES(36,'cover6.jpg','image/jpeg','eccbc87e4b5ce2fe28308fd9f2a7baf3');
INSERT INTO cover VALUES(37,'cover7.jpg','image/jpeg','a87ff679a2f3e71d9181a67b7542122c');
INSERT INTO cover VALUES(38,'cover8.jpg','image/jpeg','e4da3b7fbbce2345d7772b0674a318d5');
INSERT INTO cover VALUES(39,'cover9.jpg','image/jpeg','1679091c5a880faf6fb5e6087eb1b2dc');
INSERT INTO cover VALUES(40,'cover10.jpg','image/jpeg','8f14e45fceea167a5a36dedd4bea2543');
INSERT INTO cover VALUES(41,'cover1.jpg','image/jpeg','1a79a4d60de6718e8e5b326e338ae533');
INSERT INTO cover VALUES(42,'cover2.jpg','image/jpeg','6f8db599de986fab7a21625b7916589c');
INSERT INTO cover VALUES(43,'cover3.jpg','image/jpeg','6364d3f0f495b6ab9dcf8d3b5c6e0b01');
INSERT INTO cover VALUES(44,'cover4.jpg','image/jpeg','c4ca4238a0b923820dcc509a6f75849b');
INSERT INTO cover VALUES(45,'cover5.jpg','image/jpeg','c81e728d9d4c2f636f067f89cc14862c');
INSERT INTO cover VALUES(46,'cover6.jpg','image/jpeg','eccbc87e4b5ce2fe28308fd9f2a7baf3');
INSERT INTO cover VALUES(47,'cover7.jpg','image/jpeg','a87ff679a2f3e71d9181a67b7542122c');
INSERT INTO cover VALUES(48,'cover8.jpg','image/jpeg','e4da3b7fbbce2345d7772b0674a318d5');
INSERT INTO cover VALUES(49,'cover9.jpg','image/jpeg','1679091c5a880faf6fb5e6087eb1b2dc');
INSERT INTO cover VALUES(50,'cover10.jpg','image/jpeg','8f14e45fceea167a5a36dedd4bea2543');
INSERT INTO cover VALUES(51,'download.jpg','image/jpeg','d41d8cd98f00b204e9800998ecf8427e');
INSERT INTO cover VALUES(52,'noise.jpg','image/jpeg','a19328c4359b7a3e52ea7b5c3e3bce4d');
INSERT INTO cover VALUES(53,'london.jpg','image/jpeg','4bd609fef5c33e83248172701cfb5284');
INSERT INTO cover VALUES(54,'forest.jpg','image/jpeg','3ac07d1edc904974e71a5c666626bb85');
INSERT INTO cover VALUES(55,'space.jpg','image/jpeg','a680e7bd256f988fd5b7be30a96b8b3a');
INSERT INTO cover VALUES(56,'muhi.jpg','image/jpeg','50d131acc7c79e743ab29d27ba099110');
INSERT INTO cover VALUES(57,'gold.jpg','image/jpeg','65042cffd0d307ff782459eb322486df');
INSERT INTO cover VALUES(58,'jpg','image/jpeg','a7a8af628983deafb654810f18200e2a');
INSERT INTO cover VALUES(59,'master.jpg','image/jpeg','555e43b1cbf085b90b6a02f817edc919');
INSERT INTO cover VALUES(60,'skot.jpg','image/jpeg','2f6e7cd5633d387d6b37a7528825755a');
INSERT INTO cover VALUES(61,'451.jpg','image/jpeg','04cf504df899182a9e0a090190238293');
INSERT INTO cover VALUES(62,'anna.jpg','image/jpeg','4d57747be23ec1f9297366678804995e');
INSERT INTO cover VALUES(63,'palata.jpg','image/jpeg','c2684fd1ac4a5e311e998156145bfe73');
INSERT INTO cover VALUES(64,'j.jpg','image/jpeg','4dae18ddb30c88c9f084b495b68e1017');
INSERT INTO cover VALUES(65,'jpg','image/jpeg','314e3251e273c2303add843f7a0d6583');
INSERT INTO cover VALUES(66,'jpg','image/jpeg','978548820996d01d00820ebce1e8f691');
INSERT INTO cover VALUES(67,'1984.jpg','image/jpeg','ed1a788f54a00d81f0e59e2c832f2bbf');
INSERT INTO cover VALUES(68,'1984.jpg','image/jpeg','ed1a788f54a00d81f0e59e2c832f2bbf');
INSERT INTO cover VALUES(69,'jpg','image/jpeg','e089c919db81df6ded2acad80437ab22');
INSERT INTO cover VALUES(70,'3.jpg','image/jpeg','4a95118c4572d42052f9ecf97ad513c9');
INSERT INTO cover VALUES(71,'jpg','image/jpeg','acde3c64a550ab0ee0c4541ee3e4d3bc');
INSERT INTO cover VALUES(72,'jpg','image/jpeg','a7a8af628983deafb654810f18200e2a');
INSERT INTO cover VALUES(73,'DSCF7706.JPG','image/jpeg','7f1f94213d461e3e90dd02a87649b0a5');
CREATE TABLE user (
	id INTEGER NOT NULL, 
	username VARCHAR(255) NOT NULL, 
	password_hash VARCHAR(255) NOT NULL, 
	last_name VARCHAR(255) NOT NULL, 
	first_name VARCHAR(255) NOT NULL, 
	middle_name VARCHAR(255), 
	role_id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (username), 
	FOREIGN KEY(role_id) REFERENCES role (id)
);
INSERT INTO user VALUES(1,'admin','$2b$12$42wBtYLA7.x/qDrGQlOgu.YGzujWhYNpZih2XetkxtanuZUxWyX2y','Admin','Admin',NULL,3);
INSERT INTO user VALUES(2,'nekto','$2b$12$MixLMwHodiISvmqENYd1jeqpXHhBt9JNMiSwtBNzwrzXbEOO7uJwO','Pupkin','Fedot',NULL,1);
INSERT INTO user VALUES(3,'moderator1','hashed_password2','Смирнов','Сергей','Александрович',2);
CREATE TABLE book (
	id INTEGER NOT NULL, 
	title VARCHAR(255) NOT NULL, 
	description TEXT NOT NULL, 
	year INTEGER NOT NULL, 
	publisher VARCHAR(255) NOT NULL, 
	author VARCHAR(255) NOT NULL, 
	pages INTEGER NOT NULL, 
	cover_id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(cover_id) REFERENCES cover (id)
);
INSERT INTO book VALUES(2,'Подземелья Лондона','Внезапное обрушение набережной Темзы открывает проход в таинственный подземный мир Лондона. Аристократ-изобретатель Лэнгдон Сент-Ив и его друзья решают исследовать неизвестные просторы, не зная, что им противостоит хладнокровный гений зла, перед которым демонический доктор Нарбондо покажется сущим ребенком! На стороне психопата-душегуба весь преступный мир британской столицы, смертоносные изобретения вивисектора Пиви и даже грибы-вампиры. Убийства и похищения ни в чем не повинных людей следуют одно за другим... Сумеет ли Сент-Ив избежать уготованной ему печальной участи и восстановить мир и покой на улицах Лондона?..',2019,'Аркадия','Джеймс Блэйлок',250,53);
INSERT INTO book VALUES(3,'Темный лес',replace(replace('Продолжение феноменальной «Задачи трех тел», романа великого китайского фантаста Лю Цысиня.\r\n\r\nТрисолярианский кризис продолжается. У землян есть 400 лет, чтобы предотвратить инопланетное вторжение. Но угроза полного уничтожения, вопреки ожиданиям, не объединяет человечество. Сверхдержавы отстаивают свои интересы, космические флоты, становясь независимой политической силой, вовсе теряют связь с Землей. Тотальный контроль над научно-техническими разработками со стороны чужой цивилизации, во много раз превосходящей нашу в развитии, не оставляет людям шанса на победу. Исход войны решат проекты «Отвернувшихся» – лучших мыслителей планеты.\r\n\r\nПродолжение трилогии «В память о прошлом Земли» самого популярного китайского писателя Лю Цысиня удостоилось положительных отзывов критиков и вошло в рейтинги лучших НФ-романов последних лет.','\r',char(13)),'\n',char(10)),2018,'fanzon','Лю Цысинь',400,54);
INSERT INTO book VALUES(4,'Космическая одиссея',replace(replace('Три витка на спирали развития человечества: питекантроп осваивает орудия труда, покоривший притяжение родной планеты человек осваивает Солнечную систему, человек будущего выходит за пределы бесконечности.\r\n\r\nТоржество разума, триумф человека... И таинственные монолиты...','\r',char(13)),'\n',char(10)),1968,'ИздательствоX','Артур Кларк',350,55);
INSERT INTO book VALUES(5,'Повелитель мух','Странная, страшная и бесконечно притягательная книга.История благовоспитанных мальчиков, внезапно оказавшихся на необитаемом острове.Философская притча о том, что может произойти с людьми, забывшими о любви и милосердии.Гротескная антиутопия, роман-предупреждение и, конечно, напоминание о хрупкости мира, в котором живем мы все.',2014,'Издатель',' Уильям Голдинг',280,56);
INSERT INTO book VALUES(6,'Золотой теленок','Главный герой «12 стульев» гениальный авантюрист Остап Бендер воскресает, чтобы вновь попытать счастья: на этот раз его цель — миллион рублей, который поможет ему переселиться из постылого Советского Союза в Рио-де-Жанейро. Бендер с компанией подельников отправляется в город Черноморск, чтобы экспроприировать деньги у подпольного миллионера Александра Корейко. Как и «12 стульев», «Золотой телёнок» — захватывающий плутовской роман и превосходная сатира на советскую действительность, но в то же время он глубже и грустнее первой части приключений Бендера: в финале и читателю, и самому герою приходится сделать вывод о несовместимости благородного жулика с новой реальностью.',1931,'Полка','ЕВГЕНИЙ ПЕТРОВ, ИЛЬЯ ИЛЬФ',320,57);
INSERT INTO book VALUES(7,'Остров сокровищ',replace(replace('Знаменитый роман Роберта Льюиса Стивенсона в сопровождении подробного историко-бытового комментария, посвященного морскому делу в Англии XVIII века и «золотому веку» пиратства. Рисунки, гравюры, карты, страницы из книг того времени, интерактивные элементы помогают воссоздать живую атмосферу эпохи.\r\nВ Англии, близ Бристоля, в таверне «Адмирал Бенбоу», в комнате старого капитана, в матросском сундуке, в пакете из клеенки надежно спрятано то, с чего начинаются приключения, известные каждому мальчишке. В Англию XVIII века мы отправимся с этой книгой, чтобы тут же выйти в море и в долгом плавании к острову Сокровищ постичь все морские премудрости.','\r',char(13)),'\n',char(10)),1883,'ИздательствоН','Роберт Стивенсон',290,72);
INSERT INTO book VALUES(8,'Мастер и Маргарита','В Москву конца 1920-х, всё такую же разгульную и мещанскую, но уже советскую, прибывает таинственный иностранец, окружённый опереточной свитой. Он вовлекает оказавшихся на его пути москвичей в серию невообразимых происшествий, но его истинная миссия — найти опального автора романа о евангельской истории и влюблённую в него женщину. Булгаков начинает с традиционного для своего времени, почти фельетонного сюжета — о том, как застоявшийся советский быт взрывается вторжением чужака, вплетает в него историю последних дней Иисуса и приходит к очень личному трагическому повествованию о силе творчества, свойствах любви и переплетении добра и зла.',2013,'ИздательствоЧД','МИХАИЛ БУЛГАКОВ',330,59);
INSERT INTO book VALUES(9,'Скотный двор','«Ско́тный двор» — изданная в 1945 году сатирическая повесть-притча Джорджа Оруэлла. В повести изображена эволюция общества животных, изгнавших со скотного двора его предыдущего владельца, жестокого мистера Джонса, от безграничной свободы к диктатуре свиньи по кличке Наполеон.',1945,'Издательствоefef','Джордж Оруэлл',310,60);
INSERT INTO book VALUES(10,'451 градус по Фаренгейту','«451 градус по Фаренгейту» — научно-фантастический роман-антиутопия Рэя Брэдбери, изданный в 1953 году. Роман описывает американское общество близкого будущего, в котором книги находятся под запретом; «пожарные», к числу которых принадлежит и главный герой Гай Монтэг, сжигают любые найденные книги.',2011,'Изд','Рэй Брэдбери',270,61);
INSERT INTO book VALUES(11,'Анна Каренина','А́нна Аркáдьевна Каре́нина — одна из центральных героинь романа Льва Толстого «Анна Каренина». Каренина — знатная петербургская дама, сестра Стивы Облонского, жена Алексея Каренина',2010,'i','Лев Толстой',340,62);
INSERT INTO book VALUES(12,'Палата № 6','«Пала́та № 6» — повесть Антона Павловича Чехова. Впервые она была опубликована в 1892 году в журнале «Русская мысль».',1892,'Издательство 12','Антон Чехов',300,63);
INSERT INTO book VALUES(13,'Джейн Эйр','«Джейн Эйр» (англ. Jane Eyre [ˌdʒeɪn ˈɛər]), в самой первой публикации был выпущен под названием «Джейн Эйр: Автобиография» (англ. Jane Eyre: An Autobiography) — роман английской писательницы Шарлотты Бронте, выпущенный под псевдонимом «Каррер Белл». Второе переиздание романа Бронте посвятила писателю Уильяму Теккерею.',2008,'Издательство 13','Автор',320,64);
INSERT INTO book VALUES(14,'Гарри Поттер и Кубок Огня','Га́рри По́ттер и Ку́бок огня́ (англ. Harry Potter and the Goblet of Fire) — четвёртая книга о приключениях Гарри Поттера, написанная английской писательницей Джоан Роулинг. В Англии опубликована в 2000 году. По сюжету Гарри Поттер против своей воли вовлекается в участие в Турнире Трёх Волшебников, и ему предстоит не только сразиться с более опытными участниками, но и разгадать загадку того, как он вообще попал на турнир вопреки правилам.',2007,'гарепотар',' Джоан Роулинг',290,65);
INSERT INTO book VALUES(15,'Герой нашего времени','«Геро́й на́шего вре́мени» — первый в русской прозе социально-психологический роман, написанный Михаилом Лермонтовым в 1837—1839 годах. Классика русской литературы',1840,'Издательство 15','Михаил Лермонтов',310,66);
INSERT INTO book VALUES(16,'1984','«1984» — роман-антиутопия Джорджа Оруэлла, изданный в 1949 году. Как отмечает членкор РАН М. Ф. Черныш, это самое главное и последнее произведение писателя. ',1949,'Издательство 16','Джордж Оруэлл',280,68);
INSERT INTO book VALUES(17,'Три товарища','«Три товарища» — роман Эриха Марии Ремарка, работу над которым он начал в 1932 году. Роман был закончен и опубликован в датском издательстве Gyldendal под названием «Kammerater» в 1936 году. В 1958 году был переведён на русский язык.',1936,'Издательство 17','Эрих Мария Ремарк',330,70);
INSERT INTO book VALUES(18,'Цветы для Элджернона','«Цветы для Э́лджернона» — научно-фантастический рассказ Дэниела Киза. Первоначально издан в апрельском номере «Журнала фэнтези и научной фантастики» за 1959 год. Премия «Хьюго» за лучший короткий научно-фантастический рассказ.',1959,'Издательство 18','Дэниел Киз',290,69);
INSERT INTO book VALUES(19,'Приключения Шерлока Холмса','«Приключе́ния Ше́рлока Хо́лмса» — сборник из 12 детективных рассказов, созданных Артуром Конаном Дойлом.',1892,'Издательство 19','Артур Конан Дойл',320,71);
INSERT INTO book VALUES(20,'Шум времени','Впервые на русском — новейшее сочинение лауреата Букеровской премии Джулиана Барнса, автора таких международных бестселлеров, как «Англия, Англия», «Попугай Флобера», «Любовь и так далее», «Предчувствие конца» и многих других. На этот раз «однозначно самый изящный стилист и самый непредсказуемый мастер всех мыслимых литературных форм» обращается к жизни Дмитрия Шостаковича, причем в юбилейный год: в сентябре 2016-го весь мир будет отмечать 110 лет со дня рождения великого русского композитора.',2001,'Азбука-Аттикус','Джулиан Барнс',300,52);
INSERT INTO book VALUES(21,'nu kot','qwr',1,'qwr','qwr',1,51);
INSERT INTO book VALUES(22,'abobaaaaa','adf',33,'hehe','bob',33,73);
CREATE TABLE book_genre (
	book_id INTEGER NOT NULL, 
	genre_id INTEGER NOT NULL, 
	PRIMARY KEY (book_id, genre_id), 
	FOREIGN KEY(book_id) REFERENCES book (id), 
	FOREIGN KEY(genre_id) REFERENCES genre (id)
);
INSERT INTO book_genre VALUES(21,2);
INSERT INTO book_genre VALUES(20,7);
INSERT INTO book_genre VALUES(2,3);
INSERT INTO book_genre VALUES(3,4);
INSERT INTO book_genre VALUES(4,1);
INSERT INTO book_genre VALUES(5,2);
INSERT INTO book_genre VALUES(6,6);
INSERT INTO book_genre VALUES(8,7);
INSERT INTO book_genre VALUES(9,8);
INSERT INTO book_genre VALUES(10,1);
INSERT INTO book_genre VALUES(11,2);
INSERT INTO book_genre VALUES(12,7);
INSERT INTO book_genre VALUES(13,9);
INSERT INTO book_genre VALUES(14,6);
INSERT INTO book_genre VALUES(15,10);
INSERT INTO book_genre VALUES(16,1);
INSERT INTO book_genre VALUES(18,8);
INSERT INTO book_genre VALUES(17,2);
INSERT INTO book_genre VALUES(19,4);
INSERT INTO book_genre VALUES(7,4);
INSERT INTO book_genre VALUES(22,4);
CREATE TABLE review (
	id INTEGER NOT NULL, 
	book_id INTEGER NOT NULL, 
	user_id INTEGER NOT NULL, 
	rating INTEGER NOT NULL, 
	text TEXT NOT NULL, 
	created_at DATETIME DEFAULT (CURRENT_TIMESTAMP) NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(book_id) REFERENCES book (id), 
	FOREIGN KEY(user_id) REFERENCES user (id)
);
COMMIT;
