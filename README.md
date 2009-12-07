# The Inflection Navigator

A patient receives a serious diagnosis from his or her physician. The physician instructs the patient to setup 3 tests, see 2 specialists and read material on the condition -- all within 2 weeks.

- This 'Inflection Point' in the patient's health requires a lot of effort and coordination.  But, what if the patient's clinic designated a "Navigator" to guide the patient through these activities.
- The Navigator follows a protocol tailored to the patient's diagnosis and ensures the protocol is completed in a timely and efficient manner.
- Each patient diagnosis requires the Navigator to manage a distinct set of activities within a scheduled time frame.

Ideally, the Navigator would have a web-based tool that assists them in:

- Applying a consistent protocol of activities to each patient based on their diagnosis.
- Managing each patient's progress in completing the protocol.
- Tracking and detailing the outcome of each patient.

We have built such a tool -- the Inflection Navigator.

# Technical Architecture

The Inflection Navigator is hybrid of two applications:

1. A light-weight patient and provider registry written in Ruby on Rails.
1. A protocol and patient-calendar management java web application utilizing the Patient Study Calendar -- a National Cancer Institute caBIG® open source software application.

Despite this hybrid architecture, a shared look and feel, inter-application communication via RESTful API calls and the implementation of the single sign on Central Authentication Service protocol make the application feel like a unified application.

In addition to the two core applications, the installation download folder contains two additional applications:

1.  A copy of the ESUP CAS Server configured to authenticate against a non-encrypted, file-based store of users.  This configuration should only be used for demonstration purposes.  For a production deployment, it should be replaced by an existing  CAS sever or be reconfigured to authenticated against a a secure store of users.  See [http://esup-casgeneric.sourceforge.net/install.html ](http://esup-casgeneric.sourceforge.net/install.html) for further details.
1.  A proxy call back application to enable the patient/provider Ruby on Rails application to make CAS proxy calls to the Patient Study Calendar.  See the documentation for the RubyCAS-Client for further an explanation of the necessity of running a separate Rails application to enable a Rails application to act as a CAS proxy: [http://rubycas-client.rubyforge.org/](http://rubycas-client.rubyforge.org/)

# Source Code

All of the source code for the application is contained within its download installation folder but the official URLs for the application's components can be found at the following locations:

- The patient/provider registry Ruby on Rails application.  Available at: [http://github.com/mgurley/inav](http://github.com/mgurley/inav)
- The protocol and patient-calendar management java web application -- the Patient Study Calendar.  Available at: [http://gforge.nci.nih.gov/frs/?group_id=31](http://gforge.nci.nih.gov/frs/?group_id=31)
- The CAS proxy callback application.  Available at: [(http://github.com/mgurley/cas_callback](http://github.com/mgurley/cas_callback)
- Jasig Cas Server and the CAS Generic Handler: a generic authentication handler for CAS (Central Authentication Service).  Available at: [http://esup-casgeneric.sourceforge.net/index.html](http://esup-casgeneric.sourceforge.net/index.html)

# Installation Prerequisites

- Java SE Development Kit	JDK 5.0.  The Java SE development kit with JRE, compilers and debuggers  Available at: http://java.sun.com/javase/downloads/index.jsp
- Apache Tomcat 5.5.17 or higher.  Application servlet container for JSP.  Available at: http://tomcat.apache.org/download-55.cgi
- PostgreSQL 8.3.4 or higher.  Database server.  Available at: http://www.postgresql.org/download/
- Jruby 1.4.0 or higher.  Java-implementation of the Ruby programming language.  Available at: http://jruby.org/download

Currently, the application is limited to running under Apache and PostgreSQL.  This limitation will be be lifted in future releases.

# Installation Steps

These steps assume that you have installed the installation perquisites.

1. Create the databases.
1. Download and unzip the installation folder.
