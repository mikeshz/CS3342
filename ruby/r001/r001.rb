def sayHi
   puts "Hello World!"
end

#puts ARGF.read
# print all the lines in every file passed via command line that contains login
inp = $stdin.read
lineNumber = 0
commitLine = ""
inp.each_line do |line|
    #do something with line
    if lineNumber == 0 || line[0..5] == "commit"
        commitLine = line;
        lineNumber = 0
    elsif lineNumber == 1
        if line[0...38] != "Author: Bob Webber <webber@csd.uwo.ca>"
            puts commitLine
            puts line
        else
            lineNumber = -1
        end
    elsif lineNumber != -1
        puts line
    end

    if lineNumber != -1
        lineNumber += 1
    end
end
#puts inp
