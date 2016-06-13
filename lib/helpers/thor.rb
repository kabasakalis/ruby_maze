
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




def middleman


  @middleman_folder = ask_with_tag('What is the name of the middleman folder?Usually it\'s middleman or frontend.','middleman')
  while !File.exists?("#{@middleman_folder}") do
  @middleman_folder = ask_with_tag('Middleman folder not found.Make sure there is a middleman folder in the root of your project (named middleman of frontend usually),and type the name.','middleman')
  end

  @middleman_source_folder = ask_with_tag('What is the name of the middleman source folder?Usually it\'s source or src.','middleman')
  while !File.exists?("#{@middleman_folder}/#{@middleman_source_folder}") || @middleman_source_folder.blank?  do
  @middleman_source_folder = ask_with_tag('Middleman source folder not found.Usually it\'s source or src.Please check your middleman folder for the correct name:','middleman')
  end

end
