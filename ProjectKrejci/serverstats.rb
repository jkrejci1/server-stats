#!/usr/bin/ruby
#Jack Krejci

#Requirements for use of the outside class
require 'net/http'
require './serverhead.rb'

#Class: ServerStats -> Inherited from ServerHead class 
class ServerStats < ServerHead

    #Method to check if server is apache
    def apache?
        server, cookie = self.getServerAndCookie()
        match = /[Aa]pache/.match?(server)
        return match

    end
    
    #Method to check if server is iis
    def iis?
        server, cookie = self.getServerAndCookie()
        match = /IIS/.match?(server)
        return match
    end
    
    #Method to check if the server is NGinX
    def nginx?
        server, cookie = self.getServerAndCookie()
        match = /nginx/.match?(server)
        return match
    end
  
    #Method to check if header contains a non-empty value for the 'set-cookie' field
    def setcookie?
        server, cookie = self.getServerAndCookie()
        #Check if cookie is nill or not
        if cookie == nil
            return false
        else
            return true
        end
    end
end


#Main Code

#Keep counters for each server and the cookies and successes and fails
successCount = 0
failsCount = 0
apacheCount = 0
iisCount = 0
nginxCount = 0
otherServCount = 0
cookieCount = 0

#Read in a text file full of the data we're working with (as a CL argument)
File.open(ARGV[0]).each do |line|
    #Each line is the website (set a variable to it)
    host = line.strip

    #Serverhead takes the host, and the port number (use 80) we'll need that to send to stats class
    hostData = ServerStats.new(host) #Might be able to just send host, port# is initialized in class
    
    #Keep track of successful connections and failed connections (if empty is false it's a success!)
    empty = hostData.empty?
    if empty == false
        successCount += 1
    else
        failsCount += 1
        next #Skip to reading next line if we failed to connect (prevents worthless computations)
    end
    
    #Variables for checking a server and if there's a contained cookie
    apacheCheck = hostData.apache?
    iisCheck = hostData.iis?
    nginxCheck = hostData.nginx?
    cookieCheck = hostData.setcookie?

    #Add to the server/cookie counters when needed (if statements)
    #apache count (add one for succesfully connecting to a server)
    if apacheCheck == true
        apacheCount += 1
    #iis count (add one for succesfully connecting to a server)
    elsif iisCheck == true
        iisCount += 1
    #nginx count (add one for succesfully connecting to a server)
    elsif nginxCheck == true
        nginxCount += 1
    #Else -> it is another server (add one to other)
    else
        otherServCount += 1
    end
    
    #Add to cookie count if there was a cookie
    if cookieCheck == true
        cookieCount += 1
    end
end

#Statistics area of the code to provide all needed statistics 

#Successes and fails when connecting
puts "Got data from #{successCount} hosts, #{failsCount} failed."

#Calculate the percent of hosts that used our servers or had a cookie set
#Then round it to two decimal places
perApache = (apacheCount / successCount.to_f) * 100
rndApache = perApache.round(2)

perIIS = (iisCount / successCount.to_f) * 100
rndIIS = perIIS.round(2)

perNGINX = (nginxCount / successCount.to_f) * 100
rndNGINX = perNGINX.round(2)

perOther = (otherServCount / successCount.to_f) * 100
rndOther = perOther.round(2)

perCookie = (cookieCount / successCount.to_f) * 100
rndCookie = perCookie.round(2)

#Print the results to the user
puts "Servers running Apache: #{apacheCount} (#{rndApache}%)" 
puts "Servers running IIS: #{iisCount} (#{rndIIS}%)"
puts "Servers running NGinX: #{nginxCount} (#{rndNGINX}%)"
puts "Servers running other: #{otherServCount} (#{rndOther}%)"
puts "Cookie set: #{cookieCount} (#{rndCookie}%)"
