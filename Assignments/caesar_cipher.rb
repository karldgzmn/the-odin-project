def caesar_cipher(text, shift)
  uppercase = ('A'..'Z').to_a
  lowercase = ('a'..'z').to_a

  result = text.chars.map do |char|
    if uppercase.include?(char)
      new_index = (uppercase.index(char) + shift) % 26
      uppercase[new_index]
    elsif lowercase.include?(char)
      new_index = (lowercase.index(char) + shift) % 26
      lowercase[new_index]
    else
      char
    end
  end
  result

  puts caesar_cipher("What a string!", 5)