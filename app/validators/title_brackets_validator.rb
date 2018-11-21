class TitleBracketsValidator < ActiveModel::Validator

  def validate(record)
    unless record.title.count('(') == record.title.count(')')
      record.errors[:title] << 'has invalid number of parantheses'
    end

    unless record.title.count('{') == record.title.count('}')
      record.errors[:title] << 'has invalid number of braces'
    end

    unless record.title.count('[') == record.title.count(']')
      record.errors[:title] << 'has invalid number of square brackets'
    end

    unless check_order(record.title, '(', ')')
      record.errors[:title] << 'has invalid parantheses order'
    end

    unless check_order(record.title, '{', '}')
      record.errors[:title] << 'has invalid braces order'
    end

    unless check_order(record.title, '[', ']')
      record.errors[:title] << 'has wrong square brackets order'
    end

    unless check_empty(record.title)
      record.errors[:title] << 'contains empty brackets'
    end
  end

  def check_order(title, opening, closing)
    sum = 0
    title.split('').each do |c|
      if c == opening
        sum += 1
      elsif c == closing
        sum -= 1
      end
      return false if sum < 0
    end
    true
  end

  def check_empty(title)
    content = ""
    opened = false
    [
      ['(', ')'], 
      ['[', ']'], 
      ['{', '}']
    ].each do |opening, closing|
      title.split('').each do |c|
        if c == opening
          opened = true
        elsif c == closing
          return false if content.blank? && opened
          opened = false
        elsif opened
          content << c unless ( %w( ( ) [ ] { } ).include?(c) )
        end
      end
    end
    true
  end
end