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
1. A protocol and patient-activity management Java web application utilizing the National Cancer Institute caBIG®'s Patient Study Calendar -- an open-source software application.
1. The ESUP CAS Server configured to authenticate against a non-encrypted, file-based store of users.  (This configuration should only be used for testing purposes.  For a production deployment, an institutional CAS server should be used or the ESUP CAS server should reconfigured to authenticate against a secure store of users -- for example, an LDAP server.  See [http://esup-casgeneric.sourceforge.net/install.html ](http://esup-casgeneric.sourceforge.net/install.html) for further details.)
1. A proxy call back application to enable the patient/provider registry Ruby on Rails application to make CAS proxy calls to the Patient Study Calendar.  See the documentation for the RubyCAS-Client for an explanation of running a separate Rails application to enable CAS proxying: [http://rubycas-client.rubyforge.org/](http://rubycas-client.rubyforge.org/)

A seamless end-user experience is provided by a shared look and feel, inter-application communication via RESTful API calls and the implementation of the single sign on Central Authentication Service protocol.

# Source Code

All of the source code for the application is contained within its [installation folder](http://cloud.github.com/downloads/mgurley/inav/INAV.zip). The official URLs for the application's components can be found at the following locations:

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


## Download the software
<ol>
  <li>Download and unzip the <a href="http://cloud.github.com/downloads/mgurley/inav/inav.zip">installation folder.</a>It will contain the following folders and files</li>
  <ol>
    <li>A folder named 'patient study calendar' containg the file 'psc.war', the PSC installation guide, and a folder named 'conf-samples'.</li>
    <li>A folder named 'inav' containg the file 'inav.war' and a folder named 'conf-samples'.</li>
    <li>A folder named 'inav_cas_callback' containing the file 'inav_cas_callback.war'.</li>
    <li>A folder named 'cas' containing the ESUP CAS server.</li>
  </ol>
</ol>

## Create the Databases
<ol>
  <li>Create the Patient Study Calendar database.  Replace the name 'study_calendar_staging' in the following steps if you prefer a different name.</li>
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

## Install and configure the  Patient Study Calendar