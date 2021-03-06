include Java # not really needed
require 'lib/hacksaw_core.rb'
include Hacksaw

# Java must be passed this parameter:
# -javaagent:Hacksaw.jar
# Or directly to JRuby as:
# -J-javaagent:Hacksaw.jar

#disable_hacksaw
#show_matches_enable




modify :classes=>/com.quadcs.hacksaw.demo.[FB][a-z]+/ do |c| 
  
  c.modify :method=>/getFoo/ do |m|        
      m.modify_method_calls :classname=>"java.lang.String",:methodname=>"toUpperCase" do
         "{ $_ = $0.toLowerCase(); }"
    end  
  end      
end



b = com.quadcs.hacksaw.demo.Bar.new()

# I really wish these could be lowercase...
puts b.getFoo()
puts b.getFoobar()
