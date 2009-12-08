# The Inflection Navigator

A patient receives a serious diagnosis from his or her physician. The physician instructs the patient to setup 3 tests, see 2 specialists and read material on the condition -- all within 2 weeks.

This 'Inflection Point' in the patient's health requires a lot of effort and coordination.  But, what if the patient's clinic designated a "Navigator" to guide the patient through these activities.  The Navigator follows a protocol tailored to the patient's diagnosis and ensures the protocol is completed in a timely and efficient manner.  Each patient diagnosis requires the Navigator to manage a distinct set of activities within a scheduled time frame.

Ideally, the Navigator would have a web-based tool that assists them in:

- Applying a consistent protocol of activities to each patient based on their diagnosis.
- Managing each patient's progress in completing the protocol.
- Tracking and detailing the outcome of each patient.

The [Szollosi Healthcare Innovation Program](http://www.theshiphome.org/) and the [Northwestern Bioinformatics Center](http://www.nucats.northwestern.edu/centers/nubic/index.html) have built such a tool -- the Inflection Navigator.

# Technical Architecture

The Inflection Navigator is a hybrid application composed of the following components:

1. A light-weight patient and provider registry written in Ruby on Rails.
1. A protocol and patient-activity management Java web application utilizing the National Cancer Institute caBIG®'s Patient Study Calendar(PSC) -- an open-source software application.
1. The ESUP CAS Server configured to authenticate against a unencrypted, file-based store of users.  (<a name="authentication-warning">Warning!</a> This configuration should only be used for testing purposes.  For a production deployment, an institutional CAS server should be used or the ESUP CAS server should reconfigured to authenticate against a secure store of users -- for example, an LDAP server.  See [http://esup-casgeneric.sourceforge.net/install.html ](http://esup-casgeneric.sourceforge.net/install.html) for further details.)
1. A proxy call back application to enable the patient/provider registry Ruby on Rails application to make CAS proxy calls to the PSC.  See the documentation for the RubyCAS-Client for an explanation of running a separate Rails application to enable CAS proxying: [http://rubycas-client.rubyforge.org/](http://rubycas-client.rubyforge.org/)

A seamless end-user experience is provided by a shared look and feel, inter-application communication via RESTful API calls and the implementation of the single sign on Central Authentication Service protocol.

# Source Code

All of the source code for the application is contained within its [installation directory](http://cloud.github.com/downloads/mgurley/inav/INAV.zip). The official URLs for the application's components can be found at the following locations:

- The patient/provider registry Ruby on Rails application.  Available at: [http://github.com/mgurley/inav](http://github.com/mgurley/inav)
- The protocol and patient-activity management Java web application -- the Patient Study Calendar.  Available at: [http://gforge.nci.nih.gov/frs/?group_id=31](http://gforge.nci.nih.gov/frs/?group_id=31)
- The CAS proxy callback application.  Available at: [http://github.com/mgurley/inav_cas_callback](http://github.com/mgurley/inav_cas_callback)
- The ESUP CAS Server and CAS generic handler.  Available at: [http://esup-casgeneric.sourceforge.net/index.html](http://esup-casgeneric.sourceforge.net/index.html)

# Installation Prerequisites

- Java SE Development Kit	JDK 5.0.  The Java SE development kit with JRE, compilers and debuggers  Available at: [http://java.sun.com/javase/downloads/index.jsp](http://java.sun.com/javase/downloads/index.jsp)
- Apache Tomcat 5.5.17 or higher application servlet container for JSP.  Available at: [http://tomcat.apache.org/download-55.cgi](http://tomcat.apache.org/download-55.cgi)
- PostgreSQL 8.3.4 or higher database server.  Available at: [http://www.postgresql.org/download/](http://www.postgresql.org/download/)
- Jruby 1.4.0 or higher.  Java-implementation of the Ruby programming language.  Available at: [http://jruby.org/download](http://jruby.org/download)

Currently, the application is limited to running under the Tomcat application server and the PostgreSQL database server.  These limitations will be removed in future releases.

# Installation Steps

These steps assume that you have installed the prerequisites.


## Download the software (Section 1)
<ol>
  <li>Download and unzip the <a href="http://cloud.github.com/downloads/mgurley/inav/inav.zip">installation directory.</a>  It contains the following directories and files</li>
  <ol>
    <li>A directory named 'psc' containg the files 'psc.war', 'psc_install.doc' and a directory named 'conf-samples'.</li>
    <li>A directory named 'inav' containg the file 'inav.war' and a directory named 'conf-samples'.</li>
    <li>A directory named 'inav_cas_callback' containing the file 'inav_cas_callback.war'.</li>
    <li>A directory named 'cas' containing the ESUP CAS server.</li>
  </ol>
</ol>

## Create the Databases (Section 2)
<ol>
  <li>Create the PSC database.  Replace the name 'study_calendar_staging' in the following steps if you prefer a different name.</li>
  <ol>
    <li>Login to PostgreSql with a user appropriate to your environment.<br /><code>psql -U postgres -W</code></li>
    <li><code>CREATE DATABASE study_calendar_staging;</code></li>
    <li><code>CREATE USER study_calendar_staging WITH CREATEDB PASSWORD 'study_calendar_staging';</code><br />(Replace the password with a suitably secure password.)</li>
    <li><code>ALTER DATABASE study_calendar_staging OWNER TO study_calendar_staging;</code></li>
    <li><code>ALTER USER study_calendar_staging SUPERUSER;</code></li>
  </ol>
  <li>Create the INAV database.  Replace the name 'inav_staging' in the following steps if you prefer a different name.</li>
  <ol>
    <li>Login to PostgreSql with a user appropriate to your environment.<br /><code>psql -U postgres -W</code></li>
    <li><code>CREATE DATABASE inav_staging;</code></li>
    <li><code>CREATE USER inav_staging WITH CREATEDB PASSWORD 'inav_staging';</code><br />(Replace the password with a suitably secure password.)</li>
    <li><code>ALTER DATABASE inav_staging OWNER TO inav_staging;</code></li>
    <li><code>ALTER USER inav_staging SUPERUSER;</code></li>
  </ol>
</ol>

## Install and configure the PSC (Section 3)

<ol>
  <li>Find the 'datasource.properties' file in the 'psc/conf-samples' directory in the installation directory.</li>
  <li>Move the 'datasource.properties' file to '$CATALINA_HOME/conf/psc'.  If the 'psc' directory does not exist, create it and grant read permission on the file to the user which runs Tomcat on your system.</li>
  <li>Enter the proper JDBC connection values as follows:
    <table border="0" cellspacing="5" cellpadding="5">
      <tr><th>JDBC Connection Parameter</th><th>Value</th></tr>
      <tr><td>datasource.url</td><td>Use the proper JDBC url for your database.  With a database named “study_calendar_staging” this value would be 'jdbc:postgresql:study_calendar_staging'.</td></tr>
      <tr><td>datasource.username</td><td>The username to connect to the database from Section 2.</td></tr>
      <tr><td>datasource.password</td><td>The password to connect to the database from Section 2.</td></tr>
    </table>
  </li>
  <li>Uncomment the line (delete the ‘#’ symbol) that corresponds to your database.</li>
  <li>Find 'psc.war' file in the 'psc' directory in the installation directory.</li>
  <li>Move the 'psc.war' file to '$CATALINA_HOME/webapps'.</li>
  <li>Start Tomcat.</li>
  <li>Using a web browser, go to the PSC URL as determined by your Tomcat configuration.  This will most likely be similar to: http://hostname.domain:portnumber/psc.  On a development workstation, this will most likely be: http://127.0.0.1:8080/psc</li>
  <li>Follow the on-screen instructions to create your first user and site.  For more instructions regarding configuring the Patient Study Calendar, please see the <a href="http://gforge.nci.nih.gov/plugins/scmcvs/cvsweb.php/studycalendar/PhaseIII/PSC_Admin_Guide.doc?rev=1.1;content-type=application%2Foctet-stream;cvsroot=studycalendar">Patient Study Calendar Admin Guide</a> and the <a href="http://gforge.nci.nih.gov/plugins/scmcvs/cvsweb.php/studycalendar/PhaseIII/PSC_End_User_Guide.doc?rev=1.1;content-type=application%2Foctet-stream;cvsroot=studycalendar">Patient Study Calendar End User Guide</a></li>
  <ol>
    <li>For the initial setup of PSC, make sure you select 'local' for the Authentication System.  Later we will change it to CAS.</li>
    <li>Make sure to remember 'username' and 'password' of the first User you created for PSC.</li>
    <li>Make sure to remember the 'site name' and 'assigned identifier' of your first PSC site.  Only create one site within PSC.  The INAV application currently only supports interacting with one PSC site.</li>
  </ol>

</ol>

## Install and configure the CAS server (Section 4)

Optional section.  If you already have a CAS server in your  institution, move on to Section 5.

<ol>
  <li>Find the 'cas' directory in the installation directory.</li>
  <li>Move the 'cas' directory to '$CATALINA_HOME/webapps'.</li>
  <li>Make a directory named 'inav' in '$CATALINA_HOME/conf'.  Grant read permission on the directory to the user which runs Tomcat on your system.</li>
  <li>Find the 'inav-users.txt' file in the 'inav/conf-samples' directory in the installation directory.</li>
  <li>Move the 'inav-users.txt' file to '$CATALINA_HOME/conf/inav'.  Grant read permission on the file to the user which runs Tomcat on your system.</li>
  <li>This is an unencrypted, file-based store of users that the CAS server will look up for authentication.  It is a comma-separated list of 'username' and 'password'.  The initial copy of the file has the values 'admin,password'.  Replace it with the username and password that you entered in Section 3.</li>
  <li>Any new users added to PSC will need to be added to this file  <a href="#authentication-warning">Warning!  See above.</a>  This configuration should only be used for testing purposes.</li>
  <li>Find the 'genericHandler.xml' file in the '$CATALINA_HOME/webapps/cas/WEB-INF' directory</li>
  <li>Replace the content in the 'filename' element in the 'genericHandler.xml' file with the full path to the 'inav-users.txt' file.  For example, on a MAC-based system this might be '/opt/local/share/java/tomcat5/conf/inav/inav-users.txt'</li>
  <li>Find the 'LoggerConf.xml' file in the '$CATALINA_HOME/webapps/cas/WEB-INF' directory</li>
  <li>Replace the content of the value attribute in the 'param' element with the path to the log directory your system's Tomcat instance.  For example on a MAC-based system this might be '/opt/local/share/java/tomcat5/logs/esup-casgeneric.log'</li>
  <li>Test the CAS server</li>
  <ol>
    <li>Go to http://hostname.domain:portnumber/cas.  On a development workstation, this will most likely be: http://127.0.0.1:8080/cas.</li>
    <li>Log in with the credentials you entered into the 'inav-users.txt' file.  A message should appear saying 'You have been logged in successfully.'</li>
  </ol>
</ol>

## Configure Tomcat to use SSL (Section 5)

The Java CAS client used by the Patient Study Calendar requires that the CAS server be served over SSL.

<ol>
  <li>See http://tomcat.apache.org/tomcat-5.5-doc/ssl-howto.html to learn how to enable SSL directly on a Tomcat instance. <sgtrong>Warning!</strong>  If a self-signed SSL certificate is not sufficient to meet you security policies, please investigate obtaining a certificate from a well-known CA</li>
  <li><code>$JAVA_HOME/bin/keytool -genkey -alias tomcat -keyalg RSA -file tomcat.crt</code><br />. Important! The common name for the certificate in this step should be a valid hostname for your system.</li>
  <li>The Java client used by PSC needs to trust the certificate used generated in the preceding step.<br /><code>keytool -import -keystore $JAVA_HOME/lib/security/cacerts -file tomcat.crt/</code></li>
  <li>Test the CAS server running under SSL</li>
</ol>

## Configure PSC to use CAS

<ol>
  <li>Log into PSC with the first user you setup in section 3.</li>
  <li>Click the 'Configure authentication' menu item</li>
  <li>Select 'CAS' from the list'</li>
  <li>Enter in the Service URL field the URL to you institution's CAS server or the CAS server you installed in section 5.  On a development workstation, this will most likely be: https://localhost:8443/cas.  Note: The host name of the CAS server must match the common name you assigned to the certificated you generated in section 5</li>
  <li>Enter in the PSC base URL field the URL to this PSC instance.  On a development workstation, this will most likely be: https://127.0.0.1:8443/psc/</li>
</ol>
