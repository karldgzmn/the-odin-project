def caesar_cipher(text, shift)
    upper = ('A'..'Z').to_a
    lower = ('a'..'z').to_a

    result = text.chars.map do |char|
      if upper.include?(char)
        upper[(upper.index(char) + shift) % 26]
      elsif lower.include?(char)
        lower[(lower.index(char) + shift) % 26]
      else
      char
    end
  end
end

  result.join
end

puts caesar_cipher("What a string!", 5)
