# The Inflection Navigator

A patient receives a serious diagnosis from his or her physician. The physician instructs the patient to setup 3 tests, see 2 specialists and read material on the condition -- all within 2 weeks.

- This 'Inflection Point' in the patient's health requires a lot of effort and coordination.  But, what if the patient's clinic designated a "Navigator" to guide the patient through these activities.
- The Navigator follows a protocol tailored to the patient's diagnosis and ensures the protocol is completed in a timely and efficient manner.
- Each patient diagnosis requires the Navigator to manage a distinct set of activities within a scheduled time frame.

Ideally, the Navigator would have a web-based tool that assists them in:

- Applying a consistent protocol of activities to each patient based on their diagnosis.
- Managing each patient's progress in completing the protocol.
- Tracking and detailing the outcome of each patient.

The [Szollosi Healthcare Innovation Program](http://www.theshiphome.org/) and the [Northwestern Bioinformatics Center](http://www.nucats.northwestern.edu/centers/nubic/index.html) have built such a tool -- the Inflection Navigator.

# Technical Architecture

The Inflection Navigator is a hybrid application composed of the following components:

1. A light-weight patient and provider registry written in Ruby on Rails.
1. A protocol and patient-calendar management Java web application utilizing the Patient Study Calendar -- a National Cancer Institute caBIG® open source software application.
1. The ESUP CAS Server configured to authenticate against a non-encrypted, file-based store of users.  This configuration should only be used for testing purposes.  For a production deployment, the packaged CAS server should be replaced by an existing CAS sever or be reconfigured to authenticate against a secure store of users.  See [http://esup-casgeneric.sourceforge.net/install.html ](http://esup-casgeneric.sourceforge.net/install.html) for further details.
1. A proxy call back application to enable the patient/provider registry Ruby on Rails application to make CAS proxy calls to the Patient Study Calendar.  See the documentation for the RubyCAS-Client for an explanation of running a separate Rails application to enable CAS proxying: [http://rubycas-client.rubyforge.org/](http://rubycas-client.rubyforge.org/)

Despite this hybrid architecture, a seamless end-user experience is provided by a shared look and feel, inter-application communication via RESTful API calls and the implementation of the single sign on Central Authentication Service protocol.

# Source Code

All of the source code for the application is contained within its download installation folder. The official URLs for the application's components can be found at the following locations:

- The patient/provider registry Ruby on Rails application.  Available at: [http://github.com/mgurley/inav](http://github.com/mgurley/inav)
- The protocol and patient-calendar management Java web application -- the Patient Study Calendar.  Available at: [http://gforge.nci.nih.gov/frs/?group_id=31](http://gforge.nci.nih.gov/frs/?group_id=31)
- The CAS proxy callback application.  Available at: [http://github.com/mgurley/cas_callback](http://github.com/mgurley/cas_callback)
- The ESUP CAS Server and CAS Generic Handler handler.  Available at: [http://esup-casgeneric.sourceforge.net/index.html](http://esup-casgeneric.sourceforge.net/index.html)

# Installation Prerequisites

- Java SE Development Kit	JDK 5.0.  The Java SE development kit with JRE, compilers and debuggers  Available at: [http://java.sun.com/javase/downloads/index.jsp](http://java.sun.com/javase/downloads/index.jsp)
- Apache Tomcat 5.5.17 or higher.  Application servlet container for JSP.  Available at: [http://tomcat.apache.org/download-55.cgi](http://tomcat.apache.org/download-55.cgi)
- PostgreSQL 8.3.4 or higher.  Database server.  Available at: [http://www.postgresql.org/download/](http://www.postgresql.org/download/)
- Jruby 1.4.0 or higher.  Java-implementation of the Ruby programming language.  Available at: [http://jruby.org/download](http://jruby.org/download)

Currently, the application is limited to running under the Tomcat application server and the PostgreSQL database server.  These limitations will be be lifted in future releases.

# Installation Steps

These steps assume that you have installed the prerequisites.

1. Download and unzip the installation folder.
1. Create the databases.
  1. Login to PostgreSql.  Pass to the -U switch the user appropriate to your environment: psql -U postgres -W
  1. CREATE DATABASE inav_staging;
  1. CREATE USER inav_staging WITH CREATEDB PASSWORD 'inav_staging';
  1. ALTER DATABASE inav_staging OWNER TO inav_staging;
  1. ALTER USER inav_staging SUPERUSER;
1. Hello world.