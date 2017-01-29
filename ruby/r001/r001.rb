def sayHi
   puts "Hello World!"
end

inp = $stdin.read
lineNumber = 0
commitLine = ""
singleCommit = ""
outputString = ""
type = ""

jsCommits = Array.new
rubyCommits = Array.new
haskellCommits = Array.new
miscCommits = Array.new

inp.each_line do |line|
    #do something with line
    if lineNumber == 0 || line[0..5] == "commit"
        outputString = singleCommit + outputString
        if type == "j"
            jsCommits.push(singleCommit)
            #outputString = "ruby" + outputString
        elsif type == "r"
            rubyCommits.push(singleCommit)
        elsif type == "h"
            haskellCommits.push(singleCommit)
        else
            miscCommits.push(singleCommit)
        end

        singleCommit = ""
        commitLine = line
        lineNumber = 0
    elsif lineNumber == 1
        if line[0...38] != "Author: Bob Webber <webber@csd.uwo.ca>"
            singleCommit += commitLine
            singleCommit += line
        else
            lineNumber = -1
        end
    elsif lineNumber == 4
        singleCommit += line
        type = line[9...10]
        #singleCommit += type
    elsif lineNumber != -1
        singleCommit += line
        #puts line
    end

    if lineNumber != -1
        lineNumber += 1
    end
end

puts jsCommits
puts rubyCommits
puts haskellCommits
