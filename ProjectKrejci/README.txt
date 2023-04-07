CPSC 42700 Project 5: Ruby HTTP Server Statistics
Jack Krejci
4/10/2022

NAME
    serverstats.rb

USAGE
    -hosts.txt
        A txt file that will be given by the user when running to program
        which should contain a top to bottom list of hosts that they want
        to grab data from.

DESCRIPTION
    The purpose of this program is to extend a class named "ServerHead"
    with my own class named "ServerStats" in order to display data about
    server and cookie information from a given txt file. The user will 
    give the txt file that they wish to use as a command-line argument
    when calling for the usage of this program. The program will open the
    given txt file and read it line by line in a loop, where each line 
    should be a proper given host name. Then the program will strip each 
    host to make sure it doesn't contain any spaces. 
    
    After that the host will send to the "ServerStats" class making a new 
    object whenever a new host is read from the file. This will make use of 
    the "ServerHead" class which will take the given host, and attempt to grab 
    the host's HTTP header from its web page on its web server. The program will 
    then be able to access information about the host's HTTP header, and the 
    "ServerStats" class will make use of the given information. This includes
    the host's server, cookie information, and whether the header even contains 
    data or not. If the header doesn't contain data, the "empty?" method in the 
    "ServerHead" class will be set to "true" which the main code then uses to 
    check if there's been a successful connection or not.
    
    If there wasn't a successful connection, the loop will skip to the next line 
    as running the rest of the loop in that case would not be necessary. It will
    also keep track of the number of successes or failures there are when 
    attempting to connect. If it was a success, then the rest of the loop will 
    make use of the "ServerStats" methods to check if the host is running on
    an Apache, IIS, NGinX, or some other server. As well as checking if the header
    contains cookies or not, which the loop will add to the appropriate counter
    variables that keep track of the server and cookie information. Finally,
    the program will display to the user the number of succeeded and failed
    connections. Lastly, along with the number of hosts that used one of the 
    servers, and the number of hosts we grabbed cookie data from both in the 
    form of an integer and a percentage. 

COMMAND-LINE OPTIONS
    ./serverstats.rb <hosts.txt>
        This is the only command-line option that is needed in order to run 
        the program properly. It will run the "serverstats.rb" program with
        the given txt file that user provides with it. The hosts txt file 
        must contain hosts in a top to bottom list as each line will be read
        as a single host. Any other format will count the improper line of
        hosts to be counted as a single failed attempt. The program also makes
        use of the "strip" method, so any whitespace after each host will be
        ignored. 
        
CLASSES
    -ServerStats < ServerHead
        This is the "ServerStats" class that is an extension of the "ServerHead"
        class, which contains methods that will be useful for the statistics
        of the data given by the "ServerHead" class. The class takes no required
        parameters, and will always return a boolean value whenever one of its
        methods are used. 
        
METHODS
    -apache?
        This is a method which is contained in the "ServerStats" class which will 
        attempt to get any server and cookie data from a given host. Then it returns
        true if the host's server is Apache, and false if not.
        
    -iis?
        This is a method which is contained in the "ServerStats" class which will 
        attempt to get any server and cookie data from a given host. Then it returns
        true if the host's server is IIS, and false if not.
        
    -nginx?
        This is a method which is contained in the "ServerStats" class which will 
        attempt to get any server and cookie data from a given host. Then it returns
        true if the host's server is NGinX, and false if not.
        
    -setcookie?
        This is a method which is contained in the "ServerStats" class which will 
        attempt to get any server and cookie data from a given host. Then it returns
        true if the host contains any cookie data, and false if not.
    
INPUT FILE FORMAT
    ./serverstats.rb <hosts.txt>
        This is the format that you will have to follow when running the program in
        the shell. Any other format than the one followed will produce an error.

KNOWN BUGS AND LIMITATIONS
    One of the problems that one may run into is if they try to use this program when
    putting more than one host on a single line in their txt file. This program will
    read the line as a single host instead of more than one host, then try to use all
    of that text to send to the "ServerHead". The header will then not be able to be
    grabbed, leaving the @header variable as "nill", and the main code of 
    "serverstats.rb" will count this as a failed attempt to connect a single server. 
    Not only will it fail even when the line contains multiple valid hosts, but it
    will count that as a failure to connect to one host instead of the actual number
    of hosts that were given on the entire line by the user. It will also crash if the
    user fails to give a proper txt file or any txt file at all as a command-line 
    argument. 
    
ADDITIONAL NOTES
    Make sure to use this program as it was intended to be used, and not modify it to
    do any harm! Also make sure to follow the correct format when attempting to use this
    program when it comes to your list or hosts, and command line arguments, or you will
    not be able to make use of this program. You also want to make sure that your hosts
    are in a www.<webpage>.<<net><com><edu><gov>> format instead of an HTTP//... type of 
    format or you may run into issues when attempting to grab the HTTP header. Other than
    that the program should be able to work properly as long as you follow the format
    properly. 
