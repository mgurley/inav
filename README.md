# The Inflection Navigator

A patient receives a serious diagnosis from his or her physician. The physician instructs the patient to setup 3 tests, see 2 specialists and read material on the condition -- all within 2 weeks.

This 'Inflection Point' in the patient's health requires a lot of effort and coordination.  But, what if the patient's clinic designated a 'Navigator' to guide the patient through these activities.  The Navigator follows a protocol tailored to the patient's diagnosis and ensures the protocol is completed in a timely and efficient manner.  Each patient diagnosis requires the Navigator to manage a distinct set of activities within a scheduled time frame.

The Navigator needs a tool that assists them in:

- Applying a consistent protocol of activities to each patient based on their diagnosis.
- Managing each patient's progress in completing the protocol.
- Tracking and detailing the outcome of each patient.

The [Szollosi Healthcare Innovation Program](http://www.theshiphome.org/) and the [Northwestern University Biomedical Informatics Center](http://www.nucats.northwestern.edu/centers/nubic/index.html) have built such a tool -- the Inflection Navigator.

For questions or inquiries about the the Inflection Navigator, please contact <a href="mailto:m-gurley@northwestern.edu">Michael Gurley</a> at the [Northwestern University Biomedical Informatics Center][NUBIC].

# Technical Architecture

The Inflection Navigator is a hybrid application composed of the following components:

1. A light-weight patient and provider registry written in Ruby on Rails.
1. A protocol and patient-activity management Java web application based on the National Cancer Institute caBIG®'s Patient Study Calendar(PSC) -- an open-source Java web application.
1. The ESUP CAS Server configured to authenticate against an unencrypted, file-based store of users.  (<strong>Note!</strong>  This configuration should only be used for testing purposes.  For a production deployment, an institutional CAS server should be used or the ESUP CAS server should be reconfigured to authenticate against a secure store of users -- for example, an LDAP server.  See [http://esup-casgeneric.sourceforge.net/install.html ](http://esup-casgeneric.sourceforge.net/install.html) for further details.)
1. A proxy callback application to enable the patient and provider registry Ruby on Rails application to make CAS proxy calls to PSC.  (<strong>Note!</strong>  See the documentation for the RubyCAS-Client for an explanation of running a separate Rails application to enable CAS proxying: [http://rubycas-client.rubyforge.org/](http://rubycas-client.rubyforge.org/))

Within this hybrid application, a seamless end-user experience is provided by a shared look and feel, inter-application communication via RESTful API calls and the implementation of single sign-on via the CAS protocol.

# Source Code

All of the source code for the application is contained within its [installation package](http://cloud.github.com/downloads/mgurley/inav/inav.zip). The official URLs for the application's components can be found at the following locations:

- The patient and provider registry Ruby on Rails application.  Available at: [http://github.com/mgurley/inav](http://github.com/mgurley/inav)
- The protocol and patient-activity management Java web application -- the Patient Study Calendar.  Available at: [http://gforge.nci.nih.gov/frs/?group_id=31](http://gforge.nci.nih.gov/frs/?group_id=31)
- The CAS proxy callback application.  Available at: [http://github.com/mgurley/inav_cas_callback](http://github.com/mgurley/inav_cas_callback)
- The ESUP CAS Server and CAS generic handler.  Available at: [http://esup-casgeneric.sourceforge.net/index.html](http://esup-casgeneric.sourceforge.net/index.html)

# Installation Prerequisites

- Java SE Development Kit	JDK 5.0.  The Java SE development kit with JRE, compilers and debuggers  Available at: [http://java.sun.com/javase/downloads/index.jsp](http://java.sun.com/javase/downloads/index.jsp)
- Apache Tomcat 5.5.17 or higher application servlet container.  Available at: [http://tomcat.apache.org/download-55.cgi](http://tomcat.apache.org/download-55.cgi)
- PostgreSQL 8.3.4 or higher database server.  Available at: [http://www.postgresql.org/download/](http://www.postgresql.org/download/)

# Installation Steps

These steps assume the prerequisites are installed on your target system.


## Download The Software (Section 1)
<ol>
  <li>Download and unzip the <a href="http://cloud.github.com/downloads/mgurley/inav/inav.zip">installation package.</a>  It contains the following directories and files:</li>
  <ol>
    <li>A directory named 'psc' containg the files 'psc.war', 'psc_install.doc' and a directory named 'conf-samples'.</li>
    <li>A directory named 'inav' containg the file 'inav.war' and a directory named 'conf-samples'.</li>
    <li>A directory named 'inav_cas_callback' containing the file 'inav_cas_callback.war'.</li>
    <li>A directory named 'cas' containing the ESUP CAS server (the Yale ITS CAS server and CAS Generic Handler).</li>
  </ol>
</ol>

## Create the Databases (Section 2)
<ol>
  <li>Create the PSC database.  Replace the name 'study_calendar' in the following steps if you prefer a different name.</li>
  <ol>
    <li>Login to PostgreSQL with a user appropriate to your environment.<br /><code>psql -U postgres -W</code></li>
    <li><code>CREATE DATABASE study_calendar;</code></li>
    <li><code>CREATE USER study_calendar WITH CREATEDB PASSWORD 'study_calendar';</code><br />(Replace the password with a suitably secure password.)</li>
    <li><code>ALTER DATABASE study_calendar OWNER TO study_calendar;</code></li>
  </ol>
  <li>Create the INAV database.  Replace the name 'inav' in the following steps if you prefer a different name.</li>
  <ol>
    <li>Login to PostgreSQL with a user appropriate to your environment.<br /><code>psql -U postgres -W</code></li>
    <li><code>CREATE DATABASE inav;</code></li>
    <li><code>CREATE USER inav WITH CREATEDB PASSWORD 'inav';</code><br />(Replace the password with a suitably secure password.)</li>
    <li><code>ALTER DATABASE inav OWNER TO inav;</code></li>
  </ol>
</ol>

## Install and Configure PSC (Section 3)

<ol>
  <li>Find the 'datasource.properties' file in the 'psc/conf-samples' directory in the installation package.</li>
  <li>Move the 'datasource.properties' file to '$CATALINA_HOME/conf/psc'.  If the 'psc' directory does not exist, create it and grant read permission on it to the user which runs Tomcat on your system.</li>
  <li>In the 'datasource.properties' file, enter the proper JDBC connection values as follows:
    <table border="0" cellspacing="5" cellpadding="5">
      <tr><th>JDBC Connection Parameter</th><th>Value</th></tr>
      <tr><td>datasource.url</td><td>Use the proper JDBC url for your database.  With a database named “study_calendar” this value would be 'jdbc:postgresql:study_calendar'.</td></tr>
      <tr><td>datasource.username</td><td>The username to connect to the database from Section 2.</td></tr>
      <tr><td>datasource.password</td><td>The password to connect to the database from Section 2.</td></tr>
    </table>
  </li>
  <li>In the 'datasource.properties' file, uncomment the line (delete the ‘#’ symbol) for PostgreSQL.</li>
  <li>Find the 'psc.war' file in the 'psc' directory in the installation package.</li>
  <li>Move the 'psc.war' file to '$CATALINA_HOME/webapps'.</li>
  <li>Restart Tomcat.</li>
  <li>Using a web browser, go to the PSC URL as determined by your Tomcat configuration.  This will most likely be similar to: http://hostname.domain:portnumber/psc.  On a development workstation, this will most likely be: http://localhost:8080/psc</li>
  <li>Follow the on-screen instructions to create your first user and site.  For more instructions regarding configuring PSC, please see the <a href="https://cabig-kc.nci.nih.gov/CTMS/KC/index.php/PSC_Administration_Guide">Patient Study Calendar Admin Guide</a> and the <a href="https://cabig-kc.nci.nih.gov/CTMS/KC/index.php/PSC_End_User_Guide">Patient Study Calendar End User Guide</a>
    <ol>
      <li>For the initial setup of PSC, make sure you select 'local' for the Authentication System.  Later it will change to CAS.</li>
      <li>Make sure to remember the 'username' and 'password' of the first User you create for PSC.</li>
      <li>Make sure to remember the 'site name' and 'assigned identifier' of your first PSC site.  Only create one site within PSC.  The INAV application currently only supports interacting with one PSC site.</li>
    </ol>
  </li>
</ol>

## Install and Configure the CAS server (Section 4)

Optional.  If you already have a CAS server in your institution, move on to Section 5.

<ol>
  <li>Find the 'cas' directory in the installation package.</li>
  <li>Copy the 'cas' directory to '$CATALINA_HOME/webapps'.</li>
  <li>Make a directory named 'inav' in '$CATALINA_HOME/conf'.  Grant read permission on the directory to the user which runs Tomcat on your system.</li>
  <li>Find the 'inav-users.txt' file in the 'inav/conf-samples' directory in the installation package.</li>
  <li>Move the 'inav-users.txt' file to '$CATALINA_HOME/conf/inav'.  Grant read permission on the file to the user which runs Tomcat on your system.</li>
  <li>This is an unencrypted, file-based store of users that the CAS server will look up for authentication.  It is a comma-separated list of 'username' and 'password'.  The initial copy of the file has the values 'admin,password'.  Replace it with the username and password that you entered in Section 3.</li>
  <li>Any new users added to PSC will need to be added to this file.</a></li>
  <li>Find the 'genericHandler.xml' file in the '$CATALINA_HOME/webapps/cas/WEB-INF' directory.</li>
  <li>Replace the content in the 'filename' element in the 'genericHandler.xml' file with the full path to the 'inav-users.txt' file.  For example, on an OSX system this might be '/opt/local/share/java/tomcat5/conf/inav/inav-users.txt'.</li>
  <li>Find the 'LoggerConf.xml' file in the '$CATALINA_HOME/webapps/cas/WEB-INF' directory.</li>
  <li>Replace the content of the value attribute in the 'param' element with the path to the log directory of your system's Tomcat server.  For example, on an OSX system this might be '/opt/local/share/java/tomcat5/logs/esup-casgeneric.log'.</li>
  <li>Test the CAS server</li>
  <ol>
    <li>Go to http://hostname.domain:portnumber/cas.  On a development workstation, this will most likely be: http://localhost:8080/cas.</li>
    <li>Log in with the credentials you entered into the 'inav-users.txt' file.  A message should appear saying 'You have been logged in successfully.'.</li>
  </ol>
</ol>

## Configure Tomcat to Use SSL (Section 5)

The Java CAS client used by PSC requires that the CAS server be served over SSL.

<ol>
  <li>See <a href="http://tomcat.apache.org/tomcat-5.5-doc/ssl-howto.html">http://tomcat.apache.org/tomcat-5.5-doc/ssl-howto.html</a> to learn how to enable SSL directly on a Tomcat server. <strong>Note!</strong>  If a self-signed SSL certificate is not sufficient to meet your security policies, please investigate obtaining a certificate from a well-known CA</li>
  <li><code>$JAVA_HOME/bin/keytool -genkey -alias tomcat -keyalg RSA -file tomcat.crt</code><br />  <strong>Note!</strong> The common name for the certificate created in this step should be a valid hostname for your system.</li>
  <li>The Java client used by PSC needs to trust the certificate created in the preceding step.<br /><code>keytool -import -keystore $JAVA_HOME/lib/security/cacerts -file tomcat.crt</code></li>
  <li>Test the CAS server running under SSL.</li>
  <ol>
    <li>Go to https://hostname.domain:portnumber/cas.  On a development workstation, this will most likely be: https://localhost:8443/cas.</li>
    <li>Log in with the credentials you entered into the 'inav-users.txt' file.  A message should appear saying 'You have been logged in successfully.'.</li>
  </ol>
</ol>

## Configure PSC to Use CAS (Section 6)

<ol>
  <li>Log into PSC with the first user you setup in section 3.</li>
  <li>Click the 'Configure authentication' menu item</li>
  <li>Select 'CAS' from the list.</li>
  <li>Enter in the Service URL field the URL to your institution's CAS server or the URL to the CAS server you installed in section 5.  On a development workstation, this will most likely be: https://localhost:8443/cas.  <strong>Note!</strong>  The host name of the CAS server must match the common name of the certificate you created in section 5.</li>
  <li>Enter in the PSC base URL field the URL to your PSC instance.  On a development workstation, this will most likely be: https://localhost:8443/psc/</li>
</ol>


## Install and Configure the INAV CAS Callback Application (Section 7)

The Ruby on Rails patient and provider registry component of the INAV application needs to make proxy CAS calls to the PSC application in order to retrieve and update information on behalf of the authenticated user.  A limitation in the Rails platform necessitate a separate application to handle CAS proxy callbacks.

<ol>
  <li>Find the file 'inav.yml' in the 'inav/conf-samples/' directory in the installation package.</li>
  <li>Move the 'inav.yml' file to '$CATALINA_HOME/conf/inav/'.</li>
  <li>In the 'inav.yml' file, set the the following properties:
    <table border="0" cellspacing="5" cellpadding="5">
      <tr><th>Property</th><th>Value</th></tr>
      <tr><td>cas.cas_base_url:</td><td>The URL to your institution's CAS server or the URL to the CAS server installed in section 5.</td></tr>
      <tr><td>cas.proxy_retrieval_url:</td><td>This will most likely be similar to: http://hostname.domain:portnumber/inav_cas_callback/cas_proxy_callback/retrieve_pgt.  On a development workstation, it will most likely be: https://localhost:8443/inav_cas_callback/cas_proxy_callback/retrieve_pgt.</td></tr>
      <tr><td>cas.proxy_callback_url:</td><td>This will most likely be similar to: http://hostname.domain:portnumber/inav_cas_callback/cas_proxy_callback/receive_pgt.  On a development workstation, it will most likely be: https://localhost:8443/inav_cas_callback/cas_proxy_callback/receive_pgt.</td></tr>
    </table>
  </li>
  <li>Find the 'inav_cas_callback.war' file in the 'inav_cas_callback' directory in the installation package.</li>
  <li>Move the 'inav_cas_callback.war' file to '$CATALINA_HOME/webapps'.</li>
  <li>Restart Tomcat.  The file 'inav_cas_callback.war' should have expanded into a directory named '$CATALINA_HOME/webapps/inav_cas_callback/'.</li>
  <li>Test the Callback application</li>
  <ol>
    <li>Go to the URL you entered for the value of the cas.proxy_retrieval_url property in inav.yml.  You should get the following response: 'No pgtIou specified. Cannot retreive the pgtId.'.</li>
    <li>Go to the URL you entered for the value of the cas.proxy_callback_url property in inav.yml.  You should get the following response: 'Okay, the server is up, but please specify a pgtIou and pgtId.'.</li>
  </ol>
</ol>

## Install and Configure INAV (Section 8)
<ol>
  <li>Find the file 'inav.yml' that you moved into the '$CATALINA_HOME/conf/inav/' directory in section 7.</li>
  <li>In the 'inav.yml' file, set the the following properties:
    <table border="0" cellspacing="5" cellpadding="5">
      <tr><th>Property</th><th>Value</th></tr>
      <tr><td>default.host</td><td>The host name of the computer where your PostgreSQL database server resides.</td></tr>
      <tr><td>inav.database</td><td>The name of the INAV database that you created in section 2, step 2.2.</td></tr>
      <tr><td>inav.username</td><td>The username of the owner of the INAV database that you created in section 2, step 2.2.</td></tr>
      <tr><td>inav.password</td><td>The password of the owner of the INAV database that you created in section 2, step 2.2.</td></tr>
      <tr><td>psc.psc_canonical_uri</td><td>The url to the PSC server setup in section 3.  <strong>Note!</strong> It is important to end this URL with a trailing slash -- '/'.</td></tr>
      <tr><td>psc.psc_service_uri</td><td>The url to PSC server setup in section 3 with following path appended: '/auth/cas_security_check'.</td></tr>
      <tr><td>psc.psc_site</td><td>The 'assigned identifier' of the PSC site you setup in section 3.</td></tr>
      <tr><td>psc.psc_rest_url</td><td>The url to PSC server setup in section 3 with following path appended: '/api/v1/'.</td></tr>
      <tr><td>smtp.address</td><td>The url of the SMTP sever to send emails from.</td></tr>
      <tr><td>smtp.port</td><td>The port of the SMTP sever to send emails from.</td></tr>
      <tr><td>smtp.domain</td><td>The domain of the SMTP sever to send emails from.</td></tr>
      <tr><td>exception_notifier.exception_recipients</td><td>The list of emails addresses to send exception notifications.</td></tr>
      <tr><td>exception_notifier.sender_address</td><td>The email address to send exception notifications from.</td></tr>
      <tr><td>exception_notifier.email_prefix</td><td>The email prefix used to send exception notifications.</td></tr>
    </table>
  </li>
  <li>Find the 'inav.war' file in the 'inav' directory in the installation package.</li>
  <li>Move the 'inav.war' file to '$CATALINA_HOME/webapps'.</li>
  <li>Restart Tomcat.  The file 'inav.war' should have expanded into a directory named '$CATALINA_HOME/webapps/inav/'.</li>
  <li>Create the INAV database schema:
    <ol>
      <li>Open a command shell and move to the directory '$CATALINA_HOME/webapps/inav/WEB-INF/'.</li>
      <li>Ensure that you have a CATALINA_HOME environment variable set.  If you do not, set it.  For example, on an OSX system this might be <code>export CATALINA_HOME=/opt/local/share/java/tomcat5/</code>.</li>
      <li>Ensure that you have a GEM_HOME environment variable set.  If you do not, set it.  For example, on an OSX system this might be <code>export GEM_HOME=/opt/local/share/java/tomcat5/webapps/inav/WEB-INF/gems</code>.</li>
      <li>Run the following command: <cod>java -jar lib/jruby-complete-1.4.0.jar -S rake db:migrate RAILS_ENV=production</code>.  This should create the database schema in the INAV database.</li>
    </ol>
  </li>
  <li>Load Medical Record Number Types:  Within the INAV system, patients can be assigned medical record numbers.  Each medical record number has a medical record number type.  A medical record number type might correspond to a Hospital or a Physician Group.  The system does not come with any medical record number types.  To setup medical record number types appropriate to your environment, perform the following steps:
    <ol>
      <li>Find the file 'inav.yml' that you moved into the '$CATALINA_HOME/conf/inav/' directory in section 7.</li>
      <li>In the 'inav.yml' file, edit the entries in the 'medical_record_number_types' property to names appropriate to your environment.</li>
      <li>Open a command shell and move to the directory '$CATALINA_HOME/webapps/inav/WEB-INF/'.</li>
      <li>Ensure that you have a CATALINA_HOME environment variable set.  If you do not, set it.  For example, on an OSX system this might be <code>export CATALINA_HOME=/opt/local/share/java/tomcat5/</code>.</li>
      <li>Ensure that you have a GEM_HOME environment variable set.  If you do not, set it.  For example, on an OSX system this might be <code>export GEM_HOME=/opt/local/share/java/tomcat5/webapps/inav/WEB-INF/gems</code>.</li>
      <li>Run the following command: <cod>java -jar lib/jruby-complete-1.4.0.jar -S rake setup:medical_record_types RAILS_ENV=production</code>.  This should load the medical record number types into the INAV database.</li>
    </ol>
  </li>
  <li>Test the INAV application
    <ol>
      <li>Go to https://hostname.domain:portnumber/inav.  On a development workstation, this will most likely be: https://localhost:8443/inav.</li>
      <li>Log in with the credentials you entered into the 'inav-users.txt' file. You should land on the Registrations page.</li>
      <li>To test the CAS authentication between INAV and PSC, click the link labeled 'go to Patient Study Calendar'.  You should land on the Dashboard page of PSC without being prompted to log in again.</li>
    </ol>
  </li>
</ol>

## Roadmap

<ol>
  <li>Create an Inflection navigator User Guide that covers:
    <ol>
      <li>Setting up protocols.</li>
      <li>Adding patients.</li>
      <li>Adding providers.</li>
      <li>Assigning providers to patients.</li>
      <li>Registering patients on protocols.</li>
      <li>Managing patient schedules.</li>
    </ol>
  <li>Create an administration interface to manage medical record number types.</li>
  <li>Automate the invocation of migrations upon deployment of the INAV .war file.</li>
  <li>Automate the patching of the JRuby rack library.</li>
  <li>Support other database platforms.</li>
  <li>Support other Java application server platforms.</li>
  </li>
</ol>


## Credits

The Inflection Navigator was developed for the [Szollosi Healthcare Innovation Program](http://www.theshiphome.org/) by the [Northwestern University Biomedical Informatics Center][NUBIC].

[NUBIC]: http://www.nucats.northwestern.edu/centers/nubic/index.html

### Copyright

Copyright (c) 2009 Michael Gurley, Northwestern University. See LICENSE for details.
