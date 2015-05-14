This is a small JavaServer Pages class project from 2009. Restoration/setup requires the following steps:

###Install NetBeans 6.7.1
-Download the "Java" package (without JDK):  https://netbeans.org/downloads/6.7.1/  
-Choose "customize" to include "Apache Tomcat 6.0.18  
-The only path/setting that needs to be changed is Tomcat's so that it has no spaces, ex:  C:\Apache\Tomcat  

###Install JDK Update 16

###Configuration
-Replace server.xml in C:\Apache\Tomcat\conf  
-Leave web.xml in place, it will be overwritten by the web.xml in the supplied WEB-INF folder  
-Update the path in server.xml with the location of the project  
-The context path is: /ch7 (so when Apache is running the page can be accessed at http://localhost:8080/ch7)  

###Install MySQL Server 5.1
-Choose:  Detailed Configuration, Developer Machine, Multifunctional Database  
-Leave InnoDB Tablespace Settings as "Installation Path", choose "Decision Support"  
-Check "Add firewall exception for this port" just in case  
-Choose "Standard Character Set" and check "Include Bin Directory in Windows PATH"  
-Set a root password  
-Execute  

###Test MySQL
mysqlshow -u root -p  
If you can see a listing of the databases that come with MySQL, installation is complete.  

You can list the tables in the included “mysql” DB by running:  
mysqlshow mysql –u root -p  

To launch the MySQL command line, run:  
mysql -u root -p  

###Create Database and User in MySQL
create database salesdatabase;  
create user java;  
grant CREATE,INSERT,DELETE,UPDATE,SELECT on salesdatabase.* to java;  
set password for java = password('java');  
use salesdatabase;  
source create.sql;  

###Start Apache Tomcat
-Tomcat can use the JRE or the JDK. To use the JRE, type the following in CMD:  

cd C:\Apache\Tomcat  
set "JAVA_HOME="  
set "JRE_HOME=C:\Program Files (x86)\Java\jre7"  
(see:  http://stackoverflow.com/questions/18468681/tomcat-6-java-home)  

catalina run  

###Open the Site
-Go to:  http://localhost:8080/ch7  
-Login as one of the users listed in the user table, ex: jsmith / bluesky  
