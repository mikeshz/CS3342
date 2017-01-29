input_array = ARGV
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
        if (singleCommit != "")
            if type == "j"
                jsCommits.push(singleCommit)
            elsif type == "r"
                rubyCommits.push(singleCommit)
            elsif type == "h"
                haskellCommits.push(singleCommit)
            else
                miscCommits.push(singleCommit)
            end
        end

        singleCommit = ""
        commitLine = line
        lineNumber = 0
    elsif lineNumber == 1
        if line[0...38] != "Author: Bob Webber <webber@csd.uwo.ca>"
            singleCommit += commitLine[7..-1]
            #singleCommit += line
        else
            lineNumber = -1
        end
    elsif lineNumber == 2
        singleCommit = line[8..-2] + singleCommit
    elsif lineNumber == 4
        singleCommit += line
        type = line[9...10]
    elsif lineNumber != -1
        singleCommit += line
        #puts line
    end

    if lineNumber != -1
        lineNumber += 1
    end
end

if input_array.length == 0
    puts jsCommits.reverse
    puts rubyCommits.reverse
    puts haskellCommits.reverse
    puts miscCommits.reverse
elsif input_array[0] == "js" || input_array[0] == "javascript"
    puts jsCommits.reverse
elsif input_array[0] == "ruby"
    puts rubyCommits.reverse
elsif input_array[0] == "haskell"
    puts haskellCommits.reverse
elsif input_array[0] == "other" || input_array[0] == "misc"
    puts miscCommits.reverse
end
