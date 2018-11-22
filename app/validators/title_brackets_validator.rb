class TitleBracketsValidator < ActiveModel::Validator

  BRECKETS_PAIRS = [
    ['(', ')'],
    ['[', ']'],
    ['{', '}']
  ]

  def validate(record)
    check_number(record)
    check_order(record)
    check_empty(record)
  end

  private

  def check_number(record)
    BRECKETS_PAIRS.each do |opening, closing|
      unless record.title.count(opening) == record.title.count(closing)
        record.errors[:title] << "has invalid number of #{opening}#{closing}"
      end
    end
  end

  def check_order(record)
    BRECKETS_PAIRS.each do |opening, closing|
      sum = 0
      record.title.split('').each do |c|
        if c == opening
          sum += 1
        elsif c == closing
          sum -= 1
        end
        record.errors[:title] << "has invalid #{opening}#{closing}" if sum < 0
      end
    end
  end

  def check_empty(record)
    content = ""
    opened = false

    BRECKETS_PAIRS.each do |opening, closing|
      record.title.split('').each do |c|
        if c == opening
          opened = true
        elsif c == closing
          record.errors[:title] << 'contains empty brackets' if content.blank? && opened
          opened = false
        elsif opened
          content << c unless ( %w( ( ) [ ] { } ).include?(c) )
        end
      end
    end
  end
end