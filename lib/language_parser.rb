def parse_response(input)
  words = input.split(/ /)
  verb = parse_verb(words)
  noun = parse_noun(words)

  handle_response(verb, noun)
end

def parse_verb(text)
  verbs = ["look", "attack", "open", "inventory", "i", "drop", "pick"]
  verb = text.find { |word| verbs.include?(word) }
end

def parse_noun(text)
  noun = text.length > 1 ? text.last : nil
end

def handle_response(verb, noun)

  if verb == nil && noun == nil
    return false
  end

  if verb == "quit" || verb == "q"
    @stop = true
  end

  if noun == nil
    if @player.respond_to?(verb.to_sym)
      @player.method(verb.to_sym).call
    else
      puts "You don't know how to #{verb.to_s}"
    end
  else
    noun = objects[noun.to_sym]
    if @player.respond_to?(verb)
      @player.method(verb).call(noun)
    else
      puts "You don't know how to do that."
    end
  end
end