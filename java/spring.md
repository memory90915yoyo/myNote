# 簡介


----

# Create Project

![spring](https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcT7BegJ6h8NI3Yx8HSUGcGrv0A3lKnTRRf-POvoaxXnBw4SQ69A)

## via Maven

```
Linux:~$ mvn archetype:generate -DgroupId=com.mycls -DartifactId=sping-example -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
Linux:~ $ cd sping-example
Linux:~/spring-example:~ $ tree
.
├── pom.xml
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── mycls
    │               └── App.java
    └── test
        └── java
            └── com
                └── mycls
                    └── AppTest.java

Linux:~/spring-example:~ $ vi pom.xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycls</groupId>
  <artifactId>sping-example</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>sping-example</name>
  <url>http://maven.apache.org</url>

  <properties>
    <spring.version>4.1.6.RELEASE</spring.version>
  </properties>

  <dependencies>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-core</artifactId>
      <version>${spring.version}</version>
    </dependency>

    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-context</artifactId>
      <version>${spring.version}</version>
    </dependency>

    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
</project>

Linux:~/spring-example:~ $ vi src/main/java/com/mycls/HelloWorld.java
package com.mycls;

public class HelloWorld {
	private String name;

	public void setName(String name) {
		this.name = name;
	}

	public void printHello() {
		System.out.println("Spring: Hello! " + name);
	}
}

Linux:~/spring-example:~ $ mkdir -p src/main/resources
Linux:~/spring-example:~ $ src/main/resources/SpringBeans.xml
<beans xmlns="http://www.springframework.org/schema/beans"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.springframework.org/schema/beans
  http://www.springframework.org/schema/beans/spring-beans.xsd">

<bean id="helloBean" class="com.mycls.HelloWorld">
  <property name="name" value="MMmm" />
  </bean>
</beans>

Linux:~/spring-example:~ $ vi src/main/java/com/mycls/App.java
package com.mycls;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class App {
	public static void main( String[] args ) {
		ApplicationContext context = new ClassPathXmlApplicationContext("SpringBeans.xml");
		HelloWorld obj = (HelloWorld) context.getBean("helloBean");
		obj.printHello();
	}
}

Linux:~/spring-example:~ $ tree
.
├── pom.xml
└── src
    ├── main
    │   ├── java
    │   │   └── com
    │   │       └── mycls
    │   │           ├── App.java
    │   │           └── HelloWorld.java
    │   └── resources
    │       └── SpringBeans.xml
    └── test
        └── java
            └── com
                └── mycls
                    └── AppTest.java

Linux:~/spring-example:~ $ mvn package
Linux:~/spring-example:~ $ mvn exec:java -Dexec.mainClass=com.mycls.App
```

## via Gradle

```
Linux:~ $ mkdir spring-project
Linux:~ $ cd spring-project
Linux:~/spring-project:~ $ gradle init --type java-library
Linux:~/spring-project:~ $ tree 
.
├── build.gradle
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
├── gradlew.bat
├── settings.gradle
└── src
    ├── main
    │   └── java
    │       └── Library.java
    └── test
        └── java
            └── LibraryTest.java

Linux:~/spring-project:~ $ vi build.gradle
apply plugin: 'java'
apply plugin: 'application'

mainClassName = mainClass

jar {
    baseName = 'spring-project'
    version =  '1.0.0-SNAPSHOT'
}

repositories {
    jcenter()
    mavenLocal()
    mavenCentral()
}

dependencies {
    compile 'org.slf4j:slf4j-api:1.7.21'
    compile("org.springframework:spring-context:${springVersion}")

    testCompile 'junit:junit:4.12'
}
Linux:~/spring-project:~ $ vi gradle.properties 
springVersion=4.1.6.RELEASE

Linux:~/spring-project $ mkdir -p src/main/java/com/mycls
Linux:~/spring-project $ vi src/main/java/com/mycls/HelloWorld.java
package com.mycls;

public class HelloWorld {
	private String name;

	public void setName(String name) {
		this.name = name;
	}

	public void printHello() {
		System.out.println("Spring: Hello! " + name);
	}
}

Linux:~/spring-project:~ $ mkdir -p src/main/resources
Linux:~/spring-project:~ $ vi src/main/resources/SpringBeans.xml
<beans xmlns="http://www.springframework.org/schema/beans"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.springframework.org/schema/beans
  http://www.springframework.org/schema/beans/spring-beans.xsd">

<bean id="helloBean" class="com.mycls.HelloWorld">
  <property name="name" value="MMmm" />
  </bean>
</beans>

Linux:~/spring-project:~ $ vi src/main/java/com/mycls/App.java
package com.mycls;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class App {
	public static void main( String[] args ) {
		ApplicationContext context = new ClassPathXmlApplicationContext("SpringBeans.xml");
		HelloWorld obj = (HelloWorld) context.getBean("helloBean");
		obj.printHello();
	}
}

Linux:~/spring-project:~ $ gradle jar
Linux:~/spring-project:~ $ gradle -PmainClass=com.mycls.App run
```

## via Eclipse

## via IntelliJ


----

# Dependency Injection


## Origin

```
Linux:~ $ mkdir bean1
Linux:~ $ cd bean1
Linux:~/bean1 $ gradle init --type java-library
Linux:~/bean1 $ mkdir -p src/main/java/com/mycls
Linux:~/bean1 $ mkdir -p src/test/java/com/mycls

Linux:~/bean1 $ vi src/main/java/com/mycls/MediaPlayer.java
package com.mycls;

public interface MediaPlayer {
  void play();
}

Linux:~/bean1 $ vi src/main/java/com/mycls/CompactDisc.java
package com.mycls;

public interface CompactDisc {
  void play();
}

Linux:~/bean1 $ vi src/main/java/com/mycls/CDPlayer.java
package com.mycls;

public class CDPlayer implements MediaPlayer{
  private CompactDisc cd;

  public CDPlayer(CompactDisc cd) {
    this.cd = cd;
  }

  @Override
  public void play() {
    cd.play();
  }
}

Linux:~/bean1 $ vi src/main/java/com/mycls/EasonChan.java
package com.mycls;

public class EasonChan implements CompactDisc{
    @Override
    public void play() {
        System.out.println("Eason Chan Album");
    }
}

Linux:~/bean1 $ vi src/test/java/com/mycls/CDPlayerTest.java
package com.mycls;

import static org.junit.Assert.*;
import org.junit.Rule;
import org.junit.Test;

import org.junit.contrib.java.lang.system.StandardOutputStreamLog;

public class CDPlayerTest {
    private CompactDisc cd = new EasonChan();
    private MediaPlayer player = new CDPlayer(cd);

    @Rule
    public final StandardOutputStreamLog log = new StandardOutputStreamLog();

    @Test
    public void play() {
        player.play();
        assertEquals("Eason Chan Album\n", log.getLog());
    }
}

Linux:~/bean1 $ vi build.gradle
group 'com.mycls'
version '1.0-SNAPSHOT'

apply plugin: 'java'

repositories {
    mavenCentral()
}

dependencies {
    testCompile group: 'junit', name: 'junit', version: '4.12'
    testCompile group: 'com.github.stefanbirkner', name: 'system-rules', version: '1.2.0'
}

Linux:~/bean1 $ gradle test
```


## XML

```
Linux:~ $ mkdir bean2
Linux:~ $ cd bean2
Linux:~/bean2 $ gradle init --type java-library
Linux:~/bean2 $ mkdir -p src/main/java/com/mycls
Linux:~/bean2 $ mkdir -p src/main/resources
Linux:~/bean2 $ mkdir -p src/test/java/com/mycls

Linux:~/bean2 $ vi src/main/java/com/mycls/MediaPlayer.java
package com.mycls;

public interface MediaPlayer {
  void play();
}

Linux:~/bean2 $ vi src/main/java/com/mycls/CompactDisc.java
package com.mycls;

public interface CompactDisc {
  void play();
}

Linux:~/bean2 $ vi src/main/java/com/mycls/CDPlayer.java
package com.mycls;

public class CDPlayer implements MediaPlayer{
  private CompactDisc cd;

  public CDPlayer(CompactDisc cd) {
    this.cd = cd;
  }

  @Override
  public void play() {
    cd.play();
  }
}

Linux:~/bean2 $ vi src/main/java/com/mycls/EasonChan.java
package com.mycls;

public class EasonChan implements CompactDisc{
    @Override
    public void play() {
        System.out.println("Eason Chan Album");
    }
}

Linux:~/bean2 $ vi src/main/resources/Bean.xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans.xsd">
    <!-- Definition for outter bean using inner bean -->
    <bean id="cdPlayer" class="com.mycls.CDPlayer">
        <constructor-arg name="cd">
            <bean id="easonChan" class="com.mycls.EasonChan" />
        </constructor-arg>
    </bean>
</beans>

Linux:~/bean2 $ vi src/test/java/com/mycls/CDPlayerTest.java
package com.mycls;

import static org.junit.Assert.*;
import org.junit.Rule;
import org.junit.Test;
import org.junit.contrib.java.lang.system.StandardOutputStreamLog;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class CDPlayerTest {
    private ApplicationContext context = new ClassPathXmlApplicationContext("Bean.xml");
    private MediaPlayer player = (CDPlayer) context.getBean("cdPlayer");

    @Rule
    public final StandardOutputStreamLog log = new StandardOutputStreamLog();

    @Test
    public void play() {
        player.play();
        assertEquals("Eason Chan Album\n", log.getLog());
    }
}

Linux:~/bean2 $ vi build.gradle
group 'com.mycls'
version '1.0-SNAPSHOT'

apply plugin: 'java'

repositories {
    mavenCentral()
}

dependencies {
    compile group: 'org.springframework', name: 'spring-context', version: '4.1.6.RELEASE'

    testCompile group: 'junit', name: 'junit', version: '4.12'
    testCompile group: 'com.github.stefanbirkner', name: 'system-rules', version: '1.2.0'
}

Linux:~/bean3 $ gradle test
```

### XML with autowaire

```
Linux:~ $ mkdir bean3
Linux:~ $ cd bean3
Linux:~/bean3 $ gradle init --type java-library
Linux:~/bean3 $ mkdir -p src/main/java/com/mycls
Linux:~/bean3 $ mkdir -p src/main/resources
Linux:~/bean3 $ mkdir -p src/test/java/com/mycls

Linux:~/bean3 $ vi src/main/java/com/mycls/MediaPlayer.java
package com.mycls;

public interface MediaPlayer {
  void play();
}

Linux:~/bean3 $ vi src/main/java/com/mycls/CompactDisc.java
package com.mycls;

public interface CompactDisc {
  void play();
}

Linux:~/bean3 $ vi src/main/java/com/mycls/CDPlayer.java
package com.mycls;

public class CDPlayer implements MediaPlayer{
  private CompactDisc cd;

  public CDPlayer(CompactDisc cd) {
    this.cd = cd;
  }

  @Override
  public void play() {
    cd.play();
  }
}

Linux:~/bean3 $ vi src/main/java/com/mycls/EasonChan.java
package com.mycls;

public class EasonChan implements CompactDisc{
    @Override
    public void play() {
        System.out.println("Eason Chan Album");
    }
}

Linux:~/bean3 $ vi src/main/resources/Bean.xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans.xsd">
    <!-- Definition for bean using autowire -->
    <bean id="cdPlayer" class="com.mycls.CDPlayer" autowire="constructor"></bean>
    <bean id="easonChan" class="com.mycls.EasonChan"></bean>
</beans>

Linux:~/bean3 $ vi src/test/java/com/mycls/CDPlayerTest.java
package com.mycls;

import static org.junit.Assert.*;
import org.junit.Rule;
import org.junit.Test;
import org.junit.contrib.java.lang.system.StandardOutputStreamLog;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import org.junit.contrib.java.lang.system.StandardOutputStreamLog;

public class CDPlayerTest {
    private ApplicationContext context = new ClassPathXmlApplicationContext("Bean.xml");
    private MediaPlayer player = (CDPlayer) context.getBean("cdPlayer");

    @Rule
    public final StandardOutputStreamLog log = new StandardOutputStreamLog();

    @Test
    public void play() {
        player.play();
        assertEquals("Eason Chan Album\n", log.getLog());
    }
}

Linux:~/bean3 $ vi build.gradle
group 'com.mycls'
version '1.0-SNAPSHOT'

apply plugin: 'java'

repositories {
    mavenCentral()
}

dependencies {
    compile group: 'org.springframework', name: 'spring-context', version: '4.1.6.RELEASE'

    testCompile group: 'junit', name: 'junit', version: '4.12'
    testCompile group: 'com.github.stefanbirkner', name: 'system-rules', version: '1.2.0'
}

Linux:~/bean3 $ gradle test
```


### XML with autowaire annotation

```
Linux:~ $ mkdir bean4
Linux:~ $ cd bean4
Linux:~/bean4 $ gradle init --type java-library
Linux:~/bean4 $ mkdir -p src/main/java/com/mycls
Linux:~/bean4 $ mkdir -p src/main/resources
Linux:~/bean4 $ mkdir -p src/test/java/com/mycls

Linux:~/bean4 $ vi src/main/java/com/mycls/MediaPlayer.java
package com.mycls;

public interface MediaPlayer {
  void play();
}

Linux:~/bean4 $ vi src/main/java/com/mycls/CompactDisc.java
package com.mycls;

public interface CompactDisc {
  void play();
}

Linux:~/bean4 $ vi src/main/java/com/mycls/CDPlayer.java
package com.mycls;

import org.springframework.beans.factory.annotation.Autowired;

public class CDPlayer implements MediaPlayer{
  private CompactDisc cd;

  @Autowired
  public CDPlayer(CompactDisc cd) {
    this.cd = cd;
  }

  @Override
  public void play() {
    cd.play();
  }
}

Linux:~/bean4 $ vi src/main/java/com/mycls/EasonChan.java
package com.mycls;

import org.springframework.stereotype.Component;

@Component
public class EasonChan implements CompactDisc{
    @Override
    public void play() {
        System.out.println("Eason Chan Album");
    }
}

Linux:~/bean4 $ vi src/main/resources/Bean.xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans.xsd">
    <!-- Definition for bean using autowire annotation -->
    <context:component-scan base-package="com.mycls" />
    <bean id="cdPlayer" class="com.mycls.CDPlayer"></bean>
</beans>

Linux:~/bean4 $ vi src/test/java/com/mycls/CDPlayerTest.java
package com.mycls;

import static org.junit.Assert.*;
import org.junit.Rule;
import org.junit.Test;
import org.junit.contrib.java.lang.system.StandardOutputStreamLog;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import org.junit.contrib.java.lang.system.StandardOutputStreamLog;

public class CDPlayerTest {
    private ApplicationContext context = new ClassPathXmlApplicationContext("Bean.xml");
    private MediaPlayer player = (CDPlayer) context.getBean("cdPlayer");

    @Rule
    public final StandardOutputStreamLog log = new StandardOutputStreamLog();

    @Test
    public void play() {
        player.play();
        assertEquals("Eason Chan Album\n", log.getLog());
    }
}

Linux:~/bean4 $ vi build.gradle
group 'com.mycls'
version '1.0-SNAPSHOT'

apply plugin: 'java'

repositories {
    mavenCentral()
}

dependencies {
    compile group: 'org.springframework', name: 'spring-context', version: '4.1.6.RELEASE'

    testCompile group: 'junit', name: 'junit', version: '4.12'
    testCompile group: 'com.github.stefanbirkner', name: 'system-rules', version: '1.2.0'
}

Linux:~/bean4 $ gradle test
```


## JavaConfig

```
Linux:~ $ mkdir bean5
Linux:~ $ cd bean5
Linux:~/bean5 $ gradle init --type java-library
Linux:~/bean5 $ mkdir -p src/main/java/com/mycls
Linux:~/bean5 $ mkdir -p src/test/java/com/mycls

Linux:~/bean5 $ vi src/main/java/com/mycls/MediaPlayer.java
package com.mycls;

public interface MediaPlayer {
  void play();
}

Linux:~/bean5 $ vi src/main/java/com/mycls/CompactDisc.java
package com.mycls;

public interface CompactDisc {
  void play();
}

Linux:~/bean5 $ vi src/main/java/com/mycls/CDPlayer.java
package com.mycls;

public class CDPlayer implements MediaPlayer{
  private CompactDisc cd;

  public CDPlayer(CompactDisc cd) {
    this.cd = cd;
  }

  @Override
  public void play() {
    cd.play();
  }
}

Linux:~/bean5 $ vi src/main/java/com/mycls/EasonChan.java
package com.mycls;

public class EasonChan implements CompactDisc{
    @Override
    public void play() {
        System.out.println("Eason Chan Album");
    }
}

Linux:~/bean5 $ vi src/main/java/com/mycls/CDPlayerConfig.java
package com.mycls;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.annotation.Bean;

@Configurable
public class CDPlayerConfig {
    @Bean
    private CompactDisc easonChan() {
        return new EasonChan();
    }

    @Bean
    public CDPlayer cdPlayer() {
        return new CDPlayer(easonChan());
    }
}

Linux:~/bean5 $ vi src/test/java/com/mycls/CDPlayerTest.java
package com.mycls;

import static org.junit.Assert.*;
import org.junit.Rule;
import org.junit.Test;
import org.junit.contrib.java.lang.system.StandardOutputStreamLog;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class CDPlayerTest {
    ApplicationContext context = new AnnotationConfigApplicationContext(CDPlayerConfig.class);
    private MediaPlayer player= (CDPlayer) context.getBean("cdPlayer");

    @Rule
    public final StandardOutputStreamLog log = new StandardOutputStreamLog();

    @Test
    public void play() {
        player.play();
        assertEquals("Eason Chan Album\n", log.getLog());
    }
}

Linux:~/bean5 $ vi build.gradle
group 'com.mycls'
version '1.0-SNAPSHOT'

apply plugin: 'java'

repositories {
    mavenCentral()
}

dependencies {
    compile group: 'org.springframework', name: 'spring-context', version: '4.1.6.RELEASE'

    testCompile group: 'junit', name: 'junit', version: '4.12'
    testCompile group: 'com.github.stefanbirkner', name: 'system-rules', version: '1.2.0'
}

Linux:~/bean5 $ gradle test
```


### JavaConfig with autowaire