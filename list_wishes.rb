require 'date'
require 'rexml/document'
require_relative 'lib/wish'

file_path = File.dirname(__FILE__) + '/data/chest.xml'

# Проверяем наличие сундука. если его нет выходим
abort "Файл #{file_path} не найден" unless File.exist?(file_path)

# Считываем данные и строим на их основе структуру XML с помощью
# гема REXML. Воспользуемся тем что open возвращает значение, которое будет вычислено
# в блоке и присвоим переменной doc, то что вернет этот метод
doc = File.open(file_path, 'r:UTF-8') do |file|
  REXML::Document.new(file)
end

# Считываем все желания в массив. Каждый элемент объект класса Wish
# воспользуемся методом map, который собирает массив из того, что вернет
# уму блок для каждого элемента исходного массива.
wishes = []
doc.elements.each('wishes/wish') do |wish_node|
  wishes << Wish.new(wish_node)
end

# Выводим сперва те желания, которые должны были сбыться, а потом остальные
puts 
puts 'Эти желания должны были сбыться к сегодняшнему дню'
wishes.each {|wish| puts wish if wish.overdue?}

puts
puts 'А этим желаниям еще предстоит сбыться'
wishes.each {|wish| puts wish unless wish.overdue?}
