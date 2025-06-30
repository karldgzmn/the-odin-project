def substrings(text, dictionary)
  result = {}
  lower_text = text.downcase

  dictionary.each do |word|
  count = lower_text.scan(word).count
  if count > 0
    result[word] = count
  end
    end
result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("below", dictionary).inspect
# Should output: {"below"=>1, "low"=>1}

puts substrings("Howdy partner, sit down! How's it going?", dictionary).inspect
# Should match the expected output

  