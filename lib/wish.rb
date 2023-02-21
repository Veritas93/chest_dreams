# Класс желание
class Wish
  # Конструктор класса принимает на вход XML - ноду вида
  #
  # <wish date='08.03.2018'>
  #   Сделать курс по Node.JS
  # </wish>
  #
  # И достает из нее текст и дату в нужной форме.
  def initialize(node)
    @text = node.text.strip
    @date = Date.parse(node.attributes['date'])
  end

  # Этот метод возвращает true, если желание уже должно было сбыться
  def overdue?
    @date < Date.today
  end

  # Этот метод мы будем использовать для вывода желаний
  def to_s
    "#{@date.strftime('%d.%m.%Y')}: #{@text}"
  end
end