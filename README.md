# RecurciveDNS

You will write a Ruby program which does domain name resolution and prints the lookup chain, until it resolves to an IPv4 address.

Sample output for the above zone file:

$ ruby lookup.rb google.com
google.com => 172.217.163.46

$ ruby lookup.rb gmail.com
gmail.com => mail.google.com => google.com => 172.217.163.46

$ ruby lookup.rb gmil.com
Error: record not found for gmil.com
You should use the following code (lookup.rb) as a starting template for your assignment. Do not edit any existing code, except the part that says FILL YOUR CODE HERE. This means you have to adhere to the given API in your implementation.

