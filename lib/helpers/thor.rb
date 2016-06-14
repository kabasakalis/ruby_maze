def say_with_tag(text,tag); say "\033[1m\033[36m" + tag.to_s.rjust(10) + "\033[0m" + "  #{text}" end

def ask_with_tag(question,tag)
  ask "\033[0m\033[33m" + ("#{tag}").rjust(10) + "\033[0m\e[32m" + "  #{question}\033[0m"
end

def yes_or_no?(question,tag)
  answer= ask_with_tag(question,tag)
  case answer.downcase
    when "yes", "y"
      true
    when "no", "n"
      false
    else
      yes?(question)
  end
end

def multiple_choice(question, choices)
  say_with_tag( question, 'question')
  values = {}
  choices.each_with_index do |choice,i|
    values[(i + 1).to_s] = choice
    say_with_tag choice , (i + 1).to_s + ')'
  end
  answer = ask_with_tag("Enter your selection:",'Pick up a choice') while !values.keys.include?(answer)
  values[answer]
end


