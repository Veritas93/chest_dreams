# Подключаем парсер и библиотеку для работы с датами
require 'rexml/document'
require 'date'

# Наш сундук будет по адресу data/chest.xml
file_path = File.dirname(__FILE__) + '/data/chest.xml'

# Если сундук не существует, то создаем его
unless File.exist?(file_path)
  # Тут мы воспользуемся еще одним интерфейсом класса File - методом
  # Open, которому можно передать блок с инструкциями для работы с объектом
  # класса File. Тогда нам не придется закрывать файл в ручную, т.к. сразу после 
  # выполнения действий в блоке файл будет закрыт.
  File.open(file_path, 'w:UTF-8') do |file|
    # Добавим в документ служебную строку с версией и кодировкой и пустой тег
    file.puts "<?xml version='1.0' encoding='UTF-8'?>"
    file.puts '<wishes></wishes>'
  end
end

# Теперь мы можем быть уверены, что файл на диске внужном месте точно есть. Если
# он был - хорошо, если нет - мы его создали, без данных, но с нужной нам структурой
# В любом случае считываем из него сождержимое и строим из него 
# структуру XML с помощью нашего любимого парсера REXML.
xml_file = File.read(file_path, encoding: 'UTF-8')
doc = REXML::Document.new(xml_file)

# Спросим у пользователя желание и запишем его в переменную wist_text
puts 'В этом сундуке хранятся ваши желания.'
puts 
puts 'Чего бы вы хотели?'
wish_text = STDIN.gets.chomp

# Спросим у пользователя дату, до которой он хочет, чтобы его желание сбылось
# запишем в переменную wish_date, предварительно сделав из строки с вводом 
# пользователя объект класса Date
puts
puts 'До какого числа вы хотите осуществить это желание?'
puts 'Укажите дату в формате ДД.ММ.ГГГГ'
wish_date_input = STDIN.gets.chomp
wish_date = Date.parse(wish_date_input)

# Добавим к корневому элементу нашей XML-структуры еще один тег wish и добавим 
# к нему аттрибут date со строкой даты в нужном формате
wish = doc.root.add_element('wish', {'date' => wish_date.strftime('%d.%m.%Y')})

# Добавим текст желания к тексту элемента с пом. метода add_text
wish.add_text(wish_text)

# Снова откроем файл, но уже на запись и запишем туда все данные в нужном формате
File.open(file_path, 'w:UTF-8') do |file|
  doc.write(file, 2)
end

# Прощание с пользователем
puts
puts 'Ваше желание в сундуке'
