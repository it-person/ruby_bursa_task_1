class LibraryManager
 require 'active_support/all' 
  # 1. Бибилиотека в один момент решила ввести жесткую систему штрафов (прямо как на rubybursa :D).
  # За каждый час опоздания со здачей книги читатель вынужден заплатить пеню 0,1% от стоимости.  
  # Необходимо реализовать метод, который будет считать эту сумму в зависимости от даты выдачи и 
  # текущего времени. По работе с датой-временем информацию можно посмотреть 
  # тут http://ruby-doc.org/stdlib-2.2.2/libdoc/date/rdoc/DateTime.html
  # 
  # Входящие параметры метода 
  # - стоимость книги в центах, 
  # - дата и время возврата (момент, когда книга должна была быть сдана, в формате DateTime)
  # Возвращаемое значение 
  # - пеня в центах
  def penalty(price, issue_datetime)
    # решение пишем тут
    (((Time.now - issue_datetime) / 1.hours)  * (price / 1000.0)).round 
  end

  # 2. Известны годы жизни двух писателей. Год рождения, год смерти. Посчитать, могли ли они чисто 
  # теоретически встретиться. Даже если один из писателей был в роддоме - это все равно считается встречей. 
  # Помните, что некоторые писатели родились и умерли до нашей эры - в таком случае годы жизни будут просто 
  # приходить со знаком минус.
  # 
  # Входящие параметры метода 
  # - год рождения первого писателя, 
  # - год смерти первого писателя, 
  # - год рождения второго писателя, 
  # - год смерти второго писателя.
  # Возвращаемое значение 
  # - true или false
  def could_meet_each_other? year_of_birth_first, year_of_death_first, year_of_birth_second, year_of_death_second
    # решение пишем тут
    # буду использовать массивы
    # вычислю продолжительность жизни авторов
    
    life_first = year_of_death_first - year_of_birth_first
    life_second = year_of_death_second - year_of_birth_second
    
    # формирую массывы жизни для каждого из автров
    time_first = Array.new(life_first){ |index| year_of_birth_first + index + 1 }
    time_secon = Array.new(life_second){ |index| year_of_birth_second + index + 1 }

      if (time_first & time_secon).size > 0
       return true
      else
       return false
      end 
    
  end

  # 3. Исходя из жесткой системы штрафов за опоздания со cдачей книг, читатели начали задумываться - а 
  # не дешевле ли будет просто купить такую же книгу...  Необходимо помочь читателям это выяснить. За каждый 
  # час опоздания со здачей книги читатель вынужден заплатить пеню 0,1% от стоимости.
  # 
  # Входящий параметр метода 
  # - стоимость книги в центах 
  # Возвращаемое значение 
  # - число полных дней, нак которые необходимо опоздать со здачей, чтобы пеня была равна стоимости книги.
  def days_to_buy price
    # решение пишем тут
    # вычисляем пеню книги за 1 день
    penalty_day = 24 * (price / 1000.0)

    i = 0
    current_day = 0
    while current_day < price

      i += 1
      current_day = penalty_day * i
     
    end
  
    return i 
  end


  # 4. Для удобства иностранных пользователей, имена авторов книг на украинском языке нужно переводить в 
  # транслит. Транслитерацию должна выполняться согласно официальным 
  # правилам http://kyivpassport.com/transliteratio/
  
  # Входящий параметр метода 
  # - имя и фамилия автора на украинском. ("Іван Франко") 
  # Возвращаемое значение 
  # - имя и фамилия автора транслитом. ("Ivan Franko")
  def author_translit ukr_name
    # решение пишем тут
replace = {

        'а' => 'a',   'б' => 'b',   'в' => 'v',
        'г' => 'h',   'д' => 'd',   'е' => 'e',   'є' => 'ie',
        'ж' => 'zh',  'з' => 'z',   'і' => 'i',
        'и' => 'y',   'й' => 'i',   'к' => 'k',   'ї' => 'i',
        'л' => 'l',   'м' => 'm',   'н' => 'n',   'ґ' => 'g',
        'о' => 'o',   'п' => 'p',   'р' => 'r',
        'с' => 's',   'т' => 't',   'у' => 'u',
        'ф' => 'f',   'х' => 'kh',  'ц' => 'ts',
        'ч' => 'ch',  'ш' => 'sh',  'щ' => 'shch',
        'ю' => 'iu',  'я' => 'ia',

        'А' => 'A',   'Б' => 'B',   'В' => 'V',
        'Г' => 'H',   'Д' => 'D',   'Е' => 'E',   'Є' => 'Ye',
        'Ж' => 'Zh',  'З' => 'Z',   'І' => 'I',
        'И' => 'Y',   'Й' => 'Y',   'К' => 'K',   'Ї' => 'Yi',
        'Л' => 'L',   'М' => 'M',   'Н' => 'N',   'Ґ' => 'G',
        'О' => 'O',   'П' => 'P',   'Р' => 'R',
        'С' => 'S',   'Т' => 'T',   'У' => 'U',
        'Ф' => 'F',   'Х' => 'Kh',  'Ц' => 'Ts',
        'Ч' => 'Ch',  'Ш' => 'Sh',  'Щ' => 'Shch',
        'Ю' => 'Yu',  'Я' => 'Ya', ' ' => ' '
    }

   ukr_name.gsub(/#{replace.keys}/, replace)


  end

  #5. Читатели любят дочитывать книги во что-бы то ни стало. Необходимо помочь им просчитать сумму штрафа, 
  # который придеться заплатить чтобы дочитать книгу, исходя из количества страниц, текущей страницы и 
  # скорости чтения за час.
  # 
  # Входящий параметр метода 
  # - Стоимость книги в центах
  # - DateTime сдачи книги (может быть как в прошлом, так и в будущем)
  # - Количество страниц в книге
  # - Текущая страница
  # - Скорость чтения - целое количество страниц в час.
  # Возвращаемое значение 
  # - Пеня в центах или 0 при условии что читатель укладывается в срок здачи.
  def penalty_to_finish price, issue_datetime, pages_quantity, current_page, reading_speed
    # решение пишем тут


  end

end
