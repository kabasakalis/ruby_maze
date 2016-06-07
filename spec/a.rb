foo = "left"
 def  foo.opposite
  :right
end

foo.opposite # =>

# ~> NoMethodError
# ~> undefined method `opposite' for "left":String
# ~>
# ~> /tmp/seeing_is_believing_temp_dir20160607-27996-69kay1/program.rb:7:in `<main>'
