# Style Guide and Pitfalls

* [MySQL](./mysql.md)
* [Node.js](./node.md)
* [PHP](./php.md)
* [Golang](./go.md)

## Architecture

                    +------------------+                                   
                    |       API        |                                   
                    +------------------+                                   
                            |                                              
                            |                                              
                            |                                              
                   +-------------------+                                   
                   |     OAuth 2.0     |                                   
                   +-------------------+                                   
                            |                                              
                            |                                              
       +-------------------------------------------+                       
       |               |              |            |                       
       |               |              |            |                       
       |               |              |            |                       
 +-----------+  +---------------+  +-------+  +----------+                  
 |Web Client |  |Browser Client |  |  iOS  |  |  Android |                  
 +-----------+  +---------------+  +-------+  +----------+                  
                                                                                                                                        
                                                                           
* API should mostly written in static, strongly-type languages (Golang or Java), and should be distributed.
* Web client (this refer to server side) as front-end could be written in dynamic languages. They should be restricted to Node.js or PHP 7. Python might be used for supporting roles like natural language processing. Be cautious Python engineers are not easy to find.
* Even so, we are using 5 types of programming languages: Golang, Java, Swift, Node.js, PHP. The types of languages should be stricted limited.